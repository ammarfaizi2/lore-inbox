Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131183AbRCKB00>; Sat, 10 Mar 2001 20:26:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131184AbRCKB0Q>; Sat, 10 Mar 2001 20:26:16 -0500
Received: from d146.as5200.mesatop.com ([208.164.122.146]:61834 "HELO
	localhost.localdomain") by vger.kernel.org with SMTP
	id <S131183AbRCKB0C>; Sat, 10 Mar 2001 20:26:02 -0500
From: Steven Cole <elenstev@mesatop.com>
Reply-To: elenstev@mesatop.com
Date: Sat, 10 Mar 2001 18:29:10 -0700
X-Mailer: KMail [version 1.1.99]
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Cc: alan@lxorguk.ukuu.org.uk
Subject: [PATCH] remove duplicate Configure.help entries in 2.4.2-ac18
MIME-Version: 1.0
Message-Id: <01031018291003.08110@localhost.localdomain>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As of 2.4.2-ac18, there are two CONFIG options which have two entries
in Documentation/Configure.help.

These are CONFIG_IP_NF_TARGET_TCPMSS and CONFIG_DEBUG_IOVIRT.

The first of these has two identical entries, so this patch deletes the duplicate
entry.

The second, CONFIG_DEBUG_IOVIRT, has a second but different entry in
Configure.help.  I've merged one perhaps useful line from that second (and
therefore ignored) entry into the first one.  The new line (updated) is:
"This can be very useful for porting drivers from 2.2 to 2.4."
You can see the original comment near the end of the patch, where the
second entry is deleted.

This patch is against 2.4.2-ac18.

Steven

--- linux/Documentation/Configure.help.orig     Sat Mar 10 17:50:58 2001
+++ linux/Documentation/Configure.help  Sat Mar 10 18:05:57 2001
@@ -2045,31 +2045,6 @@
   If you want to compile it as a module, say M here and read
   Documentation/modules.txt.  If unsure, say `N'.
 
-TCPMSS target support
-CONFIG_IP_NF_TARGET_TCPMSS
-  This option adds a `TCPMSS' target, which allows you to alter the
-  MSS value of TCP SYN packets, to control the maximum size for that
-  connection (usually limiting it to your outgoing interface's MTU
-  minus 40).
-
-  This is used to overcome criminally braindead ISPs or servers which
-  block ICMP Fragmentation Needed packets.  The symptoms of this
-  problem are that everything works fine from your Linux
-  firewall/router, but machines behind it can never exchange large
-  packets:
-       1) Web browsers connect, then hang with no data received.
-       2) Small mail works fine, but large emails hang.
-       3) ssh works fine, but scp hangs after initial handshaking.
-
-  Workaround: activate this option and add a rule to your firewall
-  configuration like:
-
-        iptables -A FORWARD -p tcp --tcp-flags SYN,RST SYN \
-                -j TCPMSS --clamp-mss-to-pmtu
-
-  If you want to compile it as a module, say M here and read
-  Documentation/modules.txt.  If unsure, say `N'.
-
 LOG target support
 CONFIG_IP_NF_TARGET_LOG
   This option adds a `LOG' target, which allows you to create rules in
@@ -15225,6 +15200,9 @@
   If you say Y here, all the memory mapped input and output on
   devices will go through a check to catch access to unmapped
   ISA addresses, that can still be used by old drivers.
+
+  This can be very useful for porting drivers from 2.2 to 2.4.
+
   If you say N, I/O will be faster and kernel will be a bit smaller,
   but no check will be done.
 
@@ -17885,12 +17863,6 @@
   Say Y here to have the kernel do limited verification on memory 
   allocation as well as poisoning memory on free to catch use of freed 
   memory.
-
-Memory mapped I/O debugging
-CONFIG_DEBUG_IOVIRT
-  Say Y here to get warned whenever an attempt is made to do I/O on 
-  obviously invalid addresses such as those generated when ioremap()
-  calls are forgotten. Very useful for porting drivers from 2.0/2.2
 
 Spinlock debugging
 CONFIG_DEBUG_SPINLOCK
