Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278263AbRJMDvj>; Fri, 12 Oct 2001 23:51:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278264AbRJMDv3>; Fri, 12 Oct 2001 23:51:29 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:50703 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S278263AbRJMDvX>; Fri, 12 Oct 2001 23:51:23 -0400
From: Linus Torvalds <torvalds@transmeta.com>
Date: Fri, 12 Oct 2001 20:51:27 -0700
Message-Id: <200110130351.f9D3pRp08271@penguin.transmeta.com>
To: duncan.sands@math.u-psud.fr, Andrea Arcangeli <andrea@suse.de>,
        linux-kernel@vger.kernel.org, Al Viro <viro@redhat.com>
Subject: Re: xine pauses with recent (not -ac) kernels
Newsgroups: linux.dev.kernel
In-Reply-To: <01101300085600.00832@baldrick>
In-Reply-To: <01101208552800.00838@baldrick> <20011012161052.R714@athlon.random>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <01101300085600.00832@baldrick> you write:
>>
>> can you reproduce also on 2.4.12aa1?
>>
>> 	ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.12
>>aa1.bz2
>>
>> Andrea
>
>Yes, it seems to have the same problem.  It even seems a bit worse
>(just my impression, I didn't do any statistics).

Let me guess: xine opens the raw device, and does all the DVD parsing
from there. 

Furthermore, maybe it closes and re-opens the device for each VOB file. 

Which in turn will invalidate the buffer and page cache, and force a
re-read of all the metadata..  Oh, and wait for all the prefetching to
have finished.

If this is it, it should be "fixed" by doing a

	sleep 100000 < /dev/dvd-device &

in the background before starting xine?

Does that make any difference?

If it does, then I suspect we should really look into making the raw
device close just leave the device descriptor around at least for a
while. Al?

		Linus
