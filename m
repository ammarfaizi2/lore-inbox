Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310206AbSCAKIo>; Fri, 1 Mar 2002 05:08:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310151AbSCAKEr>; Fri, 1 Mar 2002 05:04:47 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:45580 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S310434AbSCAKAF>; Fri, 1 Mar 2002 05:00:05 -0500
Date: Fri, 1 Mar 2002 10:59:07 +0100
From: Pavel Machek <pavel@suse.cz>
To: "Jose' Manuel Pereira" <jmp@ist.utl.pt>
Cc: swsusp@lister.fornax.hu, kernel list <linux-kernel@vger.kernel.org>
Subject: Re: 2.2.18/swsusp bugs
Message-ID: <20020301095907.GB10619@atrey.karlin.mff.cuni.cz>
In-Reply-To: <200202201702.g1KH2YR05704@fuji.home.perso> <15477.26769.969651.333984@saladd2.ist.utl.pt> <20020222020202.GC30638@atrey.karlin.mff.cuni.cz> <15478.33963.155227.154314@saladd2.ist.utl.pt> <20020222185606.GC1351@atrey.karlin.mff.cuni.cz> <15478.49275.3087.824024@saladd2.ist.utl.pt> <20020223212820.GA943@elf.ucw.cz> <15485.22755.869916.466453@saladd2.ist.utl.pt> <20020228101705.GE4760@atrey.karlin.mff.cuni.cz> <15486.52695.972327.496962@saladd2.ist.utl.pt>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15486.52695.972327.496962@saladd2.ist.utl.pt>
User-Agent: Mutt/1.3.24i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

>   >> Alright, but provided that trying to resume from a non-suspend swap
>   >> doesn't crash anything...
> 
>   PM> Do you stop all user processes before doing resume, for example?
> 
> (Different subject, hey?-). No, I don't. At the point I do (and recommend to)
> swapon is during early init processing. There are no user processes at that
> point. If they are, they disappear in thin air at that point...
> 
> But I already gave up, I agree w/your method. But remember that people will
> boot resume=/bla even when they have no swap to resume from. Just a lilo thing,
> unavoidable.
> 
>   PM> But that might be problem at resume. Imagine uhci has buffers at
>   PM> 0x12345678, but in image being resumed, /bin/bash is at 0x12345678. Then
>   PM> you have a problem.
> 
> Nope, that can't happen. uhci and bash had their pages neatly restored...
> Wait! Are you saying you start uhci/netdrivers/enable interrupts BEFORE
> resuming?? Nonono! Forbidden! Disk corruption, or your computer may
> explode!

But you were running uhci/netdrivers before resuming, too, right?

How I'm going to solve this is to introduce "stop" callback to all
device drivers. NOte: I have to enable DMA/interrupts BEFORE resuming
-- I acutally need interrupts for reading from disk, and I *may* need
uhci/DMA for resuming, too. (I actually did
resume=/dev/zip_drive_on_usb. Worked at one point.)

>   PM> [swsusp list no longer works, doing cc to l-k.]
> 
> So it seems. It didn't bounce yesterday, but didn't get a response. OTOH, l-k
> isn't too busy a place to discuss swsusp? How about the ACPI list?

Okay, if you prefer.
								Pavel
-- 
Casualities in World Trade Center: ~3k dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.
