Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261719AbTHYMSu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Aug 2003 08:18:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261729AbTHYMSu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Aug 2003 08:18:50 -0400
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:13829 "EHLO
	small.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S261719AbTHYMSt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Aug 2003 08:18:49 -0400
Subject: Re: 2.6.0-pre4 hangs if acpi enabled
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: =?ISO-8859-1?Q?=C9ric?= Brunet <Eric.Brunet@lps.ens.fr>
Cc: Linux Kernel mailing list <linux-kernel@vger.kernel.org>,
       acpi-devel <acpi-devel@lists.sourceforge.net>
In-Reply-To: <20030825113313.GA10691@lps.ens.fr>
References: <20030825113313.GA10691@lps.ens.fr>
Content-Type: text/plain; charset=iso-8859-15
Message-Id: <1061813912.710.18.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Mon, 25 Aug 2003 14:18:33 +0200
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-08-25 at 13:33, Éric Brunet wrote:
> Hi,
> 
> When booting 2.6.0-pre4 on my intel P4 with a shuttle motherboard, the
> computer hangs after printing
> 
> 	hda: max request size: 128KiB
> 	hda: 234441648 sectors (120034 MB) w/2048KiB Cache, CHS=65535/16/63, UDMA(100)
> 	 hda: hda1 hda2 hda4 < hda5 hda6 hda7 >
> 	mice: PS/2 mouse device common for all mice
> 
> No scroll from the keyboard, no sys-rq, Caps-lock doesn't lit the led on
> the keyboard. The computer is completely frozen.

Well, if you are using ACPI, then this is a know behaviour with -test4
releases. It's ACPI related. Please, take a look at the following bug
report:

http://bugzilla.kernel.org/show_bug.cgi?id=1123

During boot, the kernel checks for i8042 AUX/MUX ports, tries
registering IRQ #12 and then hangs. I fixed the problem on my i845DE
motherboard by flashing a new BIOS with APIC and IOAPIC support. Then, I
recompiled 2.6.0-test4 with APIC and IOAPIC support and the hangs went
away.

If you can't use/compile APIC and IOAPIC for your motherboard, try
booting the kernel with "pci=noacpi" as a workaround. This will prevent
from using ACPI IRQ routing and use standard PCI IRQ routing. Also, if
you have the time, please, attach your "dmidecode" and "acpidmp" to the
bug report at the above URL.

Thanks!

