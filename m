Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131533AbRAUIXu>; Sun, 21 Jan 2001 03:23:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130634AbRAUIXb>; Sun, 21 Jan 2001 03:23:31 -0500
Received: from freya.yggdrasil.com ([209.249.10.20]:49878 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S130006AbRAUIXV>; Sun, 21 Jan 2001 03:23:21 -0500
Date: Sun, 21 Jan 2001 00:23:19 -0800
From: "Adam J. Richter" <adam@yggdrasil.com>
To: acpi@phobos.fachschaften.tu-muenchen.de, linux-kernel@vger.kernel.org
Cc: torvalds@transmeta.com
Subject: [PATCH] linux-2.4.1-pre9/include/linux/acpi.h broke acpid compilation
Message-ID: <20010121002319.A8447@adam.yggdrasil.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="k1lZvvs/B4yU6o8G"
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--k1lZvvs/B4yU6o8G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

	linux-2.4.1-pre9/include/linux/acpi.h contains declares the
routine acpi_get_rsdp_ptr returning the kernel-only type "u64", without
bracketing the declaration in "#ifdef __KERNEL__...#endif".  Consequently,
a user level program that attempts to include <linux/acpi.h>, such as
acpid, gets a compilation error.  The following patch fix the problem
by stretching an earlier "#ifdef __KERNEL__...#endif" area to cover
the acpi_get_rsdp_ptr declaration.

-- 
Adam J. Richter     __     ______________   4880 Stevens Creek Blvd, Suite 104
adam@yggdrasil.com     \ /                  San Jose, California 95129-1034
+1 408 261-6630         | g g d r a s i l   United States of America
fax +1 408 261-6631      "Free Software For The Rest Of Us."

--k1lZvvs/B4yU6o8G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="acpi.diff"

--- linux-2.4.1-pre9/include/linux/acpi.h	Fri Dec 29 14:07:24 2000
+++ linux/include/linux/acpi.h	Sun Jan 21 00:14:59 2001
@@ -26,9 +26,9 @@
 #ifdef __KERNEL__
 #include <linux/sched.h>
 #include <linux/wait.h>
-#endif /* __KERNEL__ */
 
-u64 acpi_get_rsdp_ptr(void);
+extern u64 acpi_get_rsdp_ptr(void);
+#endif /* __KERNEL__ */
 
 /*
  * System sleep states

--k1lZvvs/B4yU6o8G--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
