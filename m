Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265385AbSKLAqk>; Mon, 11 Nov 2002 19:46:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265513AbSKLAqk>; Mon, 11 Nov 2002 19:46:40 -0500
Received: from e35.co.us.ibm.com ([32.97.110.133]:15515 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S265385AbSKLAqj>; Mon, 11 Nov 2002 19:46:39 -0500
Date: Mon, 11 Nov 2002 17:01:41 -0800
From: Hanna Linder <hannal@us.ibm.com>
Reply-To: Hanna Linder <hannal@us.ibm.com>
To: linux-kernel@vger.kernel.org
cc: hannal@us.ibm.com
Subject: [PATCH 2.4] list_entry -> container_of like in 2.5
Message-ID: <19250000.1037062901@w-hlinder>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


It was pointed out to me (thanks cdub!) that list_entry is equivalent
to container_of. However, in 2.5 list_entry simply calls container_of
as it is a more descriptive name. So here is a patch to both add
container_of and make list_entry a wrapper around it.

Thanks.

Hanna

 kernel.h |   11 +++++++++++
 list.h   |    2 +-
 2 files changed, 12 insertions(+), 1 deletion(-)

-----
diff -Nru linux-2.4.20-rc1/include/linux/kernel.h 
linux-container_of/include/linux/kernel.h
--- linux-2.4.20-rc1/include/linux/kernel.h	Mon Nov 11 16:53:25 2002
+++ linux-container_of/include/linux/kernel.h	Mon Nov 11 15:23:16 2002
@@ -174,6 +174,17 @@
 extern void __out_of_line_bug(int line) ATTRIB_NORET;
 #define out_of_line_bug() __out_of_line_bug(__LINE__)

+/*
+ * container_of - cast a member of a structure out to the containing 
structure
+ *
+ * @ptr:        the pointer to the member.
+ * @type:       the type of the container struct this is embedded in.
+ * @member:     the name of the member within the struct.
+ */
+#define container_of(ptr, type, member) ({                      \
+	const typeof( ((type *)0)->member ) *__mptr = (ptr);    \
+	(type *)( (char *)__mptr - offsetof(type,member) );})
+
 #endif /* __KERNEL__ */

 #define SI_LOAD_SHIFT	16
diff -Nru linux-2.4.20-rc1/include/linux/list.h 
linux-container_of/include/linux/list.h
--- linux-2.4.20-rc1/include/linux/list.h	Mon Nov 11 16:53:25 2002
+++ linux-container_of/include/linux/list.h	Mon Nov 11 16:50:06 2002
@@ -185,7 +185,7 @@
  * @member:	the name of the list_struct within the struct.
  */
 #define list_entry(ptr, type, member) \
-	((type *)((char *)(ptr)-(unsigned long)(&((type *)0)->member)))
+	container_of(ptr, type, member)

 /**
  * list_for_each	-	iterate over a list

