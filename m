Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262898AbVA2LhQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262898AbVA2LhQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jan 2005 06:37:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262900AbVA2LhQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jan 2005 06:37:16 -0500
Received: from smtp-106-saturday.nerim.net ([62.4.16.106]:17680 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S262898AbVA2LhK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jan 2005 06:37:10 -0500
Date: Sat, 29 Jan 2005 12:37:26 +0100
From: Jean Delvare <khali@linux-fr.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.4] I2C updates for 2.4.29 (3/3)
Message-Id: <20050129123726.2e2019ae.khali@linux-fr.org>
In-Reply-To: <20050129120235.5c7160e6.khali@linux-fr.org>
References: <20050129120235.5c7160e6.khali@linux-fr.org>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Original discussion:
http://archives.andrew.net.au/lm-sensors/msg29038.html
http://archives.andrew.net.au/lm-sensors/msg29041.html

Bottom line:
The "id" member of the i2c_client structure was discarded in Linux 2.6
due to a lack of consistent use and overall need. While we of course
won't backport this to Linux 2.4 so as to not break compatibility with
existing 2.4 drivers, it still seems wise to update the documentation so
that new drivers written for Linux 2.4 today (*sigh*) do not rely on it.

--- linux-2.4.29/Documentation/i2c/writing-clients.orig	2005-01-21 21:51:06.000000000 +0100
+++ linux-2.4.29/Documentation/i2c/writing-clients	2005-01-23 18:21:47.000000000 +0100
@@ -380,9 +380,6 @@
 
 For now, you can ignore the `flags' parameter. It is there for future use.
 
-  /* Unique ID allocation */
-  static int foo_id = 0;
-
   int foo_detect_client(struct i2c_adapter *adapter, int address, 
                         unsigned short flags, int kind)
   {
@@ -518,7 +515,6 @@
     data->type = kind;
     /* SENSORS ONLY END */
 
-    new_client->id = foo_id++; /* Automatically unique */
     data->valid = 0; /* Only if you use this field */
     init_MUTEX(&data->update_lock); /* Only if you use this field */
 


-- 
Jean Delvare
http://khali.linux-fr.org/
