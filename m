Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967157AbWKYULz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967157AbWKYULz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Nov 2006 15:11:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967158AbWKYULy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Nov 2006 15:11:54 -0500
Received: from agminet01.oracle.com ([141.146.126.228]:52816 "EHLO
	agminet01.oracle.com") by vger.kernel.org with ESMTP
	id S967157AbWKYULy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Nov 2006 15:11:54 -0500
Date: Sat, 25 Nov 2006 12:12:10 -0800
From: Randy Dunlap <randy.dunlap@oracle.com>
To: "Robert P. J. Day" <rpjday@mindspring.com>
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] MPT:  make all Fusion MPT sub-choices singly selectable
Message-Id: <20061125121210.52c66f55.randy.dunlap@oracle.com>
In-Reply-To: <Pine.LNX.4.64.0611250627200.20370@localhost.localdomain>
References: <Pine.LNX.4.64.0611250627200.20370@localhost.localdomain>
Organization: Oracle Linux Eng.
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 25 Nov 2006 06:34:55 -0500 (EST) Robert P. J. Day wrote:

> 
>   Put all of the Fusion MPT sub-choices under a single top-level
> config entry.
> 
> Signed-off-by: Robert P. J. Day <rpjday@mindspring.com>
> 
> ---
> 
>   Is there any reason that the sub-choices for Fusion MPT can't be
> selected or deselected en masse, the way it's done for, say, MTD
> support and other components?
> 
>   There are other locations where this simplification could be used
> but I thought I'd wait for some feedback on this example first.

It's an improvement over what is there now.

Here's another option.  What do you think of it?

---

  Put all of the Fusion MPT sub-choices under a single top-level
config entry.

---

  Is there any reason that the sub-choices for Fusion MPT can't be
selected or deselected en masse, the way it's done for, say, MTD
support and other components?

  There are other locations where this simplification could be used
but I thought I'd wait for some feedback on this example first.

---
 drivers/message/fusion/Kconfig |   13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

--- linux-2.6.19-rc6-git8.orig/drivers/message/fusion/Kconfig
+++ linux-2.6.19-rc6-git8/drivers/message/fusion/Kconfig
@@ -1,14 +1,12 @@
 
-menu "Fusion MPT device support"
+menuconfig FUSION
+	bool "Fusion MPT device support"
 
-config FUSION
-	bool
-	default n
+if FUSION
 
 config FUSION_SPI
 	tristate "Fusion MPT ScsiHost drivers for SPI"
 	depends on PCI && SCSI
-	select FUSION
 	select SCSI_SPI_ATTRS
 	---help---
 	  SCSI HOST support for a parallel SCSI host adapters.
@@ -23,7 +21,6 @@ config FUSION_SPI
 config FUSION_FC
 	tristate "Fusion MPT ScsiHost drivers for FC"
 	depends on PCI && SCSI
-	select FUSION
 	select SCSI_FC_ATTRS
 	---help---
 	  SCSI HOST support for a Fiber Channel host adapters.
@@ -40,7 +37,6 @@ config FUSION_FC
 config FUSION_SAS
 	tristate "Fusion MPT ScsiHost drivers for SAS"
 	depends on PCI && SCSI
- 	select FUSION
 	select SCSI_SAS_ATTRS
 	---help---
 	  SCSI HOST support for a SAS host adapters.
@@ -54,7 +50,6 @@ config FUSION_SAS
 
 config FUSION_MAX_SGE
 	int "Maximum number of scatter gather entries (16 - 128)"
-	depends on FUSION
 	default "128"
 	range 16 128
 	help
@@ -100,4 +95,4 @@ config FUSION_LAN
 
 	  If unsure whether you really want or need this, say N.
 
-endmenu
+endif
