Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268129AbRGWCeg>; Sun, 22 Jul 2001 22:34:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268130AbRGWCe1>; Sun, 22 Jul 2001 22:34:27 -0400
Received: from mnh-1-13.mv.com ([207.22.10.45]:54538 "EHLO ccure.karaya.com")
	by vger.kernel.org with ESMTP id <S268129AbRGWCeK>;
	Sun, 22 Jul 2001 22:34:10 -0400
Message-Id: <200107230349.WAA04057@ccure.karaya.com>
X-Mailer: exmh version 2.0.2
To: Andrea Arcangeli <andrea@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.7pre8aa1 
In-Reply-To: Your message of "Mon, 23 Jul 2001 03:11:46 +0200."
             <20010723031146.D23517@athlon.random> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 22 Jul 2001 22:49:42 -0500
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

andrea@suse.de said:
> I should have said "compiles" fine (not "works" fine :). 

2.4.6 "works" fine :-)

I just finished fixing 2.4.7.  My fixes are similar to yours (I moved 
stext rather than moving .data.init).

> __initdata is broken in uml and the kernel deadlocks because the wait
> list is empty in complete() despite wait_for_completion actually
> registered correctly into it. This because wait_for_completion runs in
> a different address space than complete() and the virtual memory is
> not shared across the two address spaces (it is not rempped in a
> MAP_SHARED so it generates a cow). The registration is basically only
> private to the entity that is registrating and it will never get
> visible to the waker task that will do nothing. This is a severe bug
> not just for the completion code in 2.4.7.

Nice debugging, btw.  I spent an hour this morning chasing that problem.

My 2.4.7 patch is available from the usual places:

       http://ftp.nl.linux.org/pub/uml/uml-patch-2.4.7-1.bz2
       http://uml-pub.ists.dartmouth.edu/uml/uml-patch-2.4.7-1.bz2
       http://prdownloads.sourceforge.net/user-mode-linux/uml-patch-2.4.7-1.bz2

				Jeff

