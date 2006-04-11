Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751192AbWDKWbp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751192AbWDKWbp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Apr 2006 18:31:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751176AbWDKWbp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Apr 2006 18:31:45 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:22765 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751192AbWDKWbp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Apr 2006 18:31:45 -0400
Subject: [PATCH] tpm: compiler cleanup
From: Kylene Jo Hall <kjhall@us.ibm.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>,
       TPM Device Driver List <tpmdd-devel@lists.sourceforge.net>
In-Reply-To: <1144789502.12054.18.camel@localhost.localdomain>
References: <1144679825.4917.10.camel@localhost.localdomain>
	 <20060411111834.587e4461.akpm@osdl.org>
	 <1144786558.12054.14.camel@localhost.localdomain>
	 <200604112245.02443.ioe-lkml@rameria.de>
	 <1144789502.12054.18.camel@localhost.localdomain>
Content-Type: text/plain
Date: Tue, 11 Apr 2006 17:32:35 -0500
Message-Id: <1144794755.12054.31.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix compiler warnings about strict type checking with the max macro.

Signed-off-by: Kylie Hall <kjhall@us.ibm.com>
---
 drivers/char/tpm/tpm.c |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

--- linux-2.6.17-rc1-mm2/drivers/char/tpm/tpm.c	2006-04-11 17:30:57.612009250 -0500
+++ linux-2.6.17-rc1/drivers/char/tpm/tpm.c	2006-04-11 17:19:30.969096750 -0500
@@ -490,7 +490,7 @@ static ssize_t transmit_cmd(struct tpm_c
 
 void tpm_gen_interrupt(struct tpm_chip *chip)
 {
-	u8 data[max(ARRAY_SIZE(tpm_cap), 30)];
+	u8 data[max_t(int, ARRAY_SIZE(tpm_cap), 30)];
 	ssize_t rc;
 
 	memcpy(data, tpm_cap, sizeof(tpm_cap));
@@ -504,7 +504,7 @@ EXPORT_SYMBOL_GPL(tpm_gen_interrupt);
 
 void tpm_get_timeouts(struct tpm_chip *chip)
 {
-	u8 data[max(ARRAY_SIZE(TPM_CAP), 30)];
+	u8 data[max_t(int, ARRAY_SIZE(tpm_cap), 30)];
 	ssize_t rc;
 	u32 timeout;
 
@@ -577,7 +577,7 @@ EXPORT_SYMBOL_GPL(tpm_continue_selftest)
 ssize_t tpm_show_enabled(struct device * dev, struct device_attribute * attr,
 			char *buf)
 {
-	u8 data[max(ARRAY_SIZE(tpm_cap), 30)];
+	u8 data[max_t(int, ARRAY_SIZE(tpm_cap), 30)];
 	ssize_t rc;
 
 	struct tpm_chip *chip = dev_get_drvdata(dev);
@@ -599,7 +599,7 @@ EXPORT_SYMBOL_GPL(tpm_show_enabled);
 ssize_t tpm_show_active(struct device * dev, struct device_attribute * attr,
 			char *buf)
 {
-	u8 data[max(ARRAY_SIZE(tpm_cap), 35)];
+	u8 data[max_t(int, ARRAY_SIZE(tpm_cap), 35)];
 	ssize_t rc;
 
 	struct tpm_chip *chip = dev_get_drvdata(dev);
@@ -672,7 +672,7 @@ static const u8 pcrread[] = {
 ssize_t tpm_show_pcrs(struct device *dev, struct device_attribute *attr,
 		      char *buf)
 {
-	u8 data[max(max(ARRAY_SIZE(tpm_cap), ARRAY_SIZE(pcrread)), 30)];
+	u8 data[max_t(int, max(ARRAY_SIZE(tpm_cap), ARRAY_SIZE(pcrread)), 30)];
 	ssize_t rc;
 	int i, j, num_pcrs;
 	__be32 index;
@@ -789,7 +789,7 @@ static const u8 cap_version[] = {
 ssize_t tpm_show_caps(struct device *dev, struct device_attribute *attr,
 		      char *buf)
 {
-	u8 data[max(max(ARRAY_SIZE(tpm_cap), ARRAY_SIZE(cap_version)), 30)];
+	u8 data[max_t(int, max(ARRAY_SIZE(tpm_cap), ARRAY_SIZE(cap_version)), 30)];
 	ssize_t rc;
 	char *str = buf;
 
@@ -829,7 +829,7 @@ EXPORT_SYMBOL_GPL(tpm_show_caps);
 ssize_t tpm_show_caps_1_2(struct device * dev,
 			  struct device_attribute * attr, char *buf)
 {
-	u8 data[max(max(ARRAY_SIZE(tpm_cap), ARRAY_SIZE(cap_version)), 30)];
+	u8 data[max_t(int, max(ARRAY_SIZE(tpm_cap), ARRAY_SIZE(cap_version)), 30)];
 	ssize_t len;
 	char *str = buf;
 


