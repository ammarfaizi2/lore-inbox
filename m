Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262490AbRENVFm>; Mon, 14 May 2001 17:05:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262496AbRENVFc>; Mon, 14 May 2001 17:05:32 -0400
Received: from hera.cwi.nl ([192.16.191.8]:60905 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S262490AbRENVFR>;
	Mon, 14 May 2001 17:05:17 -0400
Date: Mon, 14 May 2001 23:05:13 +0200 (MET DST)
From: Andries.Brouwer@cwi.nl
Message-Id: <UTC200105142105.XAA09291.aeb@vlet.cwi.nl>
To: Andries.Brouwer@cwi.nl, alan@lxorguk.ukuu.org.uk
Subject: Re: Minor numbers
Cc: R.E.Wolff@bitwizard.nl, aqchen@us.ibm.com, linux-kernel@vger.kernel.org,
        torvalds@transmeta.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Im very interested in 32bit dev_t or at least implementing
> the 'lots of majors' half of it because we are probably
> going to need it in the 2.5 years before we have a 2.6

Yes, a larger dev_t has been desirable for a long time,
and more and more kludges are invented to work around its lack.
Still, changing this is fairly simple.

I firmly believe that we want to go to 64-bit. In case there
is an intermediate step, that means that it would have to be 16+16,
in order not to introduce complications later.

>> The system call itself cannot easily be changed to take a larger dev_t,
>> mostly because under old glibc the high order part would be random.

> Is that true or is it always happening to be clear ?

I wrote that talking about 64-bit dev_t. For 32-bit one might be
slightly more optimistic. The C calling conventions will widen a
short to an int, I suppose.
It is true however that older glibc does its best to make sure
the kernel doesnt see more than 16 bits:

  int
  __xmknod (int vers, const char *path, mode_t mode, dev_t *dev) {
	unsigned short int k_dev;
	k_dev = ((major (*dev) & 0xff) << 8) | (minor (*dev) & 0xff);
	return __syscall_mknod (path, mode, k_dev);
  }

Andries
