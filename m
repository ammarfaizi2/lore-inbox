Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264843AbUEaWs5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264843AbUEaWs5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 May 2004 18:48:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264839AbUEaWs4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 May 2004 18:48:56 -0400
Received: from aun.it.uu.se ([130.238.12.36]:14531 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S264830AbUEaWsp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 May 2004 18:48:45 -0400
Date: Tue, 1 Jun 2004 00:48:42 +0200 (MEST)
Message-Id: <200405312248.i4VMmgFI013049@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: dj@david-web.co.uk, linux-kernel@vger.kernel.org
Subject: Re: APM Console Blanking lockups with 2.6.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 31 May 2004 21:43:30 +0100, David Johnson wrote:
>I've been getting frequent lockups with 2.6.6 whenever the machine is left for 
>any period of time. These are hard lockups where I can't even use SysRq to 
>reboot.
>
>After poking around a bit I've isolated this to APM Console Blanking. With  
>console blanking enabled I get a lockup as soon as the console is blanked. 
>With it disabled everything works fine.
>
>But surely if this was a common bug with APM console blanking someone else 
>would have spotted it before now? Is anybody else having problems/using it 
>successfully?
...
>ACPI: Local APIC address 0xfee00000
>ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)

Note that the mobo BIOS boots with the local APIC enabled,
thus I don't think that the mobo should be blaimed.

This is almost certainly the result of a buggy graphics
card BIOS that can't handle an enabled local APIC.

The problem is that the APM driver invokes the BIOS without
disabling the local APIC first. Some BIOSen hang hard if
there is any local APIC interrupt while they are running.
In the case of APM's DISPLAY_BLANK, it's the graphics card
BIOS that's running.

This is much more likely to occur in 2.6 kernels since they
by default run the local APIC timer 10 times faster than in
2.4 kernels.

The workaround is to disable APM's DISPLAY_BLANK and CPU_IDLE
options, and to not build it as a module.
