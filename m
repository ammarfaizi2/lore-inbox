Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264044AbTJ1Q6Q (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Oct 2003 11:58:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264047AbTJ1Q6Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Oct 2003 11:58:16 -0500
Received: from adsl-63-194-133-30.dsl.snfc21.pacbell.net ([63.194.133.30]:64640
	"EHLO penngrove.fdns.net") by vger.kernel.org with ESMTP
	id S264044AbTJ1Q6P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Oct 2003 11:58:15 -0500
From: John Mock <kd6pag@qsl.net>
To: Kovacs@vger.kernel.org, Richard@vger.kernel.org (krichard@elte.hu)
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: re: ACPI suspend doe snot work when X is running
Message-Id: <E1AEXB3-00029O-00@penngrove.fdns.net>
Date: Tue, 28 Oct 2003 08:58:41 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

That's right, X running in native mode with a i830 double-faults (or
auto-reboots) upon resume with software suspend under 2.5 and 2.6.0 
not sure about 2.4 yet).  

Try a kernel with 'vesafb' [CONFIG_FB_VESA=y] and/or use an XF86Config-4
with 'Section "Device"... Driver "vesa"' (or maybe 'Driver "fbdev"').  
Alas, that only works at 256 colors at 1024x768 for me, as i only have 
832K available for direct frame buffer access in VESA mode.  But it 
looks like you have 8060K available, so you should be able to do full 
color at 1600x1200.  Yeah, acceleration would be nice...  

You may need to 'rmmod uhci-hcd' before hibernating, which may not be 
compatible with some USB devices (like those involving SCSI emulation,
like flash memory and digital cameras).  Your CD/RW is IDE rather than 
firewire, so that looks good as well.  It seems like software suspend
may have a decent chance of work adequately for you.  I wish i were as
lucky...  Good luck!
				   -- JM
