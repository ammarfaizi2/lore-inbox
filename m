Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263735AbUGIDKk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263735AbUGIDKk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jul 2004 23:10:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263736AbUGIDKk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jul 2004 23:10:40 -0400
Received: from mail2.asahi-net.or.jp ([202.224.39.198]:13136 "EHLO
	mail.asahi-net.or.jp") by vger.kernel.org with ESMTP
	id S263735AbUGIDKh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jul 2004 23:10:37 -0400
Message-ID: <40EE0CA6.1000109@thinrope.net>
Date: Fri, 09 Jul 2004 12:10:30 +0900
From: Kalin KOZHUHAROV <kalin@thinrope.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040627
X-Accept-Language: bg, en, ja, ru, de
MIME-Version: 1.0
To: Jonathan Filiatrault <lintuxicated@yahoo.ca>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [2.6.7] Ehci controller interrupts like crazy on nforce2
References: <40EDF209.70707@yahoo.ca>
In-Reply-To: <40EDF209.70707@yahoo.ca>
X-Enigmail-Version: 0.84.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jonathan Filiatrault wrote:
> Here it is: another nforce2 hardware bug. The ehci controller seems to
> send a massive number of interrupts to the kernel (264379 per second).
> This uses about 5 to 10% of the cpu. This shows up in top in the
> "hi"(hard interrupts) indicator. Nothing unusual shows up in the kernel
> log. My system has an Asus A7N8X Nforce2 Board with an Athlon XP 2800+
> mounted on it.
Well, I have the same system (board is Deluxe version) and no such situation.

> [joe@omega3:~]$ cat /proc/interrupts ; sleep 1; cat /proc/interrupts
>           CPU0
>  0:     583513          XT-PIC  timer
Hmm, I don't have this though. "IO-APIC-edge  timer" is the closest in my box.

>  1:       1279    IO-APIC-edge  i8042
>  7:     137293    IO-APIC-edge  parport0
>  8:          0    IO-APIC-edge  rtc
>  9:          0   IO-APIC-level  acpi
> 14:      41463    IO-APIC-edge  ide0
> 15:         23    IO-APIC-edge  ide1
> 17:          9   IO-APIC-level  EMU10K1
> 18:      18584   IO-APIC-level  eth0
> 20:  121541873   IO-APIC-level  ehci_hcd
> 21:          0   IO-APIC-level  ohci_hcd
> 22:          0   IO-APIC-level  ohci_hcd
> NMI:          0
> LOC:     583348
> ERR:          0
> MIS:          0
[snip]
> 20:  121806252   IO-APIC-level  ehci_hcd
[snip]
> Any help or random thougths are welcome.

Well, the "usual answer" is try enable/disable PREEMPT, upgrade BIOS.
Also IO-APIC and APIC as a whole.

Here is my board:
$ cat /proc/interrupts 
           CPU0       
  0:  415667195    IO-APIC-edge  timer
  1:     184380    IO-APIC-edge  i8042
  8:          2    IO-APIC-edge  rtc
  9:          0   IO-APIC-level  acpi
 14:     865112    IO-APIC-edge  ide0
 15:       9195    IO-APIC-edge  ide1
 19:   31371344   IO-APIC-level  nvidia
 20:    8356973   IO-APIC-level  ehci_hcd, NVidia nForce2, eth0
 21:          0   IO-APIC-level  ohci_hcd
 22:     798076   IO-APIC-level  ohci_hcd
NMI:          0 
LOC:  415691931 
ERR:          0
MIS:          0
$ bash -c 'cat /proc/interrupts ; sleep 1; cat /proc/interrupts'|  grep ehci
 20:    8357517   IO-APIC-level  ehci_hcd, NVidia nForce2, eth0
 20:    8357530   IO-APIC-level  ehci_hcd, NVidia nForce2, eth0


-- 
 || ~~~~~~~~~~~~~~~~~~~~~~ ||
(  ) http://ThinRope.net/ (  )
 || ______________________ ||
