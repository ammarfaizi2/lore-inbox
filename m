Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265898AbUFVVey@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265898AbUFVVey (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 17:34:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265149AbUFVVdk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 17:33:40 -0400
Received: from fw.osdl.org ([65.172.181.6]:7573 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265132AbUFVVbO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 17:31:14 -0400
Date: Tue, 22 Jun 2004 14:28:01 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: lkml <linux-kernel@vger.kernel.org>
Cc: akpm <akpm@osdl.org>
Subject: [PATCH] update ikconfig generator script
Message-Id: <20040622142801.787c04fc.rddunlap@osdl.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



http://bugme.osdl.org/show_bug.cgi?id=2701

Current script has problems with some shells and utilities.
Remove use of 'echo' in the script.

From: Roman Zippel <zippel@linux-m68k.org>
Signed-off-by: Randy Dunlap <rddunlap@osdl.org>


Index: scripts/mkconfigs
===================================================================
RCS file: /home/other/cvs/linux/linux-2.6/scripts/mkconfigs,v
retrieving revision 1.1.1.3
diff -u -p -r1.1.1.3 mkconfigs
--- a/scripts/mkconfigs	29 Sep 2003 12:27:27 -0000	1.1.1.3
+++ b/scripts/mkconfigs	28 May 2004 11:12:33 -0000
@@ -34,10 +34,10 @@ fi
 config=$1
 makefile=$2
 
-echo "#ifndef _IKCONFIG_H"
-echo "#define _IKCONFIG_H"
-echo \
-"/*
+cat << EOF
+#ifndef _IKCONFIG_H
+#define _IKCONFIG_H
+/*
  * 
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -58,10 +58,10 @@ echo \
  * 
  * This file is generated automatically by scripts/mkconfigs. Do not edit.
  *
- */"
-
-echo "static char const ikconfig_config[] __attribute__((unused)) = "
-echo "\"CONFIG_BEGIN=n\\n\\"
-echo "`cat $config | sed 's/\"/\\\\\"/g' | grep "^#\? \?CONFIG_" | awk '{ print $0 "\\\\n\\\\" }' `"
-echo "CONFIG_END=n\\n\";"
-echo "#endif /* _IKCONFIG_H */"
+ */
+static char const ikconfig_config[] __attribute__((unused)) =
+"CONFIG_BEGIN=n\\n\\
+$(sed < $config -n 's/"/\\"/g;/^#\? \?CONFIG_/s/.*/&\\n\\/p')
+CONFIG_END=n\\n";
+#endif /* _IKCONFIG_H */
+EOF
