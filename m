Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S131932AbQKZXKh>; Sun, 26 Nov 2000 18:10:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S131338AbQKZXKS>; Sun, 26 Nov 2000 18:10:18 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:25616 "EHLO
        vger.timpanogas.org") by vger.kernel.org with ESMTP
        id <S131932AbQKZXKH>; Sun, 26 Nov 2000 18:10:07 -0500
Date: Sun, 26 Nov 2000 16:36:55 -0700
From: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] modutils 2.3.20 and beyond
Message-ID: <20001126163655.A1637@vger.timpanogas.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Kj7319i9nmIyA2yE"
X-Mailer: Mutt 1.0.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Kj7319i9nmIyA2yE
Content-Type: text/plain; charset=us-ascii



Keith,

Please consider the attached patch for inclusion in all future versions
of the modutils depmod program for compatiblity with RedHat and 
RedHat derived Linux distributions.  This patch only requires 
4 very short changes to depmod.c as opposed to thousands of
changes necessary in anaconda and other RedHat compatible 
programs and scripts to work with your standard depmod
programs without these changes.  

Thanks

Jeff

 

--Kj7319i9nmIyA2yE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="modutils-2.3.20.patch"

--- modutils-2.3.20/depmod/depmod.c.chmou	Thu Nov 16 01:40:09 2000
+++ modutils-2.3.20/depmod/depmod.c	Wed Nov 22 05:18:09 2000
@@ -188,6 +188,7 @@
 static SYMBOL *symavail;
 static SYMBOL *maxsyms;
 static LIST_SYMBOL *chunk;
+static int ignore_symbol_versions;

 static int quiet;	/* Don't print errors */
 static int showerror;	/* Shows undefined symbols */
@@ -1098,7 +1099,9 @@
 		{"errsyms", 0, 0, 'e'},
 		{"filesyms", 1, 0, 'F'},
 		{"help", 0, 0, 'h'},
+		{"ignore-versions", 0, 0, 'i'},
 		{"show", 0, 0, 'n'},
+		{"system-map", 1, 0, 'm'}, /* backward compatibility, same as 'F' */
 		{"quiet", 0, 0, 'q'},
 		{"syslog", 0, 0, 's'},
 		{"verbose", 0, 0, 'v'},
@@ -1109,7 +1112,7 @@
 
 	error_file = "depmod";
 
-	while ((o = getopt_long(argc, argv, "aAb:C:eF:hnqsvVr",
+	while ((o = getopt_long(argc, argv, "aAb:C:eF:him:nqsvVr",
 				&long_opts[0], NULL)) != EOF) {
 		switch (o) {
 		case 'A':
@@ -1132,11 +1135,16 @@
 			return 0;
 			break;
 
+		case 'i':
+			ignore_symbol_versions = 1;
+			break;
+
 		case 'C':
 			conf_file = optarg;
 			break;
 
 		case 'F':
+		case 'm':
 			file_syms = optarg;
 			break;

--Kj7319i9nmIyA2yE--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
