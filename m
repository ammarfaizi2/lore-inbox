Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129183AbRAEGFG>; Fri, 5 Jan 2001 01:05:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129267AbRAEGE4>; Fri, 5 Jan 2001 01:04:56 -0500
Received: from c1313109-a.potlnd1.or.home.com ([65.0.121.190]:23558 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S129183AbRAEGEk>;
	Fri, 5 Jan 2001 01:04:40 -0500
Date: Thu, 4 Jan 2001 22:02:41 -0800
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org, stackguard@immunix.org
Subject: [PATCH] StackGuard patch for 2.4.0
Message-ID: <20010104220241.B1237@kroah.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="n8g4imXOkfNTN/H1"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-Operating-System: Linux 2.2.16-immunix (i586)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--n8g4imXOkfNTN/H1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Just because I _know_ someone will ask me if I don't send this out, here
is the patch to allow the kernel to compile with the StackGuard version
of gcc.

thanks,

greg k-h

-- 
greg@(kroah|wirex).com

--n8g4imXOkfNTN/H1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="canary-2.4.0.patch"

diff -Naur -X dontdiff linux-2.4.0/Makefile linux-2.4.0-greg/Makefile
--- linux-2.4.0/Makefile	Thu Jan  4 13:48:13 2001
+++ linux-2.4.0-greg/Makefile	Thu Jan  4 21:40:49 2001
@@ -228,6 +228,10 @@
 
 include arch/$(ARCH)/Makefile
 
+# if we have a StackGuard compiler, then we need to turn off the canary death handler stuff
+CFLAGS	+= $(shell if $(CC) -fno-canary-all-functions -S -o /dev/null -xc /dev/null >/dev/null 2>&1; then echo "-fno-canary-all-functions"; fi)
+CFLAGS	+= $(shell if $(CC) -mno-terminator-canary -S -o /dev/null -xc /dev/null >/dev/null 2>&1; then echo "-mno-terminator-canary"; fi)
+
 export	CPPFLAGS CFLAGS AFLAGS
 
 export	NETWORKS DRIVERS LIBS HEAD LDFLAGS LINKFLAGS MAKEBOOT ASFLAGS
diff -Naur -X dontdiff linux-2.4.0/arch/i386/boot/compressed/Makefile linux-2.4.0-greg/arch/i386/boot/compressed/Makefile
--- linux-2.4.0/arch/i386/boot/compressed/Makefile	Tue Mar  7 11:04:12 2000
+++ linux-2.4.0-greg/arch/i386/boot/compressed/Makefile	Thu Jan  4 21:40:49 2001
@@ -12,6 +12,12 @@
 CFLAGS = $(CPPFLAGS) -O2 -DSTDC_HEADERS
 ZLDFLAGS = -e startup_32
 
+# if we have a StackGuard compiler, then we need to turn off the canary death handler stuff
+CFLAGS += $(shell if $(CC) -fno-canary-all-functions -S -o /dev/null -xc /dev/null >/dev/null 2>&1; then echo "-fno-canary-all-functions"; fi)
+CFLAGS += $(shell if $(CC) -mno-terminator-canary -S -o /dev/null -xc /dev/null >/dev/null 2>&1; then echo "-mno-terminator-canary"; fi)
+
+
+
 #
 # ZIMAGE_OFFSET is the load offset of the compression loader
 # BZIMAGE_OFFSET is the load offset of the high loaded compression loader

--n8g4imXOkfNTN/H1--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
