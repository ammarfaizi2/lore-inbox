Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261602AbUKOOSu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261602AbUKOOSu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Nov 2004 09:18:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261604AbUKOOSu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Nov 2004 09:18:50 -0500
Received: from mailr.eris.qinetiq.com ([128.98.1.9]:2241 "HELO
	mailr.qinetiq-tim.net") by vger.kernel.org with SMTP
	id S261602AbUKOOSM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Nov 2004 09:18:12 -0500
From: Mark Watts <m.watts@eris.qinetiq.com>
Organization: QinetiQ
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Documentation/networking/bonding.txt update
Date: Mon, 15 Nov 2004 14:23:05 +0000
User-Agent: KMail/1.6.1
Cc: bonding-devel@lists.sourceforge.net
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Message-Id: <200411151423.05457.m.watts@eris.qinetiq.com>
X-AntiVirus: checked by Vexira MailArmor (version: 2.0.1.16; VAE: 6.28.0.12; VDF: 6.28.0.72; host: mailr.qinetiq-tim.net)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


Updates to Documentation/networking/bonding.txt to reflect an apparent change 
in how to load the bonding.o driver more than once (Based on experience with 
migrating a quad-nic/dual-bond server from 2.4.x to 2.6.x).


Signed-off-by: Mark Watts <m.watts@eris.qinetiq.com>


diff -Nurd linux-2.6.9/Documentation/networking/bonding.txt
linux-2.6.9-mrw/Documentation/networking/bonding.txt
- --- linux-2.6.9/Documentation/networking/bonding.txt    2004-10-18
22:53:45.000000000 +0100
+++ linux-2.6.9-mrw/Documentation/networking/bonding.txt        2004-11-02
09:48:05.831738136 +0000
@@ -418,17 +418,27 @@
 driver multiple times allows each instance of the driver to have differing
 options.

+Note: 2.6 kernel modules are capable of being loaded multiple times without
+being explicitly loaded twice. The bonding.o driver however, defaults to
+only allowing you to load it once, unless you use the max_bonds parameter.
+Using "-o bonding1" is depreciated for 2.6 kernels.
+
 For example, to configure two bonding interfaces, one with mii link
 monitoring performed every 100 milliseconds, and one with ARP link
- -monitoring performed every 200 milliseconds, the /etc/conf.modules should
+monitoring performed every 200 milliseconds, the /etc/modprobe.conf should
 resemble the following:

 alias bond0 bonding
 alias bond1 bonding

+# For Kernel 2.4 (/etc/modules.conf or conf.modules):
 options bond0 miimon=100
 options bond1 -o bonding1 arp_interval=200 arp_ip_target=10.0.0.1

+# for Kernel 2.6:
+options bond0 miimon=100 max_bonds=2
+options bond1 arp_interval=200 arp_ip_target=10.0.0.1
+
 Configuring Multiple ARP Targets
 ================================



- -- 
Mark Watts
Senior Systems Engineer
QinetiQ Trusted Information Management
Trusted Solutions and Services group
GPG Public Key ID: 455420ED

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFBmLvJBn4EFUVUIO0RAm5BAJ9+NiHTHtdUwdR3NE69dnD0Y7tQ3gCgxMUY
CfRSAabygSimbUgRHRPO05s=
=mu17
-----END PGP SIGNATURE-----
