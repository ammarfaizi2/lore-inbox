Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261989AbVAHJPS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261989AbVAHJPS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 04:15:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261890AbVAHJNG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 04:13:06 -0500
Received: from mail.kroah.org ([69.55.234.183]:41861 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261858AbVAHFsP convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 00:48:15 -0500
Subject: Re: [PATCH] I2C patches for 2.6.10
In-Reply-To: <1105162774201@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 7 Jan 2005 21:39:34 -0800
Message-Id: <11051627741097@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1938.439.52, 2005/01/06 16:22:21-08:00, R.Marek@sh.cvut.cz

[PATCH] I2C: vid version detection fix

AMD 64 uses same VID table as Opteron.

Source:
http://www.amd.com/us-en/assets/content_type/white_papers_and_tech_docs/25112.PDF

Signed-off-by: Rudolf Marek <r.marek@sh.cvut.cz>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/i2c/i2c-sensor-vid.c |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)


diff -Nru a/drivers/i2c/i2c-sensor-vid.c b/drivers/i2c/i2c-sensor-vid.c
--- a/drivers/i2c/i2c-sensor-vid.c	2005-01-07 14:53:54 -08:00
+++ b/drivers/i2c/i2c-sensor-vid.c	2005-01-07 14:53:54 -08:00
@@ -36,8 +36,7 @@
 
 static struct vrm_model vrm_models[] = {
 	{X86_VENDOR_AMD, 0x6, ANY, 90},		/* Athlon Duron etc */
-	{X86_VENDOR_AMD, 0xF, 0x4, 90},		/* Athlon 64 */
-	{X86_VENDOR_AMD, 0xF, 0x5, 24},		/* Opteron */
+	{X86_VENDOR_AMD, 0xF, ANY, 24},		/* Athlon 64, Opteron */
 	{X86_VENDOR_INTEL, 0x6, 0x9, 85},	/* 0.13um too */
 	{X86_VENDOR_INTEL, 0x6, 0xB, 85},	/* 0xB Tualatin */
 	{X86_VENDOR_INTEL, 0x6, ANY, 82},	/* any P6 */
@@ -87,7 +86,7 @@
 	return vrm_ret;
 }
 
-/* and now something completely different for Non-x86 world*/
+/* and now for something completely different for Non-x86 world*/
 #else
 int i2c_which_vrm(void)
 {

