Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272890AbTHPNWh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Aug 2003 09:22:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272902AbTHPNWh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Aug 2003 09:22:37 -0400
Received: from smtp3.att.ne.jp ([165.76.15.139]:59621 "EHLO smtp3.att.ne.jp")
	by vger.kernel.org with ESMTP id S272890AbTHPNWd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Aug 2003 09:22:33 -0400
Message-ID: <0ed801c363f9$493d0c50$1aee4ca5@DIAMONDLX60>
From: "Norman Diamond" <ndiamond@wta.att.ne.jp>
To: "Felipe Alfaro Solana" <felipe_alfaro@linuxmail.org>
Cc: "LKML" <linux-kernel@vger.kernel.org>
References: <0a5b01c36305$4dec8b80$1aee4ca5@DIAMONDLX60> <1060937593.604.14.camel@teapot.felipe-alfaro.com> <0b8801c36314$17890fa0$1aee4ca5@DIAMONDLX60> <1060948426.589.3.camel@teapot.felipe-alfaro.com> <0daa01c36330$50e76d70$1aee4ca5@DIAMONDLX60> <1060959729.744.6.camel@teapot.felipe-alfaro.com>
Subject: Re: Trying to run 2.6.0-test3
Date: Sat, 16 Aug 2003 22:21:06 +0900
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-2022-jp"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Felipe Alfaro Solana" <felipe_alfaro@linuxmail.org> replied to me:

> > > > Guess why I compiled it without ACPI support and with APM support.
> > > > [...].  Linux doesn't panic when its default ACPI takes over, but it
> > > > does prevent APM from working.)
> > >
> > > If you turn ACPI on, you won't need APM support.
> >
> > WRONG.  ACPI DOESN'T WORK ON THE MACHINE I'M DOING THIS ON.  DID
> > YOU TRY READING WHAT YOU QUOTED THERE?
[though I deleted it this time]
>
> Yes, I tried reading. You said Linux doesn't panic while using ACPI, so
> I supposed ACPI just worked but the problem was you wanted APM support.

Since Linux doesn't panic, ACPI turns into a no-op.  Yes that's better than
Windows 2000 blue screening, but no it's not as good as APM support.

The present status of APM support is that the command "apm -s" still
suspends the laptop but the hotkey Fn+F10 gets ignored.  In kernel 2.4.19
the hotkey was interpreted as a more power-hungry variation of standby (same
as "apm -S") so I hacked 2.4.19 to make it do suspend, but in kernel
2.6.0-test3 the hotkey doesn't even reach the apm driver.  But this is a
separate issue from the one that caused you to think I should turn on ACPI's
failures.

> > > To be sincere, I don't know exactly why "pci=usepirqmask" needs to be
> > > used. I'm no hardware expert. But I know that I needed it when I
> > > wasn't using ACPI.
> >
> > Hmm.  Then some dependency seems to be broken in kernel compilation.
> > When ACPI is not compiled in, it should know that the effect of
> > "pci=usepirqmask" should be compiled in (whatever that effect is).
>
> It's not a problem with dependencies. On ACPI-enabled kernels, you using
> ACPI routing.

Then it *is* a problem with dependencies.  In kernel 2.6.0-test1 through
test3, I set all configuration options myself, instead of inheriting
anything from SuSE's 2.4.19 defaults.  I compiled 2.6.0 without ACPI.  Since
this is not an ACPI-enabled kernel, no one should be expecting me to use
ACPI routing.

> If you boot using "acpi=off", then you're using standard
> PCI routing and that, in turn, on same machines, it warns you to use
> "pci=usepirqmask".

But this combination of facts remains very curious:
In 2.4.19, where the kernel is still ACPI-enabled, where it is absolutely
   necessary for me to use "acpi=off apm=on", it doesn't warn to use
   "pci=usepirqmask".
In 2.6.0-test3, where the kernel is not ACPI-enabled (because I
   config'ed it not to be), where it is redundant for me to use
   "acpi=off apm=on", it is warning me to use "pci=usepirqmask".

This combination of facts is exactly the opposite of what you think it
should be.  I'd say it looks like a bug in a dependency condition.

