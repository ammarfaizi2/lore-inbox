Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262066AbVCaXcl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262066AbVCaXcl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 18:32:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262048AbVCaXbg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 18:31:36 -0500
Received: from mail.kroah.org ([69.55.234.183]:26080 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262066AbVCaXYF convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 18:24:05 -0500
Cc: khali@linux-fr.org
Subject: [PATCH] I2C: Kill outdated defines in i2c.h
In-Reply-To: <11123113922117@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Thu, 31 Mar 2005 15:23:12 -0800
Message-Id: <11123113921928@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2336, 2005/03/31 14:09:38-08:00, khali@linux-fr.org

[PATCH] I2C: Kill outdated defines in i2c.h

Some defines in i2c.h (I2C_CLIENT_MODPARM and friends) are now useless.
They should have been removed when the i2c client parameters were
converted from MODULE_PARAM to module_parm_array, but where not. This
patch removes them now.

Additionally, it moves the definition of I2C_CLIENT_MAX_OPTS next to
where it is used rather than 220 lines before, which is preferable IMHO.

As a side note, I think that there is a bug in the way these options are
handled. The i2c code looks for I2C_CLIENT_END as a list terminator, but
if the maximum number of parameters are actually provided, no terminator
will be left. It's rather unlikely to happen because nobody will
probably ever provide that many parameters, but this should probably be
fixed. I'll address this issue later, since I plan to completely rewrite
the way these parameters are handled anyway.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>


 include/linux/i2c.h |   13 +++----------
 1 files changed, 3 insertions(+), 10 deletions(-)


diff -Nru a/include/linux/i2c.h b/include/linux/i2c.h
--- a/include/linux/i2c.h	2005-03-31 15:17:39 -08:00
+++ b/include/linux/i2c.h	2005-03-31 15:17:39 -08:00
@@ -306,9 +306,6 @@
 #define ANY_I2C_BUS		0xffff
 #define ANY_I2C_ISA_BUS		9191
 
-/* The length of the option lists */
-#define I2C_CLIENT_MAX_OPTS 48
-
 
 /* ----- functions exported by i2c.o */
 
@@ -526,6 +523,9 @@
 #define I2C_MAJOR	89		/* Device major number		*/
 
 /* These defines are used for probing i2c client addresses */
+/* The length of the option lists */
+#define I2C_CLIENT_MAX_OPTS 48
+
 /* Default fill of many variables */
 #define I2C_CLIENT_DEFAULTS {I2C_CLIENT_END, I2C_CLIENT_END, I2C_CLIENT_END, \
                           I2C_CLIENT_END, I2C_CLIENT_END, I2C_CLIENT_END, \
@@ -544,19 +544,12 @@
                           I2C_CLIENT_END, I2C_CLIENT_END, I2C_CLIENT_END, \
                           I2C_CLIENT_END, I2C_CLIENT_END, I2C_CLIENT_END}
 
-/* This is ugly. We need to evaluate I2C_CLIENT_MAX_OPTS before it is 
-   stringified */
-#define I2C_CLIENT_MODPARM_AUX1(x) "1-" #x "h"
-#define I2C_CLIENT_MODPARM_AUX(x) I2C_CLIENT_MODPARM_AUX1(x)
-#define I2C_CLIENT_MODPARM I2C_CLIENT_MODPARM_AUX(I2C_CLIENT_MAX_OPTS)
-
 /* I2C_CLIENT_MODULE_PARM creates a module parameter, and puts it in the
    module header */
 
 #define I2C_CLIENT_MODULE_PARM(var,desc) \
   static unsigned short var[I2C_CLIENT_MAX_OPTS] = I2C_CLIENT_DEFAULTS; \
   static unsigned int var##_num; \
-  /*MODULE_PARM(var,I2C_CLIENT_MODPARM);*/ \
   module_param_array(var, short, &var##_num, 0); \
   MODULE_PARM_DESC(var,desc)
 

