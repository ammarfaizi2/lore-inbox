Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288028AbSBEDXF>; Mon, 4 Feb 2002 22:23:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288019AbSBEDWq>; Mon, 4 Feb 2002 22:22:46 -0500
Received: from hermes.cicese.mx ([158.97.1.34]:12209 "EHLO hermes.cicese.mx")
	by vger.kernel.org with ESMTP id <S287863AbSBEDWi>;
	Mon, 4 Feb 2002 22:22:38 -0500
Message-ID: <3C5F4FF4.9425949E@cicese.mx>
Date: Mon, 04 Feb 2002 19:22:28 -0800
From: Serguei Miridonov <mirsev@cicese.mx>
Organization: CICESE Research Center, Ensenada, B.C., Mexico
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.8 i686)
X-Accept-Language: ru, en
MIME-Version: 1.0
To: calin@ajvar.org, alan@lxorguk.ukuu.org.uk
CC: linux-kernel@vger.kernel.org
Subject: Re: Athlon Optimization Problem
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello again.

Just as followup... I was trying to find a minimum deviation
from BIOS settigns to make Soyo Dragon Plus stable:

In KT266A northbridge 1106:3099:

Reg[0x75] = 0x07; // this was set to 0x01 by BIOS
Reg[0x76] = 0x00; // this was 0x10

Without this change I had filesystem corruptions during
kernel compilation...

Unfortunately, some issues with Zoran ZR36067 based cards
are still open. VIA wrote me that they are looking for
DC10plus card to test it in their labs...

BTW, with the settings above DC10plus behaves much better in
Linux, though I can not say that it is fully functional now:
I don't have freezes anymore, but it seems that sometimes
the kernel itself gets corrupted after running DC10plus
related stuff: some programs, like ls, crash immediately
with segfaults but after reboot filesystems are clean
(fsck.ext3 -f does not report any errors). Also, there are
some indications of PCI malfunction: to catch PCI errors I
have added, to the ZR36067 driver, test of PCI status
register on DC10plus every IRQ and it sometimes reports
about every PCI error possible at once (master and target
aborts, parity error, etc.). I don't think it is ever
possible, therefore I suspect problem with CPU-PCI path
(NB-Vlink-SB-PCI). Right after such an error message I have
these kernel problems... Perhaps, PCI DMA gets rerouted to
the wrong place in memory... Hmm, can the hardware be so
broken to make it possible?

In Windows the situation with DC10plus card does not change
much even after the same KT266A settings are applied: the
same lockups as before. However, now I have removed well
known George Breeze PCI latency patch (which also sets NB
latency time to 0), and still don't have filesystem
corruptions...

Please, note that settings above might be OK for my
motherboard but may cause problems for others. I have
received very mixed reports about both: my PCI latency patch
and these new settings, so I can not recommend to include it
to the kernel...

Another important information: with these settings my system
is extremely stable if I don't touch Zoran 36067 card, but
if I run anything related with this video capture hardware,
I have problems... For those who may think about broken
DC10plus: the card works great in a system with Intel 430TX,
and I also have reports from others about the same problems.

--
Serguei Miridonov


