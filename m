Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262042AbUDCXbu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Apr 2004 18:31:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262060AbUDCXbu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Apr 2004 18:31:50 -0500
Received: from lakemtao05.cox.net ([68.1.17.116]:25282 "EHLO
	lakemtao05.cox.net") by vger.kernel.org with ESMTP id S262042AbUDCXbr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Apr 2004 18:31:47 -0500
Date: Sat, 3 Apr 2004 13:35:51 -0500
From: Chris Shoemaker <chris.shoemaker@cox.net>
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6.4] Bad swap file entry, then kernel BUG at mm/shmem.c:475
Message-ID: <20040403183551.GA1342@cox.net>
References: <20040401232734.GB8061@cox.net> <200404020838.09566.vda@port.imtp.ilyichevsk.odessa.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200404020838.09566.vda@port.imtp.ilyichevsk.odessa.ua>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 02, 2004 at 08:38:09AM +0300, Denis Vlasenko wrote:
> On Friday 02 April 2004 02:27, Chris Shoemaker wrote:
> > and I haven't found evidence of off-by-bit errors.  However, 2 days
> > running memtest86 with all tests, gave no errors.  (BTW, does anyone
> > have a suggestion of a more rigorous general hardware stress-test for
> > detecting flakiness?)  If my hardware is bad it's pretty intermittent
> 
> cpuburn.

  Thanks for the tip.  I ran burnBX, burnP5, and burnMMX overnight.  No 
problems at all.  But at least I'll know about cpuburn next time I want 
to test a CPU.

> 
> Also try to slightly underclock your hardware,
> downgrade DMA mode, etc (although it seems you use SCSI...).

  Actually, the SCSI drives aren't active.  root and swap are on a 13GB
Fujitsu IDE drive.  That got me thinking though...  it seems maybe there
is a common thread to my oopses.  I think they tend to happen during
disk i/o.  Either I'm loading a program, or closing X or even during
boot-up ( 3 times oopsed during boot now. ) -- all i/o activities.

  My disk is using udma2 mode, according to 'hdparm -I'.  I guess it's
getting set that way from the BIOS, which is set to Auto for the PIO/DMA
mode.  I'll follow your suggestion and try to force it lower in the
BIOS, but first I checked more carefully over the CONFIG options related
to IDE and found some things that maybe shouldn't have been set:

CONFIG_IDEDISK_MULTI_MODE=y
CONFIG_IDEDISK_STROKE=y
CONFIG_BLK_DEV_IDETAPE=m
CONFIG_IDE_TASK_IOCTL=y
CONFIG_IDE_TASKFILE_IO=y
CONFIG_BLK_DEV_IDEPNP=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_OFFBOARD=y
CONFIG_BLK_DEV_GENERIC=y
CONFIG_IDEDMA_ONLYDISK=y

	As far as I can tell, I don't really need any of those.  So, I 
disabled all of the above.  I'm running with this new config for a few 
hours now.  If it oopses, I'll try the lower dma mode.

-Chris

> 
> vda
