Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286380AbSAAX2v>; Tue, 1 Jan 2002 18:28:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286372AbSAAX2m>; Tue, 1 Jan 2002 18:28:42 -0500
Received: from bs1.dnx.de ([213.252.143.130]:2534 "EHLO bs1.dnx.de")
	by vger.kernel.org with ESMTP id <S286365AbSAAX2d>;
	Tue, 1 Jan 2002 18:28:33 -0500
Date: Wed, 2 Jan 2002 00:27:31 +0100 (CET)
From: Robert Schwebel <robert@schwebel.de>
X-X-Sender: <robert@callisto.local>
Reply-To: <robert@schwebel.de>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>,
        Christer Weinigel <wingel@hog.ctrl-c.liu.se>,
        Jason Sodergren <jason@mugwump.taiga.com>,
        Anders Larsen <anders@alarsen.net>, <rkaiser@sysgo.de>
Subject: Re: [PATCH][RFC] AMD Elan patch
In-Reply-To: <3C322EEE.5040402@zytor.com>
Message-ID: <Pine.LNX.4.33.0201020006240.3056-100000@callisto.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Jan 2002, H. Peter Anvin wrote:
> Do you have documentation which verifies that A20 is enabled by the
> time the IN instruction returns?

The manual says:

----------8<----------
Alternate Gate A20 Control Register (Port 00EEh) A special 8-bit
read/write control register provides a fast and reliable way to control
the CPU A20 signal.  A dummy read of this register returns a value of FFh
and forces the CPU A20 to propagate to the core logic, while a dummy write
to this register will cause the CPU A20 signal to be forced Low as long as
no other A20 gate control sources are forcing the CPU A20 signal to
propagate.
---------->8----------

But neither this nor the register description ("Alternate GateA20 Control
This register can be used to cause the same type of masking of the CPU A20
signal that was historically performed by an external SCP (System Control
Processor) in a PC/AT Compatible system, but much faster.") says something
about _how_ fast it is done.

> If not, you probably don't want to jump to a20_done, but rather fall
> into a loop like the following:
>
> #if defined(CONFIG_MELAN)
> 	inb $0xee, %al
> a20_elan_wait:
> 	call a20_test
> 	jz a20_elan_wait
> 	jmp a20_done
> #endif

Sounds good, I'll integrate it.

> Furthermore, I would still like to argue that this does not belong
> into "processor type and features", because all of these are *chipset*
> issues;

Hmm, there is no special section for chipset issues, the only ones I could
find are "Toshiba Laptop support" and "Dell Laptop Support" (also in
"Processor type and features"). Other chipset bugfix options are in the
IDE driver section, but this doesn't apply here. So the options would be

- add something like "Elan Support" in "Processor type and features"
- add a new section for general chipset fixes

What do you think?

> I'm also very uncomfortable with putting this where you do; I think it
> should be put before a20_kbc instead.  If the BIOS is implemented
> correctly, it should be used.

ACK, I'll have a look at it tomorow.

Robert
--
 +--------------------------------------------------------+
 | Dipl.-Ing. Robert Schwebel | http://www.pengutronix.de |
 | Pengutronix - Linux Solutions for Science and Industry |
 |   Braunschweiger Str. 79,  31134 Hildesheim, Germany   |
 |    Phone: +49-5121-28619-0 |  Fax: +49-5121-28619-4    |
 +--------------------------------------------------------+

