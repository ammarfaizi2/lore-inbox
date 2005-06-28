Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261455AbVF1M5o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261455AbVF1M5o (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 08:57:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261457AbVF1M5o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 08:57:44 -0400
Received: from ns.suse.de ([195.135.220.2]:31163 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S261455AbVF1M5P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 08:57:15 -0400
Message-ID: <42C14926.1040101@suse.de>
Date: Tue, 28 Jun 2005 14:57:10 +0200
From: Hannes Reinecke <hare@suse.de>
Organization: SuSE Linux AG
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.5) Gecko/20050317
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
Cc: Andrew Morton <akpm@osdl.org>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] Remove newline from pci MODALIAS variable
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------070901060106060402030504"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070901060106060402030504
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit

Hi Greg,

the pci core sends out a hotplug event variable MODALIAS with a trailing
newline. This is inconsistent with all other event variables and breaks
some hotplug tools. This patch removes the said newline.

Please apply.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke			hare@suse.de
SuSE Linux AG				S390 & zSeries
Maxfeldstraße 5				+49 911 74053 688
90409 Nürnberg				http://www.suse.de

--------------070901060106060402030504
Content-Type: text/plain;
 name="pci-hotplug-remove-nl"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="pci-hotplug-remove-nl"

From: Hannes Reinecke <hare@suse.de>
Subject: Remove newline from MODALIAS

PCI hotplug events carry a newline in the MODALIAS variable.
This confuses scripts unneccesarily.

--- linux-2.6.12/drivers/pci/hotplug.c.orig	2005-06-23 09:33:03.000000000 +0200
+++ linux-2.6.12/drivers/pci/hotplug.c	2005-06-23 09:33:16.000000000 +0200
@@ -54,7 +54,7 @@ int pci_hotplug (struct device *dev, cha
 
 	envp[i++] = scratch;
 	length += scnprintf (scratch, buffer_size - length,
-			    "MODALIAS=pci:v%08Xd%08Xsv%08Xsd%08Xbc%02Xsc%02Xi%02x\n",
+			    "MODALIAS=pci:v%08Xd%08Xsv%08Xsd%08Xbc%02Xsc%02Xi%02x",
 			    pdev->vendor, pdev->device,
 			    pdev->subsystem_vendor, pdev->subsystem_device,
 			    (u8)(pdev->class >> 16), (u8)(pdev->class >> 8),

--------------070901060106060402030504--
