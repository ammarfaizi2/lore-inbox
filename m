Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131116AbRBNLax>; Wed, 14 Feb 2001 06:30:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131578AbRBNLan>; Wed, 14 Feb 2001 06:30:43 -0500
Received: from horus.its.uow.edu.au ([130.130.68.25]:52380 "EHLO
	horus.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S131116AbRBNLai>; Wed, 14 Feb 2001 06:30:38 -0500
Message-ID: <3A8A6E31.ED24B54F@uow.edu.au>
Date: Wed, 14 Feb 2001 22:38:25 +1100
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.2-pre2 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
CC: Ingo Molnar <mingo@chiara.elte.hu>,
        Manfred Spraul <manfred@colorfullife.com>,
        Frank de Lange <frank@unternet.org>,
        Martin Josefsson <gandalf@wlug.westbo.se>,
        linux-kernel@vger.kernel.org
Subject: Re: [patch] 2.4.1, 2.4.2-pre3: APIC lockups
In-Reply-To: <Pine.GSO.3.96.1010213203553.1931A-100000@delta.ds2.pg.gda.pl>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Maciej W. Rozycki" wrote:
> 
> Hi,
> 
>  After performing various tests I came to the following workaround for
> APIC lockups which people observe under IRQ load, mostly for networking
> stuff.

Works fine on the dual-PII.  No "Aieee!!!" messages at all.

After sending a few gigs across the ethernet, running
irq-whacker:

mnm:/usr/src/cptimer> cat /proc/interrupts
           CPU0       CPU1
  0:      77613      61869    IO-APIC-edge  timer
  1:        253        258    IO-APIC-edge  keyboard
  2:          0          0          XT-PIC  cascade
  8:          0          1    IO-APIC-edge  rtc
  9:          0          0          XT-PIC  acpi
 12:          0          0    IO-APIC-edge  PS/2 Mouse
 17:    5104855    3919759   IO-APIC-level  eth0
 18:       2334       2313   IO-APIC-level  ide2
NMI:     139418     139418
LOC:     139403     139402
ERR:        221
MIS:    5299867

And without irq-whacker:

mnm:/home/morton> cat /proc/interrupts
           CPU0       CPU1
  0:      55384      70899    IO-APIC-edge  timer
  1:          2          3    IO-APIC-edge  keyboard
  2:          0          0          XT-PIC  cascade
  8:          0          1    IO-APIC-edge  rtc
  9:          0          0          XT-PIC  acpi
 12:          0          0    IO-APIC-edge  PS/2 Mouse
 17:    2554705    2554064   IO-APIC-level  eth0
 18:       1814       1812   IO-APIC-level  ide2
NMI:     126220     126220
LOC:     126202     126201
ERR:         35
MIS:          0


Tell me, please: what tradeoffs are involved in this patch?
Obviously it works around a pretty fatal problem, but
what are we giving away?

Oh: and thanks :)

-
