Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263585AbUECF7j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263585AbUECF7j (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 May 2004 01:59:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263588AbUECF7j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 May 2004 01:59:39 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:7874 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263585AbUECF7h
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 May 2004 01:59:37 -0400
Date: Mon, 3 May 2004 06:59:34 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Rene Herman <rene.herman@keyaccess.nl>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] removal of legacy cdrom drivers (Re: [PATCH] mcdx.c insanity removal)
Message-ID: <20040503055934.GA17014@parcelfarce.linux.theplanet.co.uk>
References: <20040502024637.GV17014@parcelfarce.linux.theplanet.co.uk> <Pine.LNX.4.58.0405011953140.18014@ppc970.osdl.org> <20040503011629.GY17014@parcelfarce.linux.theplanet.co.uk> <4095BAA3.3050000@keyaccess.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4095BAA3.3050000@keyaccess.nl>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 03, 2004 at 05:21:07AM +0200, Rene Herman wrote:
> I do actually still use two of these drives. An actual soundblaster 
> connected "sbpcd" drive (which sits in a 386, and given the fact that 
> the new init-module-tools didn't compile against libc5 I haven't tested 
> it modular there yet -- builtin it doesn't work) and a "Pro Audio 
> Spectrum" connected "cdu31a" which does work. Most of the time. When the 
> timing is just right, it even allows me to mount cd-roms:

OK...  So we have
	* potentially faulty mcdx (2.4, apparently either driver corrupts
memory in some conditions or isofs does the same for some IO failures -
need to take a look at that report more carefully).
	* cdu31a (FUBAR driver, nasty to fix, "most of the time" works on
2.6)
	* sbpcd (at least two, both untested with 2.6)

> Hope this qualifies a bit. Must say that one of the things I appreciate 
> about Linux is that all this old gunk I have lying about (in fact, still 
> drag in from time to time) is actually supported. Or "supported".
> 
> Would it be good to have a CONFIG_LEGACY alongside CONFIG_EXPERIMENTAL 
> and friends and dump all this crap into drivers/legacy/cdrom, where it 
> wouldn't distract serious people?

	Is anybody willing to fix those drivers?  'Cause I'm _not_ taking
sbpcd.c, thank you very much - I've played with it for a while, but this
sucker is a testing nightmare.  It is a bunch of drivers for different
models mostly ifdefed together.  Take problems with Becker's netdev drivers,
multiply by plenty and add the fact that while Becker definitely knows C,
sbpcd author doesn't.  floppy.c is cleaner than that beast; come to think
of that, so are toilets on most of the bus stations.

	cdu31a, BTW, still uses cli(), schedules under queue lock and uses
timers in very interesting way.  And that's just from the first look...
