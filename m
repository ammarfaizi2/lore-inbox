Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129231AbRBABZM>; Wed, 31 Jan 2001 20:25:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129232AbRBABZC>; Wed, 31 Jan 2001 20:25:02 -0500
Received: from c1313109-a.potlnd1.or.home.com ([65.0.121.190]:59404 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S129231AbRBABYu>;
	Wed, 31 Jan 2001 20:24:50 -0500
Date: Wed, 31 Jan 2001 17:23:07 -0800
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org, stackguard@immunix.org
Subject: [PATCH] StackGuard gcc patch for 2.4.1
Message-ID: <20010131172307.A13132@kroah.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="TB36FDmn/VVEgNH/"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-Operating-System: Linux 2.2.18-immunix (i586)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--TB36FDmn/VVEgNH/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Here's the latest StackGuard patch for the 2.4.1 kernel.

greg k-h

-- 
greg@(kroah|wirex).com

--TB36FDmn/VVEgNH/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="canary-2.4.1.patch"

diff -Naur -X dontdiff linux-2.4.1/Makefile linux-2.4.1-greg/Makefile
--- linux-2.4.1/Makefile	Wed Jan 31 17:15:05 2001
+++ linux-2.4.1-greg/Makefile	Wed Jan 31 17:14:11 2001
@@ -227,6 +227,10 @@
 
 include arch/$(ARCH)/Makefile
 
+# if we have a StackGuard compiler, then we need to turn off the canary death handler stuff
+CFLAGS	+= $(shell if $(CC) -fno-canary-all-functions -S -o /dev/null -xc /dev/null >/dev/null 2>&1; then echo "-fno-canary-all-functions"; fi)
+CFLAGS	+= $(shell if $(CC) -mno-terminator-canary -S -o /dev/null -xc /dev/null >/dev/null 2>&1; then echo "-mno-terminator-canary"; fi)
+
 export	CPPFLAGS CFLAGS AFLAGS
 
 export	NETWORKS DRIVERS LIBS HEAD LDFLAGS LINKFLAGS MAKEBOOT ASFLAGS
diff -Naur -X dontdiff linux-2.4.1/arch/i386/boot/compressed/Makefile linux-2.4.1-greg/arch/i386/boot/compressed/Makefile
--- linux-2.4.1/arch/i386/boot/compressed/Makefile	Tue Mar  7 11:04:12 2000
+++ linux-2.4.1-greg/arch/i386/boot/compressed/Makefile	Wed Jan 31 17:14:11 2001
@@ -12,6 +12,10 @@
 CFLAGS = $(CPPFLAGS) -O2 -DSTDC_HEADERS
 ZLDFLAGS = -e startup_32
 
+# if we have a StackGuard compiler, then we need to turn off the canary death handler stuff
+CFLAGS += $(shell if $(CC) -fno-canary-all-functions -S -o /dev/null -xc /dev/null >/dev/null 2>&1; then echo "-fno-canary-all-functions"; fi)
+CFLAGS += $(shell if $(CC) -mno-terminator-canary -S -o /dev/null -xc /dev/null >/dev/null 2>&1; then echo "-mno-terminator-canary"; fi)
+
 #
 # ZIMAGE_OFFSET is the load offset of the compression loader
 # BZIMAGE_OFFSET is the load offset of the high loaded compression loader

--TB36FDmn/VVEgNH/--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
