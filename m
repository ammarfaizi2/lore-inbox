Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276014AbRI1LjR>; Fri, 28 Sep 2001 07:39:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276016AbRI1LjG>; Fri, 28 Sep 2001 07:39:06 -0400
Received: from artemis.rus.uni-stuttgart.de ([129.69.1.28]:38288 "EHLO
	artemis.rus.uni-stuttgart.de") by vger.kernel.org with ESMTP
	id <S276014AbRI1Liy>; Fri, 28 Sep 2001 07:38:54 -0400
Message-ID: <3BB4614C.500D04AA@hlrs.de>
Date: Fri, 28 Sep 2001 13:38:52 +0200
From: Rainer Keller <Keller@hlrs.de>
Organization: Rechenzentrum =?iso-8859-1?Q?Universit=E4t?= Stuttgart
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.9 i686)
X-Accept-Language: de, en
MIME-Version: 1.0
To: Balazs Scheidler <bazsi@balabit.hu>, linux-kernel@vger.kernel.org
Subject: reproducible bug in 2.2.19 & 2.4.x
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Balazs,

Well, reading & running (on UP, no SIGSEGVs) Your code, I get the
impression, that there might be a small bug in it.

Your while-loop looks like this:
 while (1)
    {
      int newfd;
      int tmplen;
      pthread_t t;
      tmplen = sizeof(sin);
      newfd = accept(fd, (struct sockaddr *) &sin, &tmplen);
      ...
      pthread_create(&t, NULL, thread_func, &newfd);
   }

Now, if the thread_func is not started immediately on Your SMP-machine,
the next iteration of the loop might already have started the accept
with a new file-descriptor, leaving two threads reading on the same fd.

This should be per-thread data.

Just my 2 cents.

Greetings,
raY

