Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262496AbVCSN33@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262496AbVCSN33 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Mar 2005 08:29:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262500AbVCSNVh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Mar 2005 08:21:37 -0500
Received: from coderock.org ([193.77.147.115]:65159 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S262475AbVCSNRi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Mar 2005 08:17:38 -0500
Subject: [patch 04/10] ixj* - compile warning cleanup
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, domen@coderock.org, yrgrknmxpzlk@gawab.com
From: domen@coderock.org
Date: Sat, 19 Mar 2005 14:17:26 +0100
Message-Id: <20050319131726.708581F1EE@trashy.coderock.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



compile warning cleanup - suggested by Adrian Bunk; remove 
unmaintained rcs char strings from source and handle the occurrences of 
their use, make sure kernel-userspace issues taken care of; break out 
into separate patch

Signed-off-by: Stephen Biggs <yrgrknmxpzlk@gawab.com>
Signed-off-by: Domen Puncer <domen@coderock.org>
---


 kj-domen/drivers/telephony/ixj.c |   18 +++++++++---------
 kj-domen/drivers/telephony/ixj.h |    2 --
 kj-domen/include/linux/ixjuser.h |    2 --
 3 files changed, 9 insertions(+), 13 deletions(-)

diff -puN drivers/telephony/ixj.c~return_code-drivers_telephony_ixj drivers/telephony/ixj.c
--- kj/drivers/telephony/ixj.c~return_code-drivers_telephony_ixj	2005-03-18 20:05:14.000000000 +0100
+++ kj-domen/drivers/telephony/ixj.c	2005-03-18 20:05:14.000000000 +0100
@@ -41,9 +41,6 @@
  *
  ***************************************************************************/
 
-static char ixj_c_rcsid[] = "$Id: ixj.c,v 4.7 2001/08/13 06:19:33 craigs Exp $";
-static char ixj_c_revision[] = "$Revision: 4.7 $";
-
 /*
  * $Log: ixj.c,v $
  *
@@ -6172,8 +6169,14 @@ static int ixj_ioctl(struct inode *inode
 		retval = j->serial;
 		break;
 	case IXJCTL_VERSION:
-		if (copy_to_user(argp, ixj_c_revision, strlen(ixj_c_revision))) 
-			retval = -EFAULT;
+		{
+			char arg_str[100];
+			snprintf(arg_str, sizeof(arg_str),
+				"\nDriver version %i.%i.%i", IXJ_VER_MAJOR,
+				IXJ_VER_MINOR, IXJ_BLD_VER);
+			if (copy_to_user(argp, arg_str, strlen(arg_str)))
+				retval = -EFAULT;
+		}
 		break;
 	case PHONE_RING_CADENCE:
 		j->ring_cadence = arg;
@@ -7168,9 +7171,6 @@ static int ixj_get_status_proc(char *buf
 	int cnt;
 	IXJ *j;
 	len = 0;
-	len += sprintf(buf + len, "%s", ixj_c_rcsid);
-	len += sprintf(buf + len, "\n%s", ixj_h_rcsid);
-	len += sprintf(buf + len, "\n%s", ixjuser_h_rcsid);
 	len += sprintf(buf + len, "\nDriver version %i.%i.%i", IXJ_VER_MAJOR, IXJ_VER_MINOR, IXJ_BLD_VER);
 	len += sprintf(buf + len, "\nsizeof IXJ struct %Zd bytes", sizeof(IXJ));
 	len += sprintf(buf + len, "\nsizeof DAA struct %Zd bytes", sizeof(DAA_REGS));
@@ -7790,7 +7790,7 @@ static int __init ixj_init(void)
 	if ((probe = ixj_probe_pci(&cnt)) < 0) {
 		return probe;
 	}
-	printk("%s\n", ixj_c_rcsid);
+	printk(KERN_INFO "ixj driver initialized.\n");
 	create_proc_read_entry ("ixj", 0, NULL, ixj_read_proc, NULL);
 	return probe;
 }
diff -puN drivers/telephony/ixj.h~return_code-drivers_telephony_ixj drivers/telephony/ixj.h
--- kj/drivers/telephony/ixj.h~return_code-drivers_telephony_ixj	2005-03-18 20:05:14.000000000 +0100
+++ kj-domen/drivers/telephony/ixj.h	2005-03-18 20:05:14.000000000 +0100
@@ -38,8 +38,6 @@
  * TO PROVIDE MAINTENANCE, SUPPORT, UPDATES, ENHANCEMENTS, OR MODIFICATIONS.
  *
  *****************************************************************************/
-static char ixj_h_rcsid[] = "$Id: ixj.h,v 4.1 2001/08/04 14:49:27 craigs Exp $";
-
 #define IXJ_VERSION 3031
 
 #include <linux/version.h>
diff -puN include/linux/ixjuser.h~return_code-drivers_telephony_ixj include/linux/ixjuser.h
--- kj/include/linux/ixjuser.h~return_code-drivers_telephony_ixj	2005-03-18 20:05:14.000000000 +0100
+++ kj-domen/include/linux/ixjuser.h	2005-03-18 20:05:14.000000000 +0100
@@ -42,8 +42,6 @@
  *
  *****************************************************************************/
 
-static char ixjuser_h_rcsid[] = "$Id: ixjuser.h,v 4.1 2001/08/05 00:17:37 craigs Exp $";
-
 #include <linux/telephony.h>
 
 
_
