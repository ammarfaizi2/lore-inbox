Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264677AbSLVOz2>; Sun, 22 Dec 2002 09:55:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264683AbSLVOz2>; Sun, 22 Dec 2002 09:55:28 -0500
Received: from smtp-out-4.wanadoo.fr ([193.252.19.23]:29909 "EHLO
	mel-rto4.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S264677AbSLVOz1>; Sun, 22 Dec 2002 09:55:27 -0500
Subject: Re: PATCH 2.5.x disable BAR when sizing
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>, davidm@hpl.hp.com,
       Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
       linux-kernel@vger.kernel.org
In-Reply-To: <15877.26255.524564.576439@argo.ozlabs.ibm.com>
References: <m17ke3m3gl.fsf@frodo.biederman.org>
	<Pine.LNX.4.44.0212211423390.1604-100000@home.transmeta.com> 
	<15877.26255.524564.576439@argo.ozlabs.ibm.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 22 Dec 2002 16:03:01 +0100
Message-Id: <1040569382.1966.11.camel@zion>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-12-22 at 08:15, Paul Mackerras wrote:
> Linus Torvalds writes:
> 
> > Actually, I think it's certainly valid to not allow "printk()" to happen
> > around the BAR probing, at least at bootup when we control all the CPU's
> > tightly anyway.
> 
> I'd like us to disable interrupts too.  On powermacs, the interrupt
> controller is typically inside a combo I/O ASIC which is on the PCI
> bus.  If we take an interrupt while the ASIC's BAR is relocated or
> turned off, we will get a machine check when we try to access the
> interrupt controller and the kernel will die at that point.

Actually, it's even worse, as the current probe code also turn off
address decoders of PCI<->PCI bridges when probing, and in a lot of
case, the combo ASIC containing the interrupt controller _is_ behind a
PCI<->PCI bridge ! Same problem with serial port (so printk is unsafe
for quite a while on serial consoles) etc...

The code has a comment that clearly says that we don't know why address
decoding is turned off and that should be fixed, so I suggest we either
fix it now or replace the comment with an explanation of why we need to
turn it off ;) Eventually, turning it off could be made an exception via
some quirks mecanism.

Ben.


