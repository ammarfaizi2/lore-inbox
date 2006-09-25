Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751498AbWIYWEe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751498AbWIYWEe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Sep 2006 18:04:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751499AbWIYWEe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Sep 2006 18:04:34 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:45546 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751498AbWIYWEd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Sep 2006 18:04:33 -0400
Date: Tue, 26 Sep 2006 00:04:26 +0200
From: Pavel Machek <pavel@ucw.cz>
To: John Richard Moser <nigelenki@comcast.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Swap on Fuse deadlocks?
Message-ID: <20060925220426.GA2546@elf.ucw.cz>
References: <45184D88.1010203@comcast.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45184D88.1010203@comcast.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2006-09-25 17:43:36, John Richard Moser wrote:
> I just tried to set up an LZOlayer swap partition:
> 
> http://north.one.pl/~kazik/pub/LZOlayer/
> 
> The layout was as such:
> 
> /tmp/swap_base  - tmpfs (run1), disk (run2)
> /tmp/swap - lzolayer swap_base
> /tmp/swap/swap0 - 200M swap file
> /dev/loop0 - /tmp/swap/swap0 loopback
> 
> I turned on loop0, crept anywhere over 10 megs into swap and it seized
> up (otherwise it was fine).  This happened in both run1 (swap on tmpfs)
> and run2 (swap on disk).
> 
> The swap on tmpfs I can understand; it'll essentially loop trying to
> allocate new swap, swap in and out parts of the swap file to itself, and
> eventually hit a condition where it's trying to swap an area of the swap
> file into itself, creating an infinite loop.
> 
> Swap on disk I don't get.  A little slow perhaps due to the LZO or zlib
> compression in the middle (lzolayer lets you pick either); but a total
> freeze?  What's wrong here, is lzo_fs data getting swapped out and then
> not swapped in because it's needed to decompress itself?

Yes, possibly. Or maybe lzo_fs needs  to allocate memory and kernel
decides it needs to swap for that?

It is miracle that fuse works for normal write, do not expect it to
work for swap. (Does it even work mmap-ed writes?)
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
