Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262775AbUBZLSh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 06:18:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262774AbUBZLSf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 06:18:35 -0500
Received: from gruby.cs.net.pl ([62.233.142.99]:19717 "EHLO gruby.cs.net.pl")
	by vger.kernel.org with ESMTP id S262772AbUBZLSb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 06:18:31 -0500
Date: Thu, 26 Feb 2004 12:18:30 +0100
From: Jakub Bogusz <qboosh@pld-linux.org>
To: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: i2c on alpha - used but not available in 2.6.3
Message-ID: <20040226111830.GG19602@gruby.cs.net.pl>
References: <20040225160833.GA5803@gruby.cs.net.pl> <20040225161441.A6161@infradead.org> <20040226105357.GF19602@gruby.cs.net.pl> <20040226105737.A17579@infradead.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="1LKvkjL3sHcu1TtY"
Content-Disposition: inline
In-Reply-To: <20040226105737.A17579@infradead.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--1LKvkjL3sHcu1TtY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 26, 2004 at 10:57:37AM +0000, Christoph Hellwig wrote:
> On Thu, Feb 26, 2004 at 11:53:57AM +0100, Jakub Bogusz wrote:
> > - beside drivers/i2c there was no drivers/misc and drivers/telephony in
> >   alpha/Kconfig - was this intentional or accidental?
> > 
> >   drivers/misc currently contains only IBM_ASM, which looks like some
> >   hardware-specific driver - maybe it should be available only on some
> >   arch(s)?
> 
> drivers/misc/ is empty here, and until we have some policy decision it
> should stay that way.  What tree do you look at?

Uh, haven't noticed this comes from IBM-RAS patches in distribution tree.
OK, so drivers/misc doesn't make any difference for now.

> > - on alpha drivers/parport was placed in "System setup" menu - but
> >   I suppose it can be moved to standard location without problems
> 
> Yes.
> 
> > - drivers/message/fusion was included only conditionaly, depending on
> >   PCI option (in drivers/Kconfig it's unconditional).
> >   If message/fusion requires PCI, maybe it should have "depends on PCI"
> >   in its Kconfig?
> 
> Yes, this is probably worth fixing.

OK, added the change to patch.

So is this patch correct now and would be accepted to Linux 2.6 tree?


-- 
Jakub Bogusz    http://cyber.cs.net.pl/~qboosh/
PLD Team        http://www.pld-linux.org/

--1LKvkjL3sHcu1TtY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="linux-alpha-use-device-Kconfig.patch"

--- linux-2.6.3/arch/alpha/Kconfig.orig	2004-02-24 11:07:49.000000000 +0100
+++ linux-2.6.3/arch/alpha/Kconfig	2004-02-26 11:13:49.000000000 +0100
@@ -596,51 +596,12 @@
 
 source "fs/Kconfig.binfmt"
 
-source "drivers/parport/Kconfig"
-
 endmenu
 
-source "drivers/base/Kconfig"
-
-source "drivers/mtd/Kconfig"
-
-source "drivers/pnp/Kconfig"
-
-source "drivers/block/Kconfig"
-
-source "drivers/md/Kconfig"
-
-source "drivers/ide/Kconfig"
-
-source "drivers/scsi/Kconfig"
-
-if PCI
-source "drivers/message/fusion/Kconfig"
-endif
-
-source "drivers/ieee1394/Kconfig"
-
-source "net/Kconfig"
-
-source "drivers/isdn/Kconfig"
-
-source "drivers/cdrom/Kconfig"
-
-source "drivers/input/Kconfig"
-
-source "drivers/char/Kconfig"
-
-#source drivers/misc/Config.in
-source "drivers/media/Kconfig"
+source "drivers/Kconfig"
 
 source "fs/Kconfig"
 
-source "drivers/video/Kconfig"
-
-source "sound/Kconfig"
-
-source "drivers/usb/Kconfig"
-
 source "arch/alpha/oprofile/Kconfig"
 
 menu "Kernel hacking"
--- linux-2.6.3/drivers/message/fusion/Kconfig.orig	2004-02-18 04:59:59.000000000 +0100
+++ linux-2.6.3/drivers/message/fusion/Kconfig	2004-02-26 12:11:09.000000000 +0100
@@ -3,7 +3,7 @@
 
 config FUSION
 	tristate "Fusion MPT (base + ScsiHost) drivers"
-	depends on BLK_DEV_SD
+	depends on BLK_DEV_SD && PCI
 	---help---
 	  LSI Logic Fusion(TM) Message Passing Technology (MPT) device support
 	  provides high performance SCSI host initiator, and LAN [1] interface

--1LKvkjL3sHcu1TtY--
