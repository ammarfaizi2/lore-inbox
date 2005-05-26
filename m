Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261598AbVEZQcf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261598AbVEZQcf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 May 2005 12:32:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261600AbVEZQav
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 May 2005 12:30:51 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:25483 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S261598AbVEZQaU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 May 2005 12:30:20 -0400
Date: Thu, 26 May 2005 11:29:27 -0500 (CDT)
From: Kylene Hall <kjhall@us.ibm.com>
X-X-Sender: kjhall@localhost.localdomain
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] tpm: fix tpm exports
In-Reply-To: <20050525014442.3cdf10cb.akpm@osdl.org>
Message-ID: <Pine.LNX.4.62.0505261126090.30037@localhost.localdomain>
References: <20050525014442.3cdf10cb.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 May 2005, Andrew Morton wrote:
> 
> With `make allmodconfig':
> 
> *** Warning: "tpm_show_pubek" [drivers/char/tpm/tpm.ko] undefined!
> *** Warning: "tpm_show_caps" [drivers/char/tpm/tpm.ko] undefined!
> *** Warning: "tpm_show_pcrs" [drivers/char/tpm/tpm.ko] undefined!
> 
> I don't know what you're trying to do here.  Please review all exports in
> -rc5-mm1, fix.
> 
> 
> 

The following patch fixes warnings received when compiling 2.6.12-rc5-mm1.  
Description: Fixes tpm device attribute functions with the wrong names and 
types.

Signed-off-by: Kylene Hall <kjhall@us.ibm.com>
---
--- linux-2.6.12-rc5/drivers/char/tpm/tpm.c	2005-05-26 09:43:33.000000000 -0500
+++ linux-2.6.12-rc5-tpmdd/drivers/char/tpm/tpm.c	2005-05-26 09:34:46.000000000 -0500
@@ -130,7 +131,8 @@ static const u8 pcrread[] = {
 	0, 0, 0, 0		/* PCR index */
 };
 
-ssize_t show_pcrs(struct device *dev, struct device_attribute *attr, char *buf)
+ssize_t tpm_show_pcrs(struct device *dev, struct device_attribute *attr,
+		      char *buf)
 {
 	u8 data[READ_PCR_RESULT_SIZE];
 	ssize_t len;
@@ -182,7 +186,8 @@ static const u8 readpubek[] = {
 	0, 0, 0, 124,		/* TPM_ORD_ReadPubek */
 };
 
-ssize_t show_pubek(struct device *dev, struct device_attribute *attr, char *buf)
+ssize_t tpm_show_pubek(struct device *dev, struct device_attribute *attr,
+		       char *buf)
 {
 	u8 *data;
 	ssize_t len;
@@ -263,7 +267,8 @@ static const u8 cap_manufacturer[] = {
 	0, 0, 1, 3
 };
 
-ssize_t show_caps(struct device *dev, struct device_attribute *attr, char *buf)
+ssize_t tpm_show_caps(struct device *dev, struct device_attribute *attr,
+		      char *buf)
 {
 	u8 data[sizeof(cap_manufacturer)];
 	ssize_t len;
@@ -299,7 +303,8 @@ ssize_t show_caps(struct device *dev, st
 
 EXPORT_SYMBOL_GPL(tpm_show_caps);
 
-ssize_t tpm_store_cancel(struct device * dev, const char *buf,
+ssize_t tpm_store_cancel(struct device * dev,
+			 struct device_attribute * attr, const char *buf,
 			 size_t count)
 {
 	struct tpm_chip *chip = dev_get_drvdata(dev);
--- linux-2.6.12-rc5/drivers/char/tpm/tpm.h	2005-05-26 09:43:33.000000000 -0500
+++ linux-2.6.12-rc5-tpmdd/drivers/char/tpm/tpm.h	2005-05-26 09:34:04.000000000 -0500
@@ -35,10 +35,14 @@ enum tpm_addr {
 	TPM_DATA = 0x4F
 };
 
-extern ssize_t tpm_show_pubek(struct device *, char *);
-extern ssize_t tpm_show_pcrs(struct device *, char *);
-extern ssize_t tpm_show_caps(struct device *, char *);
-extern ssize_t tpm_store_cancel(struct device *, const char *, size_t);
+extern ssize_t tpm_show_pubek(struct device *, struct device_attribute *,
+			      char *);
+extern ssize_t tpm_show_pcrs(struct device *, struct device_attribute *,
+			     char *);
+extern ssize_t tpm_show_caps(struct device *, struct device_attribute *,
+			     char *);
+extern ssize_t tpm_store_cancel(struct device *, struct device_attribute *,
+				const char *, size_t);
 
 
 struct tpm_chip;

