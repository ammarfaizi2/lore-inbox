Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262993AbTJZJqM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Oct 2003 04:46:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263010AbTJZJqM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Oct 2003 04:46:12 -0500
Received: from adsl-63-194-133-30.dsl.snfc21.pacbell.net ([63.194.133.30]:14208
	"EHLO penngrove.fdns.net") by vger.kernel.org with ESMTP
	id S262993AbTJZJqI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Oct 2003 04:46:08 -0500
From: Tovar <tvr@penngrove.fdns.net>
To: linux-kernel@vger.kernel.org
Subject: 2.6.0-test9 better on VAIO R505EL and PowerMac 8500
Message-Id: <E1ADhTk-0000hY-00@penngrove.fdns.net>
Date: Sun, 26 Oct 2003 01:46:32 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Things look much better for me, 2.6.0-test9 seems pretty good for i386, and
looks encouraging for PPC.  Using the criterion posted with that release, i
don't have many outstanding issues.

Important issues for PowerMac 8500

  'drivers/block/swim3.c' is broken.  It does not compile and while a simple
	patch (see Bug #1370) cleans up the compilation, the driver doesn't
	seem to recognize the hardware.  Another patch exists which fixes 
	that, but it will need to evaluated by someone like 'benh' and is
	likely to be too complex for current 2.6.0 criteria.

  No other big issues for me, aside from a minor annoyance of losing video 
	sync switching from X back to a 'controlfb' framebuffer.

Minor issues include:

  The Mac SCSI drivers get quite a few compilation warnings, and one stack
	trace per drive at boot time, which don't seem to be fatal.

  Ejecting a CDROM seems to get a two or three instances of "slab error in
	cache_free_debugcheck()".

  If RAID5 is reconstructing parity, then when 'bootlogd' tries to start up, 
	everything stalls until reconstruction completes, making the machine
	appears to be hung in the meanwhile.

Important issues for Sony VAIO R505EL

  ohci1394/sbp2 is still broken and prevents CD/RW operations, but that is
	mostly patchable and will probably need to wait for 2.6.1 according 
	Linus' criterion.

  All other significant issues pertain to software suspend, and that being
	experimental, they can be ignored for 2.6.0 release.  

Minor issues include:

  The laptop 'power' button and the lid switch each give an identical
	"sleeping... from invalid context at mm/slab.c:1856"

  'serial_cs' tries to free IO ports twice (still looking at that one).

  'ide-cs.c' still uses MOD_INC_USE_COUNT and MOD_DEC_USE_COUNT (probably
	OK if you don't need to suspend).

So, much better than the last summary, but i'm not ready to run -test9 on 
the PPC unattended and i'm still stuck with Windows on the laptop if i'm 
not at home.  MOL is still untested.
					-- JM
