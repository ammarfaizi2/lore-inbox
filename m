Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315189AbSD2UhK>; Mon, 29 Apr 2002 16:37:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315194AbSD2UhJ>; Mon, 29 Apr 2002 16:37:09 -0400
Received: from harpo.it.uu.se ([130.238.12.34]:65020 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S315189AbSD2UhI>;
	Mon, 29 Apr 2002 16:37:08 -0400
Date: Mon, 29 Apr 2002 22:37:00 +0200 (MET DST)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200204292037.WAA05302@harpo.it.uu.se>
To: blc@q.dyndns.org
Subject: Re: GW Solo 5350 Laptop APIC trouble?
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Apr 2002 12:02:05 -0600 (MDT), Benson Chow wrote:
>I'm running 2.4.18 on my GW Solo 5350, and if I compile APIC in for
>uniprocessors, it will fail pretty horribly - something like this:
>
>APIC + APM: System Freeze on idle, random time, instant Fn key freeze.
>APIC + ACPI: System Freeze when using Fn key with smm feature.
>APM w/o APIC: Works fine, but Fn key instant on-screen status info is
>corrupt
>ACPI w/o APIC: Haven't tried yet.
>Redhat 7.2 Kernel (2.4.9-RH I believe): No crashes, Fn-key onscreen works
>fine.
>...
>I'm still trying to figure out what's in the RH kernel that makes it work
>fine, that's when I found out compiling in APIC aggravated the failures.
>...
>Anyone have any ideas how to start debugging this?  Chances are it's a
>hardware issue, I hope it can be worked around in software without
>outrightly disabling or not using the features.

RedHat's 7.2 UP kernels don't have CONFIG_X86_UP_APIC=y.
We've seen failures like these before. To date, they've always
been caused by BIOS problems, and chances are your machine also
has a local-APIC hostile BIOS.

The only known Linux workaround is to not enable the local APIC.

I maintain a local APIC blacklist, which the kernel uses to avoid
enabling the local APIC on buggy machines. If after testing you
are sure that keeping the local APIC disabled is a prerequisite
for stable operation on your machine, then please apply the patch
below and send me the DMI data from the kernel boot log so that
I can add your machine to the blacklist.

/Mikael

--- linux-2.4.18/arch/i386/kernel/dmi_scan.c.~1~	Tue Feb 26 13:26:56 2002
+++ linux-2.4.18/arch/i386/kernel/dmi_scan.c	Mon Apr 29 22:24:41 2002
@@ -20,8 +20,8 @@
 	u16	handle;
 };
 
-#define dmi_printk(x)
-//#define dmi_printk(x) printk x
+//#define dmi_printk(x)
+#define dmi_printk(x) printk x
 
 static char * __init dmi_string(struct dmi_header *dm, u8 s)
 {
