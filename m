Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265461AbTLHSBA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Dec 2003 13:01:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264574AbTLHSAV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Dec 2003 13:00:21 -0500
Received: from ppp-82-135-1-25.mnet-online.de ([82.135.1.25]:25540 "EHLO
	frodo.midearth.frodoid.org") by vger.kernel.org with ESMTP
	id S265461AbTLHR7i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Dec 2003 12:59:38 -0500
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: balance interrupts
From: Julien Oster <lkml-2315@mc.frodoid.org>
Organization: FRODOID.ORG
X-Face: #C"_SRmka_V!KOD9IoD~=}8-P'ekRGm,8qOM6%?gaT(k:%{Y+\Cbt.$Zs<[X|e)<BNuB($kI"KIs)dw,YmS@vA_67nR]^AQC<w;6'Y2Uxo_DT.yGXKkr/s/n'Th!P-O"XDK4Et{`Di:l2e!d|rQoo+C6)96S#E)fNj=T/rGqUo$^vL_'wNY\V,:0$q@,i2E<w[_l{*VQPD8/h5Y^>?:O++jHKTA(
Date: Mon, 08 Dec 2003 18:59:36 +0100
Message-ID: <frodoid.frodo.87zne3tcl3.fsf@usenet.frodoid.org>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello!

Now that my IO-APIC finally works without lockups (thanks to all!) on
my nforce2 boards, my interrupts are much less crowded. However,
there's still one line in /proc/interrupts which I don't really like,
it's also the only line where more than one piece of hardware shares
the same interrupt:

 18:     445160   IO-APIC-level  ide2, ide3, eth0

ide2 and ide3 are my onboard Silicon Image SATA controller. I guess
you can't keep them apart on to different interrupts, since it's only
one chip which is most probably connected to one IRQ line only.

But I don't think that eth0 has to be on the same interrupt as my SATA
controller. So, how do I make it go away to another place? I would be
fine sharing it with e.g. eth1, which is alone on IRQ 19.

BTW, the whole /proc/interrupts looks like this:

           CPU0
  0:   40022145    IO-APIC-edge  timer
  1:      62950    IO-APIC-edge  i8042
  2:          0          XT-PIC  cascade
  8:     681626    IO-APIC-edge  rtc
  9:          0   IO-APIC-level  acpi
 12:         55    IO-APIC-edge  i8042
 14:     968274    IO-APIC-edge  ide0
 15:    1789182    IO-APIC-edge  ide1
 16:     404489   IO-APIC-level  EMU10K1
 18:     445160   IO-APIC-level  ide2, ide3, eth0
 19:    1596427   IO-APIC-level  eth1
 20:          0   IO-APIC-level  ohci_hcd
 21:          0   IO-APIC-level  NVidia nForce2
 22:      36730   IO-APIC-level  ohci_hcd
NMI:          0
LOC:   40021891
ERR:          0
MIS:        310

Regards,
Julien
