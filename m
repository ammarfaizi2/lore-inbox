Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266534AbUA3Bjk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jan 2004 20:39:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266525AbUA3Bhj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jan 2004 20:37:39 -0500
Received: from mail.kroah.org ([65.200.24.183]:15068 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S266526AbUA3BcJ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jan 2004 20:32:09 -0500
Subject: Re: [PATCH] PCI Update for 2.6.2-rc2
In-Reply-To: <1075426306325@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Thu, 29 Jan 2004 17:31:46 -0800
Message-Id: <10754263062112@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1511, 2004/01/29 14:26:41-08:00, willy@debian.org

[PATCH] PCI Hotplug: Better reporting of PCI frequency / bus mode problems for acpi driver

When plugging a 33MHz card into a bus that's running at 66MHz, I'd like
to see a better error message than:

acpiphp_glue: notify_handler: unknown event type 0x5 for \_SB_.SBA0.PCI4.S2F0

The following patch would give us:

Device \_SB_.SBA0.PCI4.S2F0 cannot be configured due to a frequency mismatch

which I think is clearer.


 drivers/pci/hotplug/acpiphp_glue.c |   15 +++++++++++++++
 1 files changed, 15 insertions(+)


diff -Nru a/drivers/pci/hotplug/acpiphp_glue.c b/drivers/pci/hotplug/acpiphp_glue.c
--- a/drivers/pci/hotplug/acpiphp_glue.c	Thu Jan 29 17:24:40 2004
+++ b/drivers/pci/hotplug/acpiphp_glue.c	Thu Jan 29 17:24:40 2004
@@ -974,6 +974,21 @@
 		dbg("%s: Device eject notify on %s\n", __FUNCTION__, objname);
 		break;
 
+	case ACPI_NOTIFY_FREQUENCY_MISMATCH:
+		printk(KERN_ERR "Device %s cannot be configured due"
+				" to a frequency mismatch\n", objname);
+		break;
+
+	case ACPI_NOTIFY_BUS_MODE_MISMATCH:
+		printk(KERN_ERR "Device %s cannot be configured due"
+				" to a bus mode mismatch\n", objname);
+		break;
+
+	case ACPI_NOTIFY_POWER_FAULT:
+		printk(KERN_ERR "Device %s has suffered a power fault\n",
+				objname);
+		break;
+
 	default:
 		warn("notify_handler: unknown event type 0x%x for %s\n", type, objname);
 		break;

