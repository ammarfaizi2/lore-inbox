Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316322AbSH0P3w>; Tue, 27 Aug 2002 11:29:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316342AbSH0P3w>; Tue, 27 Aug 2002 11:29:52 -0400
Received: from host169.digeo.com ([12.110.81.169]:1157 "EHLO
	khem.blackfedora.com") by vger.kernel.org with ESMTP
	id <S316322AbSH0P3v>; Tue, 27 Aug 2002 11:29:51 -0400
To: linux-kernel@vger.kernel.org
Subject: How can a process easily get a list of all it's open fd?
From: Mark Atwood <mra@pobox.com>
Date: 27 Aug 2002 08:34:04 -0700
In-Reply-To: <200208270138.g7R1ckGx001985@eeyore.valparaiso.cl>
Message-ID: <m38z2s1fkj.fsf@khem.blackfedora.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I need to close all the none std[in|out|err] open fd's.

I've been told to do it like so:

  {
    int i;
    for (i=3; i<OPEN_MAX; i++)
      close(i);
  }

This is very slow, plus I have discovered that I can have open fd's with
values greater than OPEN_MAX.

I thought about getting the max fd from rlimit, but that doesn't work
either.  Say I have a rlimit of 1024 open fd's, and I open numbers 3
thru 1023, then I close 3 thru 1022, then I set the rlimit down to
16. rlimit then returns 16, but the largest open fd is still 1023.

So that doesn't work.

And I still have the problem that looping between 3 and whatever I pick
as the top and calling close on each in turn is very slow.

So what's the "right way" to do it?

I would *love* for there to be an ioctl or some syscall that I could
pass a pointer to an int and a pointer to an int array, and it would
come back telling me how many open fd's I've got, and fill in the
array with those fd's.

-- 
Mark Atwood   | Well done is better than well said.
mra@pobox.com | 
http://www.pobox.com/~mra
