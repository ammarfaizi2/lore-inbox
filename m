Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131523AbQLLPsD>; Tue, 12 Dec 2000 10:48:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131951AbQLLPrx>; Tue, 12 Dec 2000 10:47:53 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:60430 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S131523AbQLLPrk>;
	Tue, 12 Dec 2000 10:47:40 -0500
Date: Tue, 12 Dec 2000 15:17:08 +0000
From: Matthew Wilcox <matthew@wil.cx>
To: torvalds@transmeta.com
Cc: linux-kbuild@torque.net, linux-kernel@vger.kernel.org
Subject: [PATCH] make config w/ Pentium-II
Message-ID: <20001212151708.A6915@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I built 2.4.0-test10 for my laptop and got caught out by `make config'.
When I typed `Pentium-II' for my CPU type, it selected Pentium-III and
my kernel wouldn't boot.  To prevent errors of this type, please apply
this patch.  As a bonus, `Celeron' will now work as an answer too.

Please apply.

diff -urNX dontdiff linux/scripts/Configure linux-test10/scripts/Configure
--- linux/scripts/Configure	Mon Oct 30 22:44:29 2000
+++ linux-test10/scripts/Configure	Tue Dec 12 03:39:41 2000
@@ -479,11 +479,14 @@
 		while [ -n "$1" ]; do
 			name=$(echo $1 | tr a-z A-Z)
 			case "$name" in
-				"$ans"* )
-					if [ "$name" = "$ans" ]; then
-						val="$2"
-						break	# stop on exact match
-					fi
+				"$ans"* | */"$ans"* )
+					case "$name" in
+						"$ans" | */"$ans"/* | \
+						"$ans"/* | */"$ans" )
+							val="$2"
+							break # exact match
+						;;
+					esac
 					if [ -n "$val" ]; then
 						echo;echo \
 		"  Sorry, \"$ans\" is ambiguous; please enter a longer string."

-- 
Revolutions do not require corporate support.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
