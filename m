Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261994AbUB2HJq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Feb 2004 02:09:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262003AbUB2HFp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Feb 2004 02:05:45 -0500
Received: from smtp812.mail.sc5.yahoo.com ([66.163.170.82]:41887 "HELO
	smtp812.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261994AbUB2HDx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Feb 2004 02:03:53 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Vojtech Pavlik <vojtech@suse.cz>
Subject: [PATCH 6/9] introduce module_param_array_named
Date: Sun, 29 Feb 2004 02:00:04 -0500
User-Agent: KMail/1.6
Cc: linux-kernel@vger.kernel.org
References: <200402290153.08798.dtor_core@ameritech.net> <200402290158.04309.dtor_core@ameritech.net> <200402290158.52036.dtor_core@ameritech.net>
In-Reply-To: <200402290158.52036.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200402290200.07447.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


===================================================================


ChangeSet@1.1690, 2004-02-28 00:20:14-05:00, dtor_core@ameritech.net
  Introduce module_param_array_named to allow for module options with
  name different form corresponding array variable. Allows using short
  (but descriptive) option names without hurting code readability.
  
  Modeled after module_param_named.


 moduleparam.h |    9 ++++++---
 1 files changed, 6 insertions(+), 3 deletions(-)


===================================================================



diff -Nru a/include/linux/moduleparam.h b/include/linux/moduleparam.h
--- a/include/linux/moduleparam.h	Sun Feb 29 01:18:36 2004
+++ b/include/linux/moduleparam.h	Sun Feb 29 01:18:36 2004
@@ -126,12 +126,15 @@
 #define param_check_invbool(name, p) __param_check(name, p, int)
 
 /* Comma-separated array: num is set to number they actually specified. */
-#define module_param_array(name, type, num, perm)			\
+#define module_param_array_named(name, array, type, num, perm)		\
 	static struct kparam_array __param_arr_##name			\
-	= { ARRAY_SIZE(name), &num, param_set_##type, param_get_##type,	\
-	    sizeof(name[0]), name };					\
+	= { ARRAY_SIZE(array), &num, param_set_##type, param_get_##type,\
+	    sizeof(array[0]), array };					\
 	module_param_call(name, param_array_set, param_array_get, 	\
 			  &__param_arr_##name, perm)
+
+#define module_param_array(name, type, num, perm)		\
+	module_param_array_named(name, name, type, num, perm)
 
 extern int param_array_set(const char *val, struct kernel_param *kp);
 extern int param_array_get(char *buffer, struct kernel_param *kp);
