Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263769AbTKKTrn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Nov 2003 14:47:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263771AbTKKTrn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Nov 2003 14:47:43 -0500
Received: from ppp-62-245-162-69.mnet-online.de ([62.245.162.69]:7296 "EHLO
	frodo.midearth.frodoid.org") by vger.kernel.org with ESMTP
	id S263769AbTKKTrk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Nov 2003 14:47:40 -0500
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: A7N8X (Deluxe) Madness
From: Julien Oster <lkml-20031111@mc.frodoid.org>
Organization: FRODOID.ORG
X-Face: #C"_SRmka_V!KOD9IoD~=}8-P'ekRGm,8qOM6%?gaT(k:%{Y+\Cbt.$Zs<[X|e)<BNuB($kI"KIs)dw,YmS@vA_67nR]^AQC<w;6'Y2Uxo_DT.yGXKkr/s/n'Th!P-O"XDK4Et{`Di:l2e!d|rQoo+C6)96S#E)fNj=T/rGqUo$^vL_'wNY\V,:0$q@,i2E<w[_l{*VQPD8/h5Y^>?:O++jHKTA(
Date: Tue, 11 Nov 2003 20:47:38 +0100
Message-ID: <frodoid.frodo.87r80eznz9.fsf@usenet.frodoid.org>
User-Agent: Gnus/5.090018 (Oort Gnus v0.18) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,

seriously, I'm pretty fed up with it.

I have an ASUS A7N8X Deluxe mainboard. Yeah, right, that thing causing
serious trouble. I'm getting hard lockups all the time. No panic, no
message, no sysrq, no blinking cursor in the framebuffer. Gone for good.

I went through the mailing list archive and tried out many
things. However, this is how far I got:

With 2.6.0-test9, the machine locks up while booting or shortly
after. This is clearly connected to high IDE (PATA) load, since it
locks up with a 100% chance while doing an fsck. If I managed booting
it (which means, if it doesn't do an fsck while booting) I can lock it
up immediately by doing a hdparm -t /dev/hda. I don't know what SATA
load would do on that kernel, I never got that far.

Specifying "noapic nolapic acpi=off noacpi=off" helps, I got no
lockups. However, I don't like this, because of the performance flaws
(I'll talk about this later).

So, one might suspect: Something between APIC or ACPI (or both) and
the IDE controller broken, nothing to fix there, that's life. Right?
Wrong. Because:

With 2.4.22-ac4 it actually works *better*. Not absolutely good, but
better. I can achieve uptimes up to *several days*. However, it still
locks up. Sometimes after several days, sometimes some minutes after
booting. But basically I can actually use my computer with
2.4.22-ac4. Strangely, the lockups don't seem to be connected to IDE
load with that kernel. When the machine locks up, it simply does,
without any appearent cause. I can create as many CPU, disk, network
or whatever load I want. All goes fine. Then I leave the computer, the
machine staying idle, I come back and it's crashed. I even have the
impression, that it only crashes when it has no load at all. Clearly
spoken, I can't really remember that it locked up when I was sitting
in front of the computer. Moving the mouse or typing things seems to
create enough load to actually keep it from locking up?!

So, things are totally different between 2.6.0-test9 and
2.4.22-ac4. 2.6.0-test9 doesn't like the slightest IDE load with that
mainboard at all. 2.4.22-ac4 doesn't care, runs for hours or for days
and then locks up when it just gets bored or something similar.

The solution might look simple: why don't I just use 2.6.0-test9 with
the enormous "noapic nolapic acpi=off pci=noacpi" command line?
Because then, my SATA performance really is a pain compared to what I
can get with 2.4.22-ac4. A simple example with hdparm -t (I tried
other things, also, but this already gives a nice example): with
2.4.22-ac4 I get amazing 100 to 110 MB/s on the SATA RAID. With
2.6.0-test9 and the nasty command line, I get at most 40MB/s. To feel
the difference, I just have to fire up Oracle and let it do some I/O
expensive things.

Has nobody an idea what it could be? That's just strange, both kernels
are unstable on that mainboard, but the one is much more stable while
locking up in completely different situations.

If that continues like that, I'll begin to feel the urge of hunting
ASUS and NVIDIA down.

Well, I hope I could give you some worthy information.

In great despair,
Julien
