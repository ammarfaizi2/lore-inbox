Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262035AbVCNXCW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262035AbVCNXCW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 18:02:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262040AbVCNW7l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 17:59:41 -0500
Received: from fire.osdl.org ([65.172.181.4]:19144 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262035AbVCNWz1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 17:55:27 -0500
Date: Mon, 14 Mar 2005 14:55:22 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: kjhall@us.ibm.com, akpm <akpm@osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] tpm: fix gcc printk warnings
Message-Id: <20050314145522.787a6865.rddunlap@osdl.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


(Kylene, please add TPM info to MAINTAINERS or CREDITS)

Fix gcc printk arg type warnings:

drivers/char/tpm/tpm.c:145: warning: unsigned int format, different type arg (arg 5)
drivers/char/tpm/tpm.c:153: warning: int format, different type arg (arg 4)
drivers/char/tpm/tpm.c:190: warning: int format, different type arg (arg 4)

Signed-off-by: Randy Dunlap <rddunlap@osdl.org>

diffstat:=
 drivers/char/tpm/tpm.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff -Naurp ./drivers/char/tpm/tpm.c~tpm_printk ./drivers/char/tpm/tpm.c
--- ./drivers/char/tpm/tpm.c~tpm_printk	2005-03-14 08:41:24.000000000 -0800
+++ ./drivers/char/tpm/tpm.c	2005-03-14 11:19:28.000000000 -0800
@@ -143,7 +143,7 @@ static ssize_t tpm_transmit(struct tpm_c
 		return -ENODATA;
 	if (count > bufsiz) {
 		dev_err(&chip->pci_dev->dev,
-			"invalid count value %x %x \n", count, bufsiz);
+			"invalid count value %x %lx\n", count, (unsigned long)bufsiz);
 		return -E2BIG;
 	}
 
@@ -151,7 +151,7 @@ static ssize_t tpm_transmit(struct tpm_c
 
 	if ((len = chip->vendor->send(chip, (u8 *) buf, count)) < 0) {
 		dev_err(&chip->pci_dev->dev,
-			"tpm_transmit: tpm_send: error %d\n", len);
+			"tpm_transmit: tpm_send: error %Zd\n", len);
 		return len;
 	}
 
@@ -188,7 +188,7 @@ out_recv:
 	len = chip->vendor->recv(chip, (u8 *) buf, bufsiz);
 	if (len < 0)
 		dev_err(&chip->pci_dev->dev,
-			"tpm_transmit: tpm_recv: error %d\n", len);
+			"tpm_transmit: tpm_recv: error %Zd\n", len);
 	up(&chip->tpm_mutex);
 	return len;
 }


---
