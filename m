Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751527AbWAINk2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751527AbWAINk2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 08:40:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751526AbWAINk2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 08:40:28 -0500
Received: from perninha.conectiva.com.br ([200.140.247.100]:15309 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S1751495AbWAINk1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 08:40:27 -0500
Date: Mon, 9 Jan 2006 11:39:53 -0200
From: Luiz Fernando Capitulino <lcapitulino@mandriva.com.br>
To: akpm <akpm@osdl.org>
Cc: ak@suse.de, 76306.1226@compuserve.com, petero2@telia.com,
       lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] i386/x86-64: Removes 'enable_timer_pin_1' command-line
 option.
Message-Id: <20060109113953.2ebb56e3.lcapitulino@mandriva.com.br>
Organization: Mandriva
X-Mailer: Sylpheed version 2.1.8 (GTK+ 2.8.9; i586-mandriva-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 Hi,

 Commit 66759a01adbfe8828dd063e32cf5ed3f46696181 added two new command-line
options, IIUC:

 disable_timer_pin_1: used to disable PIN 1 of the APIC timer, only had
real effect on non-ATI chipsets, becuase the commit also added code to
disable the PIN automatically on ATI chipsets

 enable_timer_pin_1: used to enable PIN 1 of the APIC timer, only had
real effect on ATI chipsets, where the PIN was automatically disabled.

 But commit 1619cca2921f6927f4240e03f413d4165c7002fc removed the
automatic detection of ATI chipsets, so think "enable_timer_pin_1" is
useless now.

 This patch removes it, completing the work of the last commit.

Signed-off-by: Luiz Capitulino <lcapitulino@mandriva.com.br>

 Documentation/kernel-parameters.txt |    6 ------
 arch/i386/kernel/setup.c            |    2 --
 arch/x86_64/kernel/setup.c          |    2 --
 3 files changed, 10 deletions(-)

diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
index a482fde..b91d243 100644
--- a/Documentation/kernel-parameters.txt
+++ b/Documentation/kernel-parameters.txt
@@ -167,12 +167,6 @@ running once the system is up.
 			override platform specific driver.
 			See also Documentation/acpi-hotkey.txt.
 
-	enable_timer_pin_1 [i386,x86-64]
-			Enable PIN 1 of APIC timer
-			Can be useful to work around chipset bugs
-			(in particular on some ATI chipsets).
-			The kernel tries to set a reasonable default.
-
 	disable_timer_pin_1 [i386,x86-64]
 			Disable PIN 1 of APIC timer
 			Can be useful to work around chipset bugs.
diff --git a/arch/i386/kernel/setup.c b/arch/i386/kernel/setup.c
index 27c956d..f21d159 100644
--- a/arch/i386/kernel/setup.c
+++ b/arch/i386/kernel/setup.c
@@ -859,8 +859,6 @@ static void __init parse_cmdline_early (
 
 		if (!memcmp(from, "disable_timer_pin_1", 19))
 			disable_timer_pin_1 = 1;
-		if (!memcmp(from, "enable_timer_pin_1", 18))
-			disable_timer_pin_1 = -1;
 
 		/* disable IO-APIC */
 		else if (!memcmp(from, "noapic", 6))
diff --git a/arch/x86_64/kernel/setup.c b/arch/x86_64/kernel/setup.c
index 64c4534..66ef97c 100644
--- a/arch/x86_64/kernel/setup.c
+++ b/arch/x86_64/kernel/setup.c
@@ -339,8 +339,6 @@ static __init void parse_cmdline_early (
 
 		if (!memcmp(from, "disable_timer_pin_1", 19))
 			disable_timer_pin_1 = 1;
-		if (!memcmp(from, "enable_timer_pin_1", 18))
-			disable_timer_pin_1 = -1;
 
 		if (!memcmp(from, "nolapic", 7) ||
 		    !memcmp(from, "disableapic", 11))

-- 
Luiz Fernando N. Capitulino
