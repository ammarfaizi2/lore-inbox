Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264334AbTIITPM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 15:15:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264346AbTIITPM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 15:15:12 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:54542 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S264334AbTIITPA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 15:15:00 -0400
Date: Tue, 9 Sep 2003 20:14:55 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Fedor Karpelevitch <fedor@karpelevitch.net>,
       Linus Torvalds <torvalds@osdl.org>, David Jones <davej@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6.0-test5]oops inserting PCMCIA card
Message-ID: <20030909201455.K4216@flint.arm.linux.org.uk>
Mail-Followup-To: Fedor Karpelevitch <fedor@karpelevitch.net>,
	Linus Torvalds <torvalds@osdl.org>, David Jones <davej@suse.de>,
	linux-kernel@vger.kernel.org
References: <200309081630.19263.fedor@karpelevitch.net> <20030909173014.E4216@flint.arm.linux.org.uk> <200309091202.03759.fedor@karpelevitch.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200309091202.03759.fedor@karpelevitch.net>; from fedor@karpelevitch.net on Tue, Sep 09, 2003 at 12:02:03PM -0700
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 09, 2003 at 12:02:03PM -0700, Fedor Karpelevitch wrote:
> see attachments. I included couple other items in case they may be 
> relevant.

Well, first driver I looked at - ati-agp.  This should fix all the AGP
drivers.

Linus please apply.  pci_device_id tables can not and must not be marked
discardable.

diff -ur orig/drivers/char/agp/ati-agp.c linux/drivers/char/agp/ati-agp.c
--- orig/drivers/char/agp/ati-agp.c	Mon Sep  8 23:36:52 2003
+++ linux/drivers/char/agp/ati-agp.c	Tue Sep  9 20:11:19 2003
@@ -491,7 +491,7 @@
 	agp_put_bridge(bridge);
 }
 
-static struct pci_device_id agp_ati_pci_table[] __initdata = {
+static struct pci_device_id agp_ati_pci_table[] = {
 	{
 	.class		= (PCI_CLASS_BRIDGE_HOST << 8),
 	.class_mask	= ~0,
diff -ur orig/drivers/char/agp/sis-agp.c linux/drivers/char/agp/sis-agp.c
--- orig/drivers/char/agp/sis-agp.c	Mon Sep  8 23:36:53 2003
+++ linux/drivers/char/agp/sis-agp.c	Tue Sep  9 20:12:38 2003
@@ -215,7 +215,7 @@
 	agp_put_bridge(bridge);
 }
 
-static struct pci_device_id agp_sis_pci_table[] __initdata = {
+static struct pci_device_id agp_sis_pci_table[] = {
 	{
 	.class		= (PCI_CLASS_BRIDGE_HOST << 8),
 	.class_mask	= ~0,
diff -ur orig/drivers/char/agp/uninorth-agp.c linux/drivers/char/agp/uninorth-agp.c
--- orig/drivers/char/agp/uninorth-agp.c	Thu Sep  4 16:36:58 2003
+++ linux/drivers/char/agp/uninorth-agp.c	Tue Sep  9 20:12:38 2003
@@ -350,7 +350,7 @@
 	agp_put_bridge(bridge);
 }
 
-static struct pci_device_id agp_uninorth_pci_table[] __initdata = {
+static struct pci_device_id agp_uninorth_pci_table[] = {
 	{
 	.class		= (PCI_CLASS_BRIDGE_HOST << 8),
 	.class_mask	= ~0,
diff -ur orig/drivers/char/agp/via-agp.c linux/drivers/char/agp/via-agp.c
--- orig/drivers/char/agp/via-agp.c	Mon Sep  8 23:36:53 2003
+++ linux/drivers/char/agp/via-agp.c	Tue Sep  9 20:12:38 2003
@@ -432,7 +432,7 @@
 	agp_put_bridge(bridge);
 }
 
-static struct pci_device_id agp_via_pci_table[] __initdata = {
+static struct pci_device_id agp_via_pci_table[] = {
 	{
 	.class		= (PCI_CLASS_BRIDGE_HOST << 8),
 	.class_mask	= ~0,

-- 
Russell King (rmk@arm.linux.org.uk)	http://www.arm.linux.org.uk/personal/
Linux kernel maintainer of:
  2.6 ARM Linux   - http://www.arm.linux.org.uk/
  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
  2.6 Serial core
