Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129906AbQLKX3v>; Mon, 11 Dec 2000 18:29:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130067AbQLKX3l>; Mon, 11 Dec 2000 18:29:41 -0500
Received: from freya.yggdrasil.com ([209.249.10.20]:9196 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S129906AbQLKX3b>; Mon, 11 Dec 2000 18:29:31 -0500
Date: Mon, 11 Dec 2000 14:59:01 -0800
From: "Adam J. Richter" <adam@yggdrasil.com>
To: linux-kernel@vger.kernel.org
Cc: torvalds@transmeta.com
Subject: PATCH: linux-2.4.0-test12pre8/include/linux/module.h breaks sysklogd compilation
Message-ID: <20001211145901.A8047@baldur.yggdrasil.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Nq2Wo0NMKNjxTN9z"
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Nq2Wo0NMKNjxTN9z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


	linux-2.4.0test12pre8/include/linux/module.h contains some
kernel-specific declarations that now reference struct list_head, which
which is only defined when __KERNEL__ is set.  This causes sysklogd
and probably any other user level program that needs to include
<linux/module.h> to fail to compile.

	The following patch brackets the (unused) offending declarations
in #ifdef __KERNEL__...#endif.

-- 
Adam J. Richter     __     ______________   4880 Stevens Creek Blvd, Suite 104
adam@yggdrasil.com     \ /                  San Jose, California 95129-1034
+1 408 261-6630         | g g d r a s i l   United States of America
fax +1 408 261-6631      "Free Software For The Rest Of Us."

--Nq2Wo0NMKNjxTN9z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="modules.diff"

Index: linux/include/linux/module.h
===================================================================
RCS file: /usr/src.repository/repository/linux/include/linux/module.h,v
retrieving revision 1.2
diff -u -r1.2 module.h
--- linux/include/linux/module.h	2000/12/04 11:57:16	1.2
+++ linux/include/linux/module.h	2000/12/11 22:54:20
@@ -168,6 +168,7 @@
  * Keith Owens <kaos@ocs.com.au> 28 Oct 2000.
  */
 
+#ifdef __KERNEL__
 #define HAVE_INTER_MODULE
 extern void inter_module_register(const char *, struct module *, const void *);
 extern void inter_module_unregister(const char *);
@@ -183,6 +184,7 @@
 };
 
 extern int try_inc_mod_count(struct module *mod);
+#endif
 
 #if defined(MODULE) && !defined(__GENKSYMS__)
 

--Nq2Wo0NMKNjxTN9z--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
