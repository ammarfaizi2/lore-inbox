Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315277AbSGUXkt>; Sun, 21 Jul 2002 19:40:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315279AbSGUXkt>; Sun, 21 Jul 2002 19:40:49 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:24076 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S315277AbSGUXks>; Sun, 21 Jul 2002 19:40:48 -0400
Date: Mon, 22 Jul 2002 00:43:53 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Ingo Molnar <mingo@elte.hu>
Cc: Christoph Hellwig <hch@lst.de>, Linus Torvalds <torvalds@transmeta.com>,
       linux-kernel@vger.kernel.org, Robert Love <rml@tech9.net>
Subject: Re: [patch] "big IRQ lock" removal, 2.5.27-A9
Message-ID: <20020722004353.S26376@flint.arm.linux.org.uk>
References: <20020721234619.A10561@lst.de> <Pine.LNX.4.44.0207212345490.29913-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0207212345490.29913-100000@localhost.localdomain>; from mingo@elte.hu on Sun, Jul 21, 2002 at 11:56:11PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 21, 2002 at 11:56:11PM +0200, Ingo Molnar wrote:
> there's even more ancient code in the block driver init path, eg. in
> drivers/block/ll_rw_blk.c:blk_dev_init():
> 
>         outb_p(0xc, 0x3f2);
> 
> i suspect this is ancient Linux code. 0x3f2 is one of the floppy
> controller ports - many modern x86 boxes do not even have a floppy
> controller! I've removed this from my tree as well - if this is needed at
> all then it belongs into the floppy driver.

Actually its to cover the case where you have a floppy drive, and you've
booted the kernel from a floppy disk, and the kernel doesn't have the
floppy driver built in.  It turns the floppy drive off, cause there's
nothing else to do that.

Obviously putting it in the floppy driver wouldn't be meaningful.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

