Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262549AbUCRL6A (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 06:58:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262547AbUCRL6A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 06:58:00 -0500
Received: from nsmtp.pacific.net.th ([203.121.130.117]:5605 "EHLO
	nsmtp.pacific.net.th") by vger.kernel.org with ESMTP
	id S262549AbUCRL4l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 06:56:41 -0500
Date: Thu, 18 Mar 2004 19:52:40 +0800
From: "Michael Frank" <mhf@linuxmail.org>
To: "Lionel Bouton" <Lionel.Bouton@inet6.fr>
Subject: Re: SiS APIC, hacker looking for docs/help, was : Re: 2.6.4 under heavy ioload disables sis5513 DMA
Cc: "kernel mailing list" <linux-kernel@vger.kernel.org>
References: <opr410iiid4evsfm@smtp.pacific.net.th> <40598849.1070409@inet6.fr>
Content-Type: text/plain; charset=US-ASCII;
	format=flowed	delsp=yes
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-ID: <opr41292b64evsfm@smtp.pacific.net.th>
In-Reply-To: <40598849.1070409@inet6.fr>
User-Agent: Opera M2/7.50 (Linux, build 615)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Mar 2004 12:30:17 +0100, Lionel Bouton <Lionel.Bouton@inet6.fr> wrote:

> Michael Frank wrote the following on 03/18/2004 11:52 AM :
>> Happens every few hours with heavy io and cpu load:
>>
>> hda: dma_timer_expiry: dma status == 0x21
>> hda: DMA timeout error
>> hda: dma timeout error: status=0xd0 { Busy }
>>
>> hda: DMA disabled
>> ide0: reset: success
>>
>> DMA auto-reenabled by boot time hdparm -k
>>
>
> Hum, I'm wondering if -k is fully functionnal (hdparm man page hints
> that this isn't supported by all drives and I don't remember any
> success/failure stories here).

It is OK here as otherwhise io-performance would collapse and hdparm -iI would show PIO.

>
>> lspci -vv
>>
>> 00:02.5 IDE interface: Silicon Integrated Systems [SiS] 5513 [IDE]
>
> SiS chipset : is APIC functionnal ? (cat /proc/interrupts)

APIC disabled in BIOS.
APIC not compiled in kernel. This board did not work well with APIC,
lots of spurious interrupts and delayloop-cal hangs during boot also
with 2.4 but have not tried in 6 months.

>
> If not, I believe this might be the problem and the solutions still
> eludes me (I don't think the problem lies in the IDE driver but in APIC
> support).
>
> I've 2 SiS based mainboards forced to use XT-PIC (SiS735 and SiS645
> based) here but without this kind of problems (everything works until I
> start to add to many PCI cards in one system...). I'm willing to start
> hacking around (mostly on the 645 as the 735 is an always-on system).

No (PCI,AGP) cards plugged in.

>
> Is reading the arch/i386/kernel/*pic* files (and probably others) enough
> to start or is there somewhere else to look for information ?
>

Dunno how DMA timeout is related to interrupts or are you suggesting it
is loosing dma-complete interrupts?

Same board runs same and higher loads with 2.4.2[345] flawlessly. Also
8 hours OK with 2.4.26-pre4 last night + 430 cycles of swsusp2.

By now, it happened with 2.6.4 four (4) times in 2.7 hours

IO is still at 20MB/s average btw so it is still using DMA.

Regards
Michael
