Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262886AbTDFKBO (for <rfc822;willy@w.ods.org>); Sun, 6 Apr 2003 06:01:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262889AbTDFKBO (for <rfc822;linux-kernel-outgoing>); Sun, 6 Apr 2003 06:01:14 -0400
Received: from meryl.it.uu.se ([130.238.12.42]:56748 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id S262886AbTDFKBN (for <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Apr 2003 06:01:13 -0400
Date: Sun, 6 Apr 2003 12:12:38 +0200 (MEST)
Message-Id: <200304061012.h36ACcIJ006412@harpo.it.uu.se>
From: mikpe@csd.uu.se
To: linux-kernel@vger.kernel.org, nicku@vtc.edu.hk
Subject: Re: Debugging hard lockups (hardware?)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 06 Apr 2003 14:32:27 +0800, Nick Urbanik wrote:
>This machine locks up solid every few days.  Caps Lock, Num Lock, Scroll Lock do
>not respond.  The NMI watchdog does not kick in.  Alt-SysRq-keys do not
>respond.  Logs show no hint of any problem (that I recognise) before lockup.
>Occurs often during scrolling e.g., Mozilla.  I swapped the Radeon 7000 for a
>7500, then an Nvidia.
...
>flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
>pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm

You didn't supply your .config.

It could be local APIC breakage. Try the following:

1. Disable fancy power management support in the kernel.
   If you're using APM, either disable it completely, or keep
   only APM_DO_ENABLE enabled. Specifically, CPU_IDLE and
   DISPLAY_BLANK should be disabled.
   The problem is that power management calls into the BIOS
   _without_ disabling the local APIC before the call.
   I know that several of my machines used to hang due to
   the local APIC timer interrupt occurring while graphics
   card BIOS code was running because of APM.

2. If the above doesn't help, disable local APIC support.

If neither of these help, then the problem isn't the local APIC.

/Mikael
