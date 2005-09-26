Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751446AbVIZMKd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751446AbVIZMKd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Sep 2005 08:10:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751510AbVIZMKc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Sep 2005 08:10:32 -0400
Received: from web51004.mail.yahoo.com ([206.190.38.135]:44680 "HELO
	web51004.mail.yahoo.com") by vger.kernel.org with SMTP
	id S1751446AbVIZMKb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Sep 2005 08:10:31 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=x+xGUEFrfaaohD7JvPK+ecyrDvdtN672S9NkRjq2gYsF/YqkVFNTV2ozieBu7rki7wXh0uk3m9rcAn81tpbm43jj5dGchSE3yv3+zq1zdCHX8jFciPmO82CkyHqtUPZvD7Ba7EMDdiafaMKHN58YSxmvW86o8kSABAQVT2mUvKs=  ;
Message-ID: <20050926121030.53593.qmail@web51004.mail.yahoo.com>
Date: Mon, 26 Sep 2005 05:10:30 -0700 (PDT)
From: Ahmad Reza Cheraghi <a_r_cheraghi@yahoo.com>
Subject: [PATCH](rules) Automatic Configuration of a Kernel
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -uNr linux.org/scripts/kconfig/rules/arch.sh
linux-2.6.13.2/scripts/kconfig/rules/arch.sh
--- linux.org/scripts/kconfig/rules/arch.sh	1970-01-01
01:00:00.000000000 +0100
+++ linux-2.6.13.2/scripts/kconfig/rules/arch.sh
2005-09-24 11:57:15.000000000 +0200
@@ -0,0 +1,8 @@
+#!/bin/sh
+
+if uname -m | sed -e s/i.86/i386/ -e s/sun4u/sparc64/
-e s/arm.*/arm/ -e s/sa110/arm/ | grep -sqE "$1"
+   then
+	echo "y\n"
+else
+	echo "n\n"
+fi
diff -uNr linux.org/scripts/kconfig/rules/cpugrep.sh
linux-2.6.13.2/scripts/kconfig/rules/cpugrep.sh
--- linux.org/scripts/kconfig/rules/cpugrep.sh
1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.13.2/scripts/kconfig/rules/cpugrep.sh
2005-09-24 11:57:15.000000000 +0200
@@ -0,0 +1,11 @@
+#!/bin/sh
+
+if grep -sq "$1" /proc/cpuinfo
+  then
+         echo "y\n"
+        
+  else
+        echo "n\n"
+
+fi
+
diff -uNr linux.org/scripts/kconfig/rules/hw_egrep.sh
linux-2.6.13.2/scripts/kconfig/rules/hw_egrep.sh
--- linux.org/scripts/kconfig/rules/hw_egrep.sh
1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.13.2/scripts/kconfig/rules/hw_egrep.sh
2005-09-24 11:57:15.000000000 +0200
@@ -0,0 +1,11 @@
+#!/bin/sh
+
+if lspci | grep -sqE "$1"
+  then
+	echo "y\n"
+elif grep -sqE "$1" /var/log/dmesg
+  then 
+	echo "y\n"
+else
+  echo "n\n"
+fi
diff -uNr linux.org/scripts/kconfig/rules/hw_grep.sh
linux-2.6.13.2/scripts/kconfig/rules/hw_grep.sh
--- linux.org/scripts/kconfig/rules/hw_grep.sh
1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.13.2/scripts/kconfig/rules/hw_grep.sh
2005-09-24 11:57:15.000000000 +0200
@@ -0,0 +1,11 @@
+#!/bin/sh
+
+if lspci | grep -sq "$1"
+  then
+	echo "y\n"
+elif grep -sq "$1" /var/log/dmesg
+  then 
+	echo "y\n"
+else
+  echo "n\n"
+fi




		
__________________________________ 
Yahoo! Mail - PC Magazine Editors' Choice 2005 
http://mail.yahoo.com
