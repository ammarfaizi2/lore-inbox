Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269173AbTGUBAC (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jul 2003 21:00:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269169AbTGUBAB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jul 2003 21:00:01 -0400
Received: from meryl.it.uu.se ([130.238.12.42]:14820 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id S269131AbTGUA76 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jul 2003 20:59:58 -0400
Date: Mon, 21 Jul 2003 03:14:47 +0200 (MEST)
Message-Id: <200307210114.h6L1El7M018996@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: akpm@osdl.org, andrew.grover@intel.com, eric.valette@free.fr,
       sziwan@hell.org.pl
Subject: Re: [PATCH] Linux 2.6-pre-mm2 Fix crash on boot on ASUS L3800C if enabing APIC => add this machine to DMI black list
Cc: acpi-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 20 Jul 2003 21:48:24 +0200, Eric Valette wrote:
>The following patch integrated in 2.5.74,
>
><http://lists.insecure.org/lists/linux-kernel/2003/Jun/5840.html>
>
>really enables the APIC even if BIOS disabled it. Unfortunately, 
>enabling APIC really does not seem to work on this ASUS laptop and ACPI 
>(which is mandatory) crash the kernel in ACPI code at boot time while 
>"Executing all Devices _STA and_INIT methods"
>
>Unless someones find a bug in ACPI code related to APIC management, It 
>is safer to add this machine in the DMI black list (along with DELL, 
>IBM, ...).
>
>So, as suggested by the author of the problematic change, I added and 
>entry in the DMI black list. But my guess is that most laptop will soon 
>be present in this list....

At least two P4 laptops are known to require the 2.5.74 patch, and
they do work with the local APIC.

While I don't dispute your machine has some problem, please
do the following first before we completely blacklist it:
- ensure you have the latest BIOS (ftp.asuscom.de has the ones for
  their desktop mainboards, presumably the laptop BIOSen are also there)
- in what way is ACPI mandatory? does it fail to boot, or does it
  just lose some specific feature? If you just want suspend support,
  try APM if the machine has it

A question for the ACPI people:
- Does the Linux kernel ACPI code ever transfer control to BIOS,
  explicitly or implicitly via SMIs triggered by the interpreter?
  If you do transfer control, do you disable interrupts and/or
  the interrupt controllers before transferring control?
  Entering BIOS with the local APIC live, in particular the timer,
  is a known hang-generator with APM.

/Mikael
(. again in "I hate BIOS writers" mode, grr .)
