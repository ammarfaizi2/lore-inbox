Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261463AbTATOEp>; Mon, 20 Jan 2003 09:04:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265643AbTATOEp>; Mon, 20 Jan 2003 09:04:45 -0500
Received: from harpo.it.uu.se ([130.238.12.34]:65191 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S261463AbTATOEo>;
	Mon, 20 Jan 2003 09:04:44 -0500
Date: Mon, 20 Jan 2003 15:13:41 +0100 (MET)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200301201413.PAA24415@harpo.it.uu.se>
To: ALESSANDRO.SUARDI@oracle.com, linux-kernel@vger.kernel.org
Subject: Re: "Latitude with broken BIOS" ?
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Jan 2003 04:31:58 -0800 (GMT-08:00), Alessandro Suardi wrote:
>  I was hoping to use HT on my new Latitude C640 (P4 @ 1.8Ghz) but at boot
>  both 2.4.21-pre3 and 2.5.59 (obviously with a SMP kernel) tell me
>
> "Dell Latitude with broken BIOS detected. Refusing to enable the local APIC."
>
> Is this anything that can be played with ?

First of all, your 1.8GHz mobile P4 doesn't actually have HT.
The only ones to have it are the new 3.06GHz P4s, and most Xeons.

Secondly, I'm responsible for the message you quoted. Many if not all
Pentium III-based Dell laptops (including Latitude Cnnn and I8nnn)
that have local-APIC capable processors fail miserably if the OS
actually enables it. For instance, pulling or inserting the DC
power plug would hang the machine. This is a BIOS bug we can't work
around, except by refusing to enable the local APIC.

Your P4-based Latitude probably has a different BIOS than the buggy
P3-based ones, and it may work better. Try commenting out the
local_apic_kills_bios entry for "Dell Latitude" at around line 692
in arch/i386/kernel/dmi_scan.c and rebuild the kernel. If it
boots ok and enables the local APIC, try various things that
should trigger BIOS (actually SMM) events:
- pull and insert the DC power plug
- enter and exit the BIOS setup screens
- run a big heavy compile job for half an hour or so

Let us know if it survives all this, or if it hangs or crashes.

/Mikael
