Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263557AbUEGLdM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263557AbUEGLdM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 May 2004 07:33:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263563AbUEGLdM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 May 2004 07:33:12 -0400
Received: from smtp.netcabo.pt ([212.113.174.9]:9274 "EHLO smtp.netcabo.pt")
	by vger.kernel.org with ESMTP id S263557AbUEGLdG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 May 2004 07:33:06 -0400
Subject: Re: [ACPI] [PATCH] can we compile ACPI without define CONFIG_PM ?
From: =?ISO-8859-1?Q?S=E9rgio?= Monteiro Basto <sergiomb@netcabo.pt>
Reply-To: sergiomb@netcabo.pt
To: Len Brown <len.brown@intel.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ACPI Developers <acpi-devel@lists.sourceforge.net>
In-Reply-To: <1083903538.2296.248.camel@dhcppc4>
References: <A6974D8E5F98D511BB910002A50A6647615F9FD0@hdsmsx403.hd.intel.com>
	 <1083903538.2296.248.camel@dhcppc4>
Content-Type: multipart/mixed; boundary="=-VOabJdYxJn1JAGHxoyUz"
Message-Id: <1083929581.9706.35.camel@darkstar>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Fri, 07 May 2004 12:33:01 +0100
X-OriginalArrivalTime: 07 May 2004 11:33:05.0329 (UTC) FILETIME=[1031E210:01C43427]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-VOabJdYxJn1JAGHxoyUz
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Hi , Len=20
Thanks for replying
So:

1 - ACPI w/o CONFIG_PM (is not supported)

2 - If accidentally we configure ACPI w/o CONFIG_PM. I tested and
doesn't power off correctly (at least on one Dell Precision 410).=20

3 - It is easy make this error in configuration, especial if we try use
.config from early versions.

4 - The patch doesn't hurt at all, just force to one correct
configuration.

On Fri, 2004-05-07 at 05:18, Len Brown wrote:
> Never occurred to me to build ACPI w/o CONFIG_PM...
> There are #ifdef CONFIG_PM in the acpi code, so I guess this was on
> purpose, but it makes ACPI a lot less interesting.
>=20
> But I'm inclined to leave 2.4 alone except for real system failures.=20
> The only clean-up I'm really interested in doing in 2.4 is when it makes
> maintenance via backporting from 2.6 easier.

I understand very well your point, and I don't check in kernel 2.6.5
Config.in, neither check in others architectures.
But I vote for apply this patch, because can avoid problems with
power-off machines.

Off-topic: I am testing last acpi-2.4.27 patch and it ok, no complains.

I resend the patch just in case.
thanks,
--=20
S=E9rgio M. B.

--=-VOabJdYxJn1JAGHxoyUz
Content-Disposition: attachment; filename=configopti.diff
Content-Type: text/x-patch; name=configopti.diff; charset=iso-8859-15
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
 

--=-VOabJdYxJn1JAGHxoyUz--

