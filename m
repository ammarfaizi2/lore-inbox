Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264911AbTGCQC5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jul 2003 12:02:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264898AbTGCQC1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jul 2003 12:02:27 -0400
Received: from ausadmmsrr503.aus.amer.dell.com ([143.166.83.90]:1542 "HELO
	AUSADMMSRR503.aus.amer.dell.com") by vger.kernel.org with SMTP
	id S264432AbTGCQCJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jul 2003 12:02:09 -0400
X-Server-Uuid: 91331657-2068-4fb8-8b09-a4fcbc1ed29f
Message-ID: <36696BAFD8467644ABA0050BE358905912586B@ausx2kmpc106.aus.amer.dell.com>
From: Gary_Lerhaupt@Dell.com
To: linux-kernel@vger.kernel.org
Subject: [announce] dkms - enhancements for 2.5 + UnitedLinux initrd
 suppo rt
Date: Thu, 3 Jul 2003 11:16:26 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
X-WSS-ID: 131A89684767147-01-01
Content-Type: text/plain; 
 charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Following the handy pointers at
http://marc.theaimsgroup.com/?l=linux-ia64&m=105676403229397&w=2, dkms now
uses 2.5's makefile goodies.  Specifically, if it detects a kernel > 2.4, it
ignores any MAKE commands in the dkms.conf for your module and instead uses
`make -C $kernel_source_dir SUBDIRS=$build_dir modules`.  It also doesn't do
a make dep during the kernel prep (though for SuSE, I left the make
CONFIG_MODVERSION=1 dep for 2.5 since I didn't know whether it will be
needed).

I also added support for modifying SuSE/UnitedLinux initrds.  While this
already exists for RH type things, the mkinitrd stuff seems to vary per
distro.  For UL, if REMAKE_INITRD is set in the dkms.conf, during the `add`
it modifies /etc/sysconfig/kernel and puts a reference in INITRD_MODULES and
during the final remove it removes it from this list.  Then, as modules are
installed, it calls the generic mk_initrd command which remakes all the
initrds it seems to know about.  While this might return exit status 9 if
some kernels don't have this module, this process seems the best and
simplest way to go about automating the initrd process for UL.  Comments
always welcome (btw, we have a shiny new dkms-devel@lists.us.dell.com
mailing list for anyone interested).

Gary Lerhaupt
Linux Development
Dell Computer Corporation

