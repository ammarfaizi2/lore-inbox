Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265941AbUAEWRh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 17:17:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265956AbUAEWRg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 17:17:36 -0500
Received: from imap.gmx.net ([213.165.64.20]:43150 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S265941AbUAEWRb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 17:17:31 -0500
X-Authenticated: #13243522
Message-ID: <3FF9E282.F1FA6A05@gmx.de>
Date: Mon, 05 Jan 2004 23:17:38 +0100
From: Michael Schierl <schierlm@gmx.de>
X-Mailer: Mozilla 4.75 [de]C-CCK-MCD QXW0324v  (Win95; U)
X-Accept-Language: de,en
MIME-Version: 1.0
To: Mikael Pettersson <mikpe@csd.uu.se>
CC: arjanv@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: Local APIC bug?
References: <200401052200.i05M0AX0002410@harpo.it.uu.se>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mikael Pettersson schrieb:
> 
> On Sun, 28 Dec 2003 21:07:28 +0100, Michael Schierl wrote:
> >>> However, I'd appreciate if someone had any idea why the kernel crashes
> >>> when trying to resume. Deadlocks...?
> >>
> >>most bioses on laptops that I have seen don't actually restore the apic
> >>state on resume (since they don't expect the apic to be used at all)
> >>which results in entirely horked irq's on resume -> kernel crashes.
> 
> Our local APIC PM code saves the local APIC state and disables it
> before suspend, and restores it and reenables the local APIC after
> resume.
> 
> >Thanks. However, my laptop crashes on *suspend* when APIC is on and on
> >*resume* when APIC is off...
> >
> >And on -test3 it did not crash.
> >
> >jftr: on 2.4.x it crashed on resume as well. Someone trying to prevent
> >me to use stable kernels on my laptop? ;-(
> 
> Do you use APM? How do you suspend? With "apm --suspend" or by e.g.
> closing the lid? In the latter case, does your APM BIOS post the
> suspend event to us before actually suspending?

I suspend by "apm -s". I disabled Suspending by closing the lid or by
Fn+F4 because it happens when I don't like it then, which can be fatal
when resume does not work.

My "test scenario" is doing an "apm -s" when booted with
"init=/bin/bash", having done nothing else than mounted /proc.

tried that with -test4 to -test11, final, and -mm1. All without success.
I can move the point where it crashes around (when I have yenta support
in, it crashes before displaying the prompt again, without it crashes
after displaying it (however, further commands i append by ";" to the
apm command are not executed or only print their first line of output;
so it is most likely not the keyboard driver which is broken). With
local apic it crashes before it suspends. I hoped this would help you to
track down the bug, but it seems that all this behaviour is normal (with
apic), except that without apic it should work...

> An APM BIOS that crashes in SMM code before posting the suspend event,
> or that skips posting the event altogether, probably won't work with
> an enabled local APIC. Not much we can do about that.

I'd like it if you could make my laptop suspend again *without* local
apic. (or better, resume). It works on 2.6.0-test3, whatever i do, but i
don't manage to get it working on later kernels.

And I do *not* like to run beta kernels on production machines, you
mightt understand that...

Till 2.4.x, i believed that the apm of my notebook cannot be made
working with linux - but -test1 to -test3 (I did not try any 2.5
kernels) showed me that it is possible to resume it. Just that it seems
to be impossible with a "stable" kernel. (is that Murphy?)

Michael
