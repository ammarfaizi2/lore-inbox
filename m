Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262803AbVFVG1J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262803AbVFVG1J (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 02:27:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262834AbVFVG0u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 02:26:50 -0400
Received: from mail.kroah.org ([69.55.234.183]:31644 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262803AbVFVFWG convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 01:22:06 -0400
Cc: grant_lkml@dodo.com.au
Subject: [PATCH] I2C: Setting w83627hf fan divisor 128 fails.
In-Reply-To: <11194174643895@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Tue, 21 Jun 2005 22:17:44 -0700
Message-Id: <11194174642050@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] I2C: Setting w83627hf fan divisor 128 fails.

Jarkko Lavinen provided patch to fix: "couldn't set the divisor 128
through fan1_div sysfs entry even though the chip supports it and
setting divisors 1..64 worked. This was due to POWER_TO_REG() only
checking 2's powers 0 till 5 but not 6."

This patch applies that fix to w83627hf and w83781d drivers.

Signed-off-by: Grant Coady <gcoady@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit abc01922477104e8d72b494902aff37135c409e7
tree 7ef178b1a14e89c88bac1a976c238c91fc1697ee
parent b9826b3ee8faa468a26782e3bf37716a73d96730
author Grant Coady <grant_lkml@dodo.com.au> Thu, 12 May 2005 13:41:51 +1000
committer Greg Kroah-Hartman <gregkh@suse.de> Tue, 21 Jun 2005 21:51:56 -0700

 drivers/i2c/chips/w83627hf.c |    2 +-
 drivers/i2c/chips/w83781d.c  |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/chips/w83627hf.c b/drivers/i2c/chips/w83627hf.c
--- a/drivers/i2c/chips/w83627hf.c
+++ b/drivers/i2c/chips/w83627hf.c
@@ -264,7 +264,7 @@ static inline u8 DIV_TO_REG(long val)
 {
 	int i;
 	val = SENSORS_LIMIT(val, 1, 128) >> 1;
-	for (i = 0; i < 6; i++) {
+	for (i = 0; i < 7; i++) {
 		if (val == 0)
 			break;
 		val >>= 1;
diff --git a/drivers/i2c/chips/w83781d.c b/drivers/i2c/chips/w83781d.c
--- a/drivers/i2c/chips/w83781d.c
+++ b/drivers/i2c/chips/w83781d.c
@@ -192,7 +192,7 @@ DIV_TO_REG(long val, enum chips type)
 	val = SENSORS_LIMIT(val, 1,
 			    ((type == w83781d
 			      || type == as99127f) ? 8 : 128)) >> 1;
-	for (i = 0; i < 6; i++) {
+	for (i = 0; i < 7; i++) {
 		if (val == 0)
 			break;
 		val >>= 1;

