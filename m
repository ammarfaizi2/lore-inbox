Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264291AbTKKVbp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Nov 2003 16:31:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264292AbTKKVbp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Nov 2003 16:31:45 -0500
Received: from ppp-62-245-162-69.mnet-online.de ([62.245.162.69]:7041 "EHLO
	frodo.midearth.frodoid.org") by vger.kernel.org with ESMTP
	id S264291AbTKKVbn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Nov 2003 16:31:43 -0500
To: Erik Andersen <andersen@codepoet.org>
Cc: Julien Oster <lkml-20031111@mc.frodoid.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: A7N8X (Deluxe) Madness
From: Julien Oster <lkml-20031111@mc.frodoid.org>
Organization: FRODOID.ORG
X-Face: #C"_SRmka_V!KOD9IoD~=}8-P'ekRGm,8qOM6%?gaT(k:%{Y+\Cbt.$Zs<[X|e)<BNuB($kI"KIs)dw,YmS@vA_67nR]^AQC<w;6'Y2Uxo_DT.yGXKkr/s/n'Th!P-O"XDK4Et{`Di:l2e!d|rQoo+C6)96S#E)fNj=T/rGqUo$^vL_'wNY\V,:0$q@,i2E<w[_l{*VQPD8/h5Y^>?:O++jHKTA(
Date: Tue, 11 Nov 2003 22:31:42 +0100
In-Reply-To: <20031111210922.GA10102@codepoet.org> (Erik Andersen's message
 of "Tue, 11 Nov 2003 14:09:22 -0700")
Message-ID: <frodoid.frodo.87ekwezj5t.fsf@usenet.frodoid.org>
User-Agent: Gnus/5.090018 (Oort Gnus v0.18) Emacs/21.2 (gnu/linux)
References: <frodoid.frodo.87r80eznz9.fsf@usenet.frodoid.org>
	<20031111200922.GA9276@codepoet.org>
	<frodoid.frodo.87k766zmak.fsf@usenet.frodoid.org>
	<20031111210922.GA10102@codepoet.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Erik Andersen <andersen@codepoet.org> writes:

Hello Erik,

>> > Does it help if you go into the BIOS and set the IDE controller
>> > to "Compatible Mode" rather than "Enhanced Mode"?

> I have an ASUS mb with that option, but I just checked
> your manual and it indeed does not have that option.

Unfortunately, yes...

> Anyway, the problem I had was that I had my SATA ports
> as well as all usb devices sharing the same interrupt
> and the resulting interrupt storm was easily seen by
> watching /proc/interrupts

Well, I guess, that may be the point. With APIC enabled, I have a lot
of interrupts available. Without APIC, there are only those available
ever since the IBM AT. So, an excerpt of /proc/interrupts without APIC
looks like that:

 10:     224131          XT-PIC  ide2, ide3, usb-ohci, usb-ohci, eth0, EMU10K1
 11:          0          XT-PIC  NVidia nForce2
 14:      61649          XT-PIC  ide0
 15:      60954          XT-PIC  ide1

As you see, IRQ 10 ist really crowded with stuff. ide2 and ide3 are my
SATA channels, on USB there's my mouse and sometimes my mobile phone
or my pocket pc, eth0 is one quite heavily used ethernet card and my
soundcard... well, sometimes it's playing music.

And I just typed "ifconfig eth2 up" (I have a 4-port DEC network card
in my workstation), today it's unused, but just to see:

 10:     233008          XT-PIC  ide2, ide3, usb-ohci, usb-ohci, eth0, EMU10K1, eth2

Uh.

With ISA cards, long time ago, I was able to select the interrupt for
each card myself, either through jumpers or later by using PnP. Is
there any such possibility for PCI, or do I just have to accept what
the kernel or the mainboard is giving me?

Just balancing my devices on the available interrupts might already
help. Currently, according to /proc/interrupts, IRQ 3, 4 and 7 are
completely unused!

Regards,
Julien
