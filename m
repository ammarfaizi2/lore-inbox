Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261704AbUCBPr2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Mar 2004 10:47:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261701AbUCBPr2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Mar 2004 10:47:28 -0500
Received: from crl-mail.crl.dec.com ([192.58.206.9]:41668 "EHLO
	crl-mailb.crl.dec.com") by vger.kernel.org with ESMTP
	id S261704AbUCBPrX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Mar 2004 10:47:23 -0500
Message-ID: <4044ACF0.1030909@hp.com>
Date: Tue, 02 Mar 2004 10:49:04 -0500
From: Jamey Hicks <jamey.hicks@hp.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-GB; rv:1.4) Gecko/20030630
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: greg@kroah.com
CC: linux-kernel@vger.kernel.org
Subject: PATCH: add class_device_find
X-Enigmail-Version: 0.76.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-HPLC-MailScanner-Information: Please contact the ISP for more information
X-HPLC-MailScanner: Found to be clean
X-HPLC-MailScanner-SpamCheck: not spam (whitelisted),
	SpamAssassin (score=-4.9, required 5, BAYES_00 -4.90)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch adds:

struct class_device * class_device_find(struct class *class, const char 
*class_id)

to find a class device by name so that drivers that match up class 
devices by ID do not need to reach into the internals of class 
implementation.  RMK recommended that I take this approach, and it seems 
reasonable to me.  Please let me know what you think.

-Jamey Hicks


--- linux-2.6.3/drivers/base/class.c    2004-03-02 10:44:56.000000000 -0500
+++ linux-2.6.3-hh1/drivers/base/class.c    2004-03-02 
10:45:14.000000000 -0500
@@ -372,6 +372,19 @@
     return 0;
 }
 
+struct class_device * class_device_find(struct class *class, const char 
*class_id)
+{
+    struct list_head * entry;
+    list_for_each(entry, &class->children) {
+        struct class_device *class_dev = container_of(entry, struct 
class_device, node);
+        if (class_dev) {
+            if (strcmp(class_dev->class_id, class_id) == 0)
+                return class_dev;
+        }
+    }
+    return NULL;
+}
+
 struct class_device * class_device_get(struct class_device *class_dev)
 {
     if (class_dev)
@@ -463,6 +476,7 @@
 EXPORT_SYMBOL(class_device_put);
 EXPORT_SYMBOL(class_device_create_file);
 EXPORT_SYMBOL(class_device_remove_file);
+EXPORT_SYMBOL(class_device_find);
 
 EXPORT_SYMBOL(class_interface_register);
 EXPORT_SYMBOL(class_interface_unregister);


