Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262975AbVDBAvm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262975AbVDBAvm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 19:51:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262930AbVDBAFU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 19:05:20 -0500
Received: from mail.kroah.org ([69.55.234.183]:31964 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262934AbVDAXsO convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 18:48:14 -0500
Cc: akpm@osdl.org
Subject: [PATCH] arch/i386/pci/i386.c: Use new for_each_pci_dev macro
In-Reply-To: <11123992722697@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 1 Apr 2005 15:47:52 -0800
Message-Id: <111239927248@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2181.16.16, 2005/03/17 14:50:04-08:00, akpm@osdl.org

[PATCH] arch/i386/pci/i386.c: Use new for_each_pci_dev macro

From: Domen Puncer <domen@coderock.org>

As requested by Christoph Hellwig I created a new macro called
for_each_pci_dev.  It is a wrapper for this common use of
pci_get/find_device:

(while ((dev = pci_get_device(PCI_ANY_ID, PCI_ANY_ID, dev)) != NULL))

This macro will return the pci_dev *for all pci devices.  Here is the first
patch I used to test this macro with.  Compiled and booted on my T23.
There will be 53 more patches using this new macro.

Signed-off-by: Hanna Linder <hannal@us.ibm.com>
Signed-off-by: Maximilian Attems <janitor@sternwelten.at>
Signed-off-by: Domen Puncer <domen@coderock.org>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>


 arch/i386/pci/i386.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)


diff -Nru a/arch/i386/pci/i386.c b/arch/i386/pci/i386.c
--- a/arch/i386/pci/i386.c	2005-04-01 15:34:37 -08:00
+++ b/arch/i386/pci/i386.c	2005-04-01 15:34:37 -08:00
@@ -124,7 +124,7 @@
 	u16 command;
 	struct resource *r, *pr;
 
-	while ((dev = pci_get_device(PCI_ANY_ID, PCI_ANY_ID, dev)) != NULL) {
+	for_each_pci_dev(dev) {
 		pci_read_config_word(dev, PCI_COMMAND, &command);
 		for(idx = 0; idx < 6; idx++) {
 			r = &dev->resource[idx];
@@ -168,7 +168,7 @@
 	int idx;
 	struct resource *r;
 
-	while ((dev = pci_get_device(PCI_ANY_ID, PCI_ANY_ID, dev)) != NULL) {
+	for_each_pci_dev(dev) {
 		int class = dev->class >> 8;
 
 		/* Don't touch classless devices and host bridges */

