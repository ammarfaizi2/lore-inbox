Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265023AbUD2W52@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265023AbUD2W52 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Apr 2004 18:57:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265026AbUD2W5C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Apr 2004 18:57:02 -0400
Received: from smtp.netcabo.pt ([212.113.174.9]:10473 "EHLO smtp.netcabo.pt")
	by vger.kernel.org with ESMTP id S265023AbUD2WyS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Apr 2004 18:54:18 -0400
Subject: [PATCH] can we compile ACPI without define CONFIG_PM ?
From: =?ISO-8859-1?Q?S=E9rgio?= Monteiro Basto <sergiomb@netcabo.pt>
Reply-To: sergiomb@netcabo.pt
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       acpi-devel <acpi-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="=-dLzTM9Lm4cHmA24HrIeB"
Message-Id: <1083279256.3410.30.camel@darkstar>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Thu, 29 Apr 2004 23:54:17 +0100
X-OriginalArrivalTime: 29 Apr 2004 22:54:17.0589 (UTC) FILETIME=[E6A7D250:01C42E3C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-dLzTM9Lm4cHmA24HrIeB
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Hi Kernel mailing list!

IIRC: if I recall correctly=20
we couldn't compile ACPI without Power management option (CONFIG_PM),
but now, this is possible.

If the answer to the subject is no, then consider apply this patch on
kernel 2.4.26.

Accidentally, I compile ACPI without CONFIG_PM on one Dell something
dual Pentium III and power off didn't work.

So I need some confirmation from acpi-devel, but this is one meter of
xconfig of the kernel so ...

For APM Xconfiguration, it's better that, we can choose APM options only
if we select APM ( because if we don't select CONFIG_PM, CONFIG_APM will
be disable and the APM options don't!).
This patch correct also this situation.

Thanks,
--=20
S=E9rgio M. B.

--=-dLzTM9Lm4cHmA24HrIeB
Content-Disposition: attachment; filename=configopti.diff
Content-Type: text/x-patch; name=configopti.diff; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

--- linux-2.4.26s/arch/i386/config.in.orig	2004-04-29 23:38:38.000000000 +0100
+++ linux-2.4.26s/arch/i386/config.in	2004-04-29 23:40:58.000000000 +0100
@@ -360,7 +360,7 @@
 bool 'Power Management support' CONFIG_PM
 
 dep_tristate '  Advanced Power Management BIOS support' CONFIG_APM $CONFIG_PM
-if [ "$CONFIG_APM" != "n" ]; then
+if [ "$CONFIG_APM" != "n" -a "$CONFIG_PM" = "y" ]; then
    bool '    Ignore USER SUSPEND' CONFIG_APM_IGNORE_USER_SUSPEND
    bool '    Enable PM at boot time' CONFIG_APM_DO_ENABLE
    bool '    Make CPU Idle calls when idle' CONFIG_APM_CPU_IDLE
@@ -370,7 +370,9 @@
    bool '    Use real mode APM BIOS call to power off' CONFIG_APM_REAL_MODE_POWER_OFF
 fi
 
-source drivers/acpi/Config.in
+if [ "$CONFIG_PM" = "y" ]; then
+	source drivers/acpi/Config.in
+fi
 
 endmenu
 

--=-dLzTM9Lm4cHmA24HrIeB--

