Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262009AbTIVXda (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Sep 2003 19:33:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261996AbTIVXda
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Sep 2003 19:33:30 -0400
Received: from mail.kroah.org ([65.200.24.183]:63904 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262009AbTIVXa0 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Sep 2003 19:30:26 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10642734283922@kroah.com>
Subject: Re: [PATCH] i2c driver fixes for 2.6.0-test5
In-Reply-To: <1064273428551@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 22 Sep 2003 16:30:28 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1315.1.26, 2003/09/22 15:24:36-07:00, arvidjaar@mail.ru

[PATCH] I2C: sysfs sensor nameing inconsistency

> That's what you are going to have to set the name file to in the
> i2c_client structure, much like your patch did.  Then look at the
> different name files in each device directory to see what kind of device
> it is (chip, subclient, etc.)

OK attached patch sets all names to just chip name for chips themselves and
"chipname subclient" when subclient ios registered.


 drivers/i2c/chips/adm1021.c |   11 +----------
 drivers/i2c/chips/it87.c    |    3 ---
 drivers/i2c/chips/lm78.c    |    6 +++---
 drivers/i2c/chips/lm85.c    |    6 +-----
 drivers/i2c/chips/via686a.c |    2 +-
 drivers/i2c/chips/w83781d.c |   24 ++++++++++++------------
 6 files changed, 18 insertions(+), 34 deletions(-)


diff -Nru a/drivers/i2c/chips/adm1021.c b/drivers/i2c/chips/adm1021.c
--- a/drivers/i2c/chips/adm1021.c	Mon Sep 22 16:11:39 2003
+++ b/drivers/i2c/chips/adm1021.c	Mon Sep 22 16:11:39 2003
@@ -225,7 +225,6 @@
 	struct adm1021_data *data;
 	int err = 0;
 	const char *type_name = "";
-	const char *client_name = "";
 
 	/* Make sure we aren't probing the ISA bus!! This is just a safety check
 	   at this moment; i2c_detect really won't call us. */
@@ -291,28 +290,20 @@
 
 	if (kind == max1617) {
 		type_name = "max1617";
-		client_name = "MAX1617 chip";
 	} else if (kind == max1617a) {
 		type_name = "max1617a";
-		client_name = "MAX1617A chip";
 	} else if (kind == adm1021) {
 		type_name = "adm1021";
-		client_name = "ADM1021 chip";
 	} else if (kind == adm1023) {
 		type_name = "adm1023";
-		client_name = "ADM1023 chip";
 	} else if (kind == thmc10) {
 		type_name = "thmc10";
-		client_name = "THMC10 chip";
 	} else if (kind == lm84) {
 		type_name = "lm84";
-		client_name = "LM84 chip";
 	} else if (kind == gl523sm) {
 		type_name = "gl523sm";
-		client_name = "GL523SM chip";
 	} else if (kind == mc1066) {
 		type_name = "mc1066";
-		client_name = "MC1066 chip";
 	} else {
 		dev_err(&adapter->dev, "Internal error: unknown kind (%d)?!?",
 			kind);
@@ -320,7 +311,7 @@
 	}
 
 	/* Fill in the remaining client fields and put it into the global list */
-	strlcpy(new_client->name, client_name, I2C_NAME_SIZE);
+	strlcpy(new_client->name, type_name, I2C_NAME_SIZE);
 	data->type = kind;
 
 	new_client->id = adm1021_id++;
diff -Nru a/drivers/i2c/chips/it87.c b/drivers/i2c/chips/it87.c
--- a/drivers/i2c/chips/it87.c	Mon Sep 22 16:11:40 2003
+++ b/drivers/i2c/chips/it87.c	Mon Sep 22 16:11:40 2003
@@ -592,7 +592,6 @@
 	struct it87_data *data;
 	int err = 0;
 	const char *name = "";
-	const char *client_name = "";
 	int is_isa = i2c_is_isa_adapter(adapter);
 
 	if (!is_isa && 
@@ -681,10 +680,8 @@
 
 	if (kind == it87) {
 		name = "it87";
-		client_name = "IT87 chip";
 	} /* else if (kind == it8712) {
 		name = "it8712";
-		client_name = "IT87-J chip";
 	} */ else {
 		dev_dbg(&adapter->dev, "Internal error: unknown kind (%d)?!?",
 			kind);
diff -Nru a/drivers/i2c/chips/lm78.c b/drivers/i2c/chips/lm78.c
--- a/drivers/i2c/chips/lm78.c	Mon Sep 22 16:11:40 2003
+++ b/drivers/i2c/chips/lm78.c	Mon Sep 22 16:11:40 2003
@@ -625,11 +625,11 @@
 	}
 
 	if (kind == lm78) {
-		client_name = "LM78 chip";
+		client_name = "lm78";
 	} else if (kind == lm78j) {
-		client_name = "LM78-J chip";
+		client_name = "lm78-j";
 	} else if (kind == lm79) {
-		client_name = "LM79 chip";
+		client_name = "lm79";
 	} else {
 		dev_dbg(&adapter->dev, "Internal error: unknown kind (%d)?!?",
 			kind);
diff -Nru a/drivers/i2c/chips/lm85.c b/drivers/i2c/chips/lm85.c
--- a/drivers/i2c/chips/lm85.c	Mon Sep 22 16:11:40 2003
+++ b/drivers/i2c/chips/lm85.c	Mon Sep 22 16:11:40 2003
@@ -853,24 +853,20 @@
 	/* Fill in the chip specific driver values */
 	if ( kind == any_chip ) {
 		type_name = "lm85";
-		strlcpy(new_client->name, "Generic LM85", I2C_NAME_SIZE);
 	} else if ( kind == lm85b ) {
 		type_name = "lm85b";
-		strlcpy(new_client->name, "National LM85-B", I2C_NAME_SIZE);
 	} else if ( kind == lm85c ) {
 		type_name = "lm85c";
-		strlcpy(new_client->name, "National LM85-C", I2C_NAME_SIZE);
 	} else if ( kind == adm1027 ) {
 		type_name = "adm1027";
-		strlcpy(new_client->name, "Analog Devices ADM1027", I2C_NAME_SIZE);
 	} else if ( kind == adt7463 ) {
 		type_name = "adt7463";
-		strlcpy(new_client->name, "Analog Devices ADT7463", I2C_NAME_SIZE);
 	} else {
 		dev_dbg(&adapter->dev, "Internal error, invalid kind (%d)!", kind);
 		err = -EFAULT ;
 		goto ERROR1;
 	}
+	strlcpy(new_client->name, type_name, I2C_NAME_SIZE);
 
 	/* Fill in the remaining client fields */
 	new_client->id = lm85_id++;
diff -Nru a/drivers/i2c/chips/via686a.c b/drivers/i2c/chips/via686a.c
--- a/drivers/i2c/chips/via686a.c	Mon Sep 22 16:11:40 2003
+++ b/drivers/i2c/chips/via686a.c	Mon Sep 22 16:11:40 2003
@@ -671,7 +671,7 @@
 	struct i2c_client *new_client;
 	struct via686a_data *data;
 	int err = 0;
-	const char client_name[] = "via686a chip";
+	const char client_name[] = "via686a";
 	u16 val;
 
 	/* Make sure we are probing the ISA bus!!  */
diff -Nru a/drivers/i2c/chips/w83781d.c b/drivers/i2c/chips/w83781d.c
--- a/drivers/i2c/chips/w83781d.c	Mon Sep 22 16:11:39 2003
+++ b/drivers/i2c/chips/w83781d.c	Mon Sep 22 16:11:39 2003
@@ -1098,15 +1098,15 @@
 	}
 
 	if (kind == w83781d)
-		client_name = "W83781D subclient";
+		client_name = "w83781d subclient";
 	else if (kind == w83782d)
-		client_name = "W83782D subclient";
+		client_name = "w83782d subclient";
 	else if (kind == w83783s)
-		client_name = "W83783S subclient";
+		client_name = "w83783s subclient";
 	else if (kind == w83627hf)
-		client_name = "W83627HF subclient";
+		client_name = "w83627hf subclient";
 	else if (kind == as99127f)
-		client_name = "AS99127F subclient";
+		client_name = "as99127f subclient";
 	else
 		client_name = "unknown subclient?";
 
@@ -1304,20 +1304,20 @@
 	}
 
 	if (kind == w83781d) {
-		client_name = "W83781D chip";
+		client_name = "w83781d";
 	} else if (kind == w83782d) {
-		client_name = "W83782D chip";
+		client_name = "w83782d";
 	} else if (kind == w83783s) {
-		client_name = "W83783S chip";
+		client_name = "w83783s";
 	} else if (kind == w83627hf) {
 		if (val1 == 0x90)
-			client_name = "W83627THF chip";
+			client_name = "w83627thf";
 		else
-			client_name = "W83627HF chip";
+			client_name = "w83627hf";
 	} else if (kind == as99127f) {
-		client_name = "AS99127F chip";
+		client_name = "as99127f";
 	} else if (kind == w83697hf) {
-		client_name = "W83697HF chip";
+		client_name = "w83697hf";
 	} else {
 		dev_err(&new_client->dev, "Internal error: unknown "
 						"kind (%d)?!?", kind);

