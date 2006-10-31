Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422731AbWJaEtM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422731AbWJaEtM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 23:49:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422748AbWJaEtL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 23:49:11 -0500
Received: from rgminet01.oracle.com ([148.87.113.118]:7291 "EHLO
	rgminet01.oracle.com") by vger.kernel.org with ESMTP
	id S1422731AbWJaEtK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 23:49:10 -0500
Date: Mon, 30 Oct 2006 20:41:11 -0800
From: Randy Dunlap <randy.dunlap@oracle.com>
To: torvalds <torvalds@osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>, bunk@stusta.de
Subject: Fw: [PATCH] SCSI: ISCSI build failure
Message-Id: <20061030204111.96206669.randy.dunlap@oracle.com>
Organization: Oracle Linux Eng.
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


We need this patch that I sent to linux-scsi earlier today
in 2.6.19...

I suppose James is traveling or something.

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Date: Mon, 30 Oct 2006 08:32:30 -0800
From: Randy Dunlap <randy.dunlap@oracle.com>
To: Roman Zippel <zippel@linux-m68k.org>, jejb <james.bottomley@steeleye.com>
Cc: Toralf F_rster <toralf.foerster@gmx.de>, scsi <linux-scsi@vger.kernel.org>, akpm <akpm@osdl.org>
Subject: [PATCH] SCSI: ISCSI build failure


On Mon, 30 Oct 2006 12:07:48 +0100 (CET) Roman Zippel wrote:

> Hi,
> 
> On Sun, 29 Oct 2006, Randy Dunlap wrote:
> 
> > On Sun, 29 Oct 2006 19:45:15 +0100 Toralf Förster wrote:
> > 
> > > Hello,
> > 
> > config SCSI_ISCSI_ATTRS
> > 	tristate "iSCSI Transport Attributes"
> > 	depends on SCSI && NET
> > 	help
> > 	  If you wish to export transport-specific information about
> > 	  each attached iSCSI device to sysfs, say Y.
> > 	  Otherwise, say N.
> > 
> > but NET is disabled, yet somehow SCSI_ISCSI_ATTRS is enabled.
> > I don't see how that happens.
> > Roman, any ideas?
> > 
> > [...]
> > > CONFIG_SCSI_QLA_ISCSI=y
> 
> I guess, that needs a dependency on NET.

Yep, thanks, Roman.

James, should be in 2.6.19...

---

From: Randy Dunlap <randy.dunlap@oracle.com>

SCSI_QLA_ISCSI needs to depend on NET to prevent build (link) failures
that are caused by selecting SCSI_ISCSI_ATTRS.

Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
---
 drivers/scsi/qla4xxx/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.19-rc3-git6.orig/drivers/scsi/qla4xxx/Kconfig
+++ linux-2.6.19-rc3-git6/drivers/scsi/qla4xxx/Kconfig
@@ -1,6 +1,6 @@
 config SCSI_QLA_ISCSI
 	tristate "QLogic ISP4XXX host adapter family support"
-	depends on PCI && SCSI
+	depends on PCI && SCSI && NET
 	select SCSI_ISCSI_ATTRS
 	---help---
 	This driver supports the QLogic 40xx (ISP4XXX) iSCSI host
-
