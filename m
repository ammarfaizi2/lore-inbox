Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268031AbTGTTbO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jul 2003 15:31:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268051AbTGTTbO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jul 2003 15:31:14 -0400
Received: from postfix4-1.free.fr ([213.228.0.62]:14750 "EHLO
	postfix4-1.free.fr") by vger.kernel.org with ESMTP id S268031AbTGTTbJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jul 2003 15:31:09 -0400
Message-ID: <3F1AF208.3030409@free.fr>
Date: Sun, 20 Jul 2003 21:48:24 +0200
From: Eric Valette <eric.valette@free.fr>
Reply-To: eric.valette@free.fr
Organization: HOME
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030704 Debian/1.4-1
X-Accept-Language: en
MIME-Version: 1.0
To: "Grover, Andrew" <andrew.grover@intel.com>, sziwan@hell.org.pl,
       akpm@osdl.org, mikpe@csd.uu.se
Cc: linux-kernel@vger.kernel.org, acpi-devel@lists.sourceforge.net
Subject: [PATCH] Linux 2.6-pre-mm2 Fix crash on boot on ASUS L3800C if enabing
 APIC => add this machine to DMI black list
References: <F760B14C9561B941B89469F59BA3A847E9702C@orsmsx401.jf.intel.com> <3F1A969C.6060606@free.fr>
In-Reply-To: <3F1A969C.6060606@free.fr>
Content-Type: multipart/mixed;
 boundary="------------080406060507070603090707"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080406060507070603090707
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

The following patch integrated in 2.5.74,

<http://lists.insecure.org/lists/linux-kernel/2003/Jun/5840.html>

really enables the APIC even if BIOS disabled it. Unfortunately, 
enabling APIC really does not seem to work on this ASUS laptop and ACPI 
(which is mandatory) crash the kernel in ACPI code at boot time while 
"Executing all Devices _STA and_INIT methods"

Unless someones find a bug in ACPI code related to APIC management, It 
is safer to add this machine in the DMI black list (along with DELL, 
IBM, ...).

So, as suggested by the author of the problematic change, I added and 
entry in the DMI black list. But my guess is that most laptop will soon 
be present in this list....

-- eric

--------------080406060507070603090707
Content-Type: text/plain;
 name="dmi_scan_black_list"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmi_scan_black_list"

--- linux-2.6.0-test1/arch/i386/kernel/dmi_scan.c.orig	2003-07-20 17:09:10.000000000 +0200
+++ linux-2.6.0-test1/arch/i386/kernel/dmi_scan.c	2003-07-20 21:25:02.000000000 +0200
@@ -706,6 +706,12 @@
 			NO_MATCH, NO_MATCH
 			} },
 
+	{ local_apic_kills_bios, "ASUS L3C", {
+			MATCH(DMI_BOARD_VENDOR, "ASUSTeK Computer INC."),
+			MATCH(DMI_BOARD_NAME, "P4_L3C"),
+			NO_MATCH, NO_MATCH
+			} },
+
 	/* Problem Intel 440GX bioses */
 
 	{ broken_pirq, "SABR1 Bios", {			/* Bad $PIR */

--------------080406060507070603090707--

