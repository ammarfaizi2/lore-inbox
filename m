Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261689AbSIXPI6>; Tue, 24 Sep 2002 11:08:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261691AbSIXPI6>; Tue, 24 Sep 2002 11:08:58 -0400
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:58281
	"EHLO Bill-The-Cat.bloom.county") by vger.kernel.org with ESMTP
	id <S261689AbSIXPI5>; Tue, 24 Sep 2002 11:08:57 -0400
Date: Tue, 24 Sep 2002 08:13:51 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       kbuild-devel@lists.sourceforge.net
Subject: [PATCH 2.5] Make scripts/Configure follow the definition of 'int'
Message-ID: <20020924151351.GA788@opus.bloom.county>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, scripts/Configure has code for the 'int' verb to take a
min/max.  This violates the spec described in
Documentation/kbuild/config-language.txt.  It also requires that if a
default is outside of +/- 10,000,000 that defaults be provided, or
'config' and 'oldconfig' will get stuck.  The following removes the
support for a min/max from scripts/Configure.

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

===== scripts/Configure 1.6 vs edited =====
--- 1.6/scripts/Configure	Wed Jun  5 17:40:52 2002
+++ edited/scripts/Configure	Tue Sep 24 07:58:59 2002
@@ -415,25 +415,15 @@
 #
 # int processes an integer argument with optional limits
 #
-#	int question define default [min max]
+#	int question define default
 #
 function int () {
 	old=$(eval echo "\${$2}")
 	def=${old:-$3}
-	if [ $# -gt 3 ]; then
-	  min=$4
-	else
-	  min=-10000000    # !!
-	fi
-	if [ $# -gt 4 ]; then
-	  max=$5
-	else
-	  max=10000000     # !!
-	fi
 	rndval $2
 	while :; do
 	  readln "$1 ($2) [$def] " "$def" "$old"
-	  if expr \( \( $ans + 0 \) \>= $min \) \& \( $ans \<= $max \) >/dev/null 2>&1 ; then
+	  if expr "$ans" : '[0-9]*$' > /dev/null; then
             define_int "$2" "$ans"
 	    break
           else
