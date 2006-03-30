Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750967AbWC3IJ2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750967AbWC3IJ2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 03:09:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750949AbWC3IJ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 03:09:28 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:16574 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1750967AbWC3IJ1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 03:09:27 -0500
Date: Thu, 30 Mar 2006 10:09:20 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Linus Torvalds <torvalds@osdl.org>
cc: Andrew Morton <akpm@osdl.org>, Jens Axboe <axboe@suse.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH][RFC] splice support
In-Reply-To: <Pine.LNX.4.64.0603291624420.27203@g5.osdl.org>
Message-ID: <Pine.LNX.4.61.0603301003310.30783@yvahk01.tjqt.qr>
References: <20060329122841.GC8186@suse.de> <20060329143758.607c1ccc.akpm@osdl.org>
 <Pine.LNX.4.64.0603291624420.27203@g5.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> 
>> - splice() take a size_t length.  Should it be taking a 64-bit length?
>
>No. You can't splice more than the kernel buffers anyway (ie currently 
>PIPE_BUFFERS pages, ie ~64kB, although in theory somebody could use large 
>pages for it), so 64-bit would be total overkill.
>
So unsigned int would be enough, would not it?


>> - why is the `flags' arg to sys_splice() unsigned long?  Can it be `int'?
>
>flags are always unsigned long, haven't you noticed? [...]

On x86, an unsigned long holds 32 bit, so we can at most put 32 flags in a 
'flags' argument, even on x64 -- to stay compatible/deterministic/you know.
So it sounds like a good thing to make it 'unsigned int' rather than 
'unsigned long'. Saves stack space.


>> - All the operations do foo(in, out, ...).  It's a bit more conventional
>>   to do foo(out, in, ...).

man bzero(3)
man swab(3)
man bcopy(3)

It's not (out,in) everywhere. But there are also other extremes, like
outb() where (val,port) is rather confusing compared to the rest of the 
world (port,val).



Jan Engelhardt
-- 
