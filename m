Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262538AbUDENvk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Apr 2004 09:51:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262488AbUDENvc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Apr 2004 09:51:32 -0400
Received: from scilla.di.uniba.it ([193.204.187.135]:43982 "HELO
	scilla.di.uniba.it") by vger.kernel.org with SMTP id S262497AbUDENvZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Apr 2004 09:51:25 -0400
Date: Mon, 5 Apr 2004 15:50:55 +0200
From: "Angelo Dell'Aera" <buffer@antifork.org>
To: Linux-Kernel <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>
Subject: [PATCH] kernel 2.6.5-mm1 : laptop-mode
Message-Id: <20040405155055.3e9afab0.buffer@antifork.org>
Organization: Antifork Research, Inc.
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-PGP-Program: GNU Privacy Guard (http://www.gnupg.org)
X-PGP-PublicKey: http://buffer.antifork.org/privacy/buffer-gpg.asc
X-PGP-Fingerprint: 48CC B0D8 C394 CD30 355F E36D A4E3 48CF 19C1 5CA2
X-Operating-System: GNU-Linux
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


After upgrading to 2.6.5-mm1 I noticed the script laptop_mode
failed to initiliaze laptop mode. It is due to the new position
of the sysctl laptop_mode under /proc. This is an update to the
documentation (and the script). Please apply.

Regards.

--

Angelo Dell'Aera 'buffer' 
Antifork Research, Inc.	  	http://buffer.antifork.org




--- linux-2.6.5-mm1/Documentation/laptop-mode.txt.old	2004-04-05 15:39:25.000000000 +0200
+++ linux-2.6.5-mm1/Documentation/laptop-mode.txt	2004-04-05 15:47:33.000000000 +0200
@@ -80,7 +80,7 @@
 The details
 -----------
 
-Laptop-mode is controlled by the flag /proc/sys/vm/laptop_mode. When this
+Laptop-mode is controlled by the flag /proc/sys/fs/laptop_mode. When this
 flag is set, any physical disk read operation (that might have caused the
 hard disk to spin up) causes Linux to flush all dirty blocks. The result
 of this is that after a disk has spun down, it will not be spun up anymore
@@ -321,12 +321,12 @@
 # like the rest of the external world. Unfortunately this cannot be automated. :(
 XFS_HZ=1000
 
-if [ ! -e /proc/sys/vm/laptop_mode ]; then
+if [ ! -e /proc/sys/fs/laptop_mode ]; then
 	echo "Kernel is not patched with laptop_mode patch."
 	exit 1
 fi
 
-if [ ! -w /proc/sys/vm/laptop_mode ]; then
+if [ ! -w /proc/sys/fs/laptop_mode ]; then
 	echo "You do not have enough privileges to enable laptop_mode."
 	exit 1
 fi
@@ -355,11 +355,11 @@
 
 		case "$KLEVEL" in
 			"2.4")
-				echo "1"				> /proc/sys/vm/laptop_mode
+				echo "1"				> /proc/sys/fs/laptop_mode
 				echo "30 500 0 0 $AGE $AGE 60 20 0"	> /proc/sys/vm/bdflush
 				;;
 			"2.6")
-				echo "5"				> /proc/sys/vm/laptop_mode
+				echo "5"				> /proc/sys/fs/laptop_mode
 				echo "$AGE"				> /proc/sys/vm/dirty_writeback_centisecs
 				echo "$AGE"				> /proc/sys/vm/dirty_expire_centisecs
 				echo "$DIRTY_RATIO"			> /proc/sys/vm/dirty_ratio
@@ -389,7 +389,7 @@
 		U_AGE=$((100*$DEF_UPDATE))
 		B_AGE=$((100*$DEF_AGE))
 		echo -n "Stopping laptop_mode"
-		echo "0" > /proc/sys/vm/laptop_mode
+		echo "0" > /proc/sys/fs/laptop_mode
 		if [ -f /proc/sys/fs/xfs/age_buffer ] && [ ! -f /proc/sys/fs/xfs/lm_age_buffer ] ; then
 			# These need to be restored though, if there are no lm_*.
 			echo "$(($XFS_HZ*$DEF_XFS_AGE_BUFFER))" 	> /proc/sys/fs/xfs/age_buffer



