Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266830AbUHWT5J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266830AbUHWT5J (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 15:57:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266806AbUHWTyv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 15:54:51 -0400
Received: from mail.kroah.org ([69.55.234.183]:42947 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S266769AbUHWSgO convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 14:36:14 -0400
X-Fake: the user-agent is fake
Subject: Re: [PATCH] PCI and I2C fixes for 2.6.8
User-Agent: Mutt/1.5.6i
In-Reply-To: <1093286090887@kroah.com>
Date: Mon, 23 Aug 2004 11:34:50 -0700
Message-Id: <1093286090598@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1807.59.2, 2004/08/05 13:10:16-07:00, greg@kroah.com

MODULE: add byte type of module paramater, like the comments say we support...

Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 include/linux/moduleparam.h |    4 ++++
 kernel/params.c             |    3 +++
 2 files changed, 7 insertions(+)


diff -Nru a/include/linux/moduleparam.h b/include/linux/moduleparam.h
--- a/include/linux/moduleparam.h	2004-08-23 11:05:38 -07:00
+++ b/include/linux/moduleparam.h	2004-08-23 11:05:38 -07:00
@@ -89,6 +89,10 @@
 #define __param_check(name, p, type) \
 	static inline type *__check_##name(void) { return(p); }
 
+extern int param_set_byte(const char *val, struct kernel_param *kp);
+extern int param_get_byte(char *buffer, struct kernel_param *kp);
+#define param_check_byte(name, p) __param_check(name, p, unsigned char)
+
 extern int param_set_short(const char *val, struct kernel_param *kp);
 extern int param_get_short(char *buffer, struct kernel_param *kp);
 #define param_check_short(name, p) __param_check(name, p, short)
diff -Nru a/kernel/params.c b/kernel/params.c
--- a/kernel/params.c	2004-08-23 11:05:38 -07:00
+++ b/kernel/params.c	2004-08-23 11:05:38 -07:00
@@ -171,6 +171,7 @@
 		return sprintf(buffer, format, *((type *)kp->arg));	\
 	}
 
+STANDARD_PARAM_DEF(byte, unsigned char, "%c", unsigned long, simple_strtoul);
 STANDARD_PARAM_DEF(short, short, "%hi", long, simple_strtol);
 STANDARD_PARAM_DEF(ushort, unsigned short, "%hu", unsigned long, simple_strtoul);
 STANDARD_PARAM_DEF(int, int, "%i", long, simple_strtol);
@@ -339,6 +340,8 @@
 	return 0;
 }
 
+EXPORT_SYMBOL(param_set_byte);
+EXPORT_SYMBOL(param_get_byte);
 EXPORT_SYMBOL(param_set_short);
 EXPORT_SYMBOL(param_get_short);
 EXPORT_SYMBOL(param_set_ushort);

