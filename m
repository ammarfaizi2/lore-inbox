Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266588AbRGTFT1>; Fri, 20 Jul 2001 01:19:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266586AbRGTFTS>; Fri, 20 Jul 2001 01:19:18 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:55564 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S266567AbRGTFTF>; Fri, 20 Jul 2001 01:19:05 -0400
Date: Thu, 19 Jul 2001 22:17:37 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
cc: Alexander Viro <viro@math.psu.edu>, "David S. Miller" <davem@redhat.com>,
        Andrea Arcangeli <andrea@suse.de>, Alan Cox <alan@redhat.com>,
        David Woodhouse <dwmw2@redhat.com>, <linux-scsi@vger.kernel.org>,
        Andrew Morton <andrewm@uow.edu.au>
Subject: 2.4.7-pre9..
Message-ID: <Pine.LNX.4.33.0107192208070.14141-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing


I'm getting ready to do a 2.4.7, but one of the fixes in 2.4.7 is a nasty
SMP race that was found and made it clear that using an old trick of
having a semaphore on the stack and doing "down()" on it to wait for some
event (that would do the "up()") was a really bad idea.

This kind of trick was used in the kernel vfork() implementation, and also
in block device "wait for request completion". I've fixed both with a new
and fairly simple "wait for completion" infrastructure, but I'd like
especially SCSI device driver writers to check their own drivers as a
result before I make the final 2.4.7.

I've changed all generic code, so drivers are all expected to compile and
work. However, some SCSI drivers use the semaphore trick in their own
code, and I've not mucked with that. It's not worth worrying about too
much, as the race is basically impossible to hit (famous last words), but
I wanted a heads-up and people to give it a quick look. I also wanted to
have people who actually have the hardware in question to verify that my
untested (but on the face of it obvious) changes are indeed working.

So please give it a quick spin,

		Linus

