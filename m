Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261933AbUCPPfW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 10:35:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261935AbUCPOjT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 09:39:19 -0500
Received: from styx.suse.cz ([82.208.2.94]:63873 "EHLO shadow.ucw.cz")
	by vger.kernel.org with ESMTP id S261928AbUCPOTn convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 09:19:43 -0500
Content-Transfer-Encoding: 7BIT
Message-Id: <10794467772353@twilight.ucw.cz>
Content-Type: text/plain; charset=US-ASCII
Subject: [PATCH 20/44] Add module_parm_array() helper
X-Mailer: gregkh_patchbomb_levon_offspring
To: torvalds@osdl.org, vojtech@ucw.cz, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Date: Tue, 16 Mar 2004 15:19:37 +0100
In-Reply-To: <107944677736@twilight.ucw.cz>
From: Vojtech Pavlik <vojtech@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You can pull this changeset from:
	bk://kernel.bkbits.net/vojtech/input

===================================================================

ChangeSet@1.1608.54.6, 2004-03-03 00:32:43-05:00, dtor_core@ameritech.net
  Introduce module_param_array_named to allow for module options with
  name different form corresponding array variable. Allows using short
  (but descriptive) option names without hurting code readability.
  
  Modeled after module_param_named.


 moduleparam.h |    9 ++++++---
 1 files changed, 6 insertions(+), 3 deletions(-)

===================================================================

diff -Nru a/include/linux/moduleparam.h b/include/linux/moduleparam.h
--- a/include/linux/moduleparam.h	Tue Mar 16 13:18:52 2004
+++ b/include/linux/moduleparam.h	Tue Mar 16 13:18:52 2004
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

