Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262749AbVFVF05@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262749AbVFVF05 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 01:26:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262765AbVFVF0o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 01:26:44 -0400
Received: from mail.kroah.org ([69.55.234.183]:35223 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262749AbVFVFMP convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 01:12:15 -0400
Cc: johnpol@2ka.mipt.ru
Subject: [PATCH] w1_therm: removed duplicated family id.
In-Reply-To: <11194171273603@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Tue, 21 Jun 2005 22:12:07 -0700
Message-Id: <1119417127267@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] w1_therm: removed duplicated family id.

We can access family id through w1_family structure.

Signed-off-by: Evgeniy Polyakov <johnpol@2ka.mipt.ru>

---
commit 4e470aa9642d49230bcdfbb393cf5a81da333aba
tree eb4e0f515c3c45236f816532c2bd2ce31ac6cfce
parent c7b2b2a723174d22a743180d5367f0028226031b
author Evgeniy Polyakov <johnpol@2ka.mipt.ru> Fri, 20 May 2005 22:50:33 +0400
committer Greg Kroah-Hartman <gregkh@suse.de> Tue, 21 Jun 2005 21:43:10 -0700

 drivers/w1/w1_therm.c |    6 +-----
 1 files changed, 1 insertions(+), 5 deletions(-)

diff --git a/drivers/w1/w1_therm.c b/drivers/w1/w1_therm.c
--- a/drivers/w1/w1_therm.c
+++ b/drivers/w1/w1_therm.c
@@ -66,7 +66,6 @@ static struct w1_family w1_therm_family_
 
 struct w1_therm_family_converter
 {
-	u8			fid;
 	u8			broken;
 	u16			reserved;
 	struct w1_family	*f;
@@ -78,17 +77,14 @@ static inline int w1_DS18S20_convert_tem
 
 static struct w1_therm_family_converter w1_therm_families[] = {
 	{
-		.fid 		= W1_THERM_DS18S20,
 		.f		= &w1_therm_family_DS18S20,
 		.convert 	= w1_DS18S20_convert_temp
 	},
 	{
-		.fid 		= W1_THERM_DS1822,
 		.f		= &w1_therm_family_DS1822,
 		.convert 	= w1_DS18B20_convert_temp
 	},
 	{
-		.fid 		= W1_THERM_DS18B20,
 		.f		= &w1_therm_family_DS18B20,
 		.convert 	= w1_DS18B20_convert_temp
 	},
@@ -133,7 +129,7 @@ static inline int w1_convert_temp(u8 rom
 	int i;
 
 	for (i=0; i<sizeof(w1_therm_families)/sizeof(w1_therm_families[0]); ++i)
-		if (w1_therm_families[i].fid == fid)
+		if (w1_therm_families[i].f->fid == fid)
 			return w1_therm_families[i].convert(rom);
 
 	return 0;

