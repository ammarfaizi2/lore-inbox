Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313312AbSDQS6T>; Wed, 17 Apr 2002 14:58:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313334AbSDQS6S>; Wed, 17 Apr 2002 14:58:18 -0400
Received: from elin.scali.no ([62.70.89.10]:14098 "EHLO elin.scali.no")
	by vger.kernel.org with ESMTP id <S313312AbSDQS6R>;
	Wed, 17 Apr 2002 14:58:17 -0400
Date: Wed, 17 Apr 2002 20:58:13 +0200 (CEST)
From: Steffen Persvold <sp@scali.com>
To: Ingo Molnar <mingo@elte.hu>
cc: James Bourne <jbourne@MtRoyal.AB.CA>, <linux-kernel@vger.kernel.org>,
        "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
        Jeff Nguyen <jeff@aslab.com>
Subject: Re: SMP P4 APIC/interrupt balancing
In-Reply-To: <Pine.LNX.4.30.0204172050410.31755-100000@elin.scali.no>
Message-ID: <Pine.LNX.4.30.0204172055470.31755-100000@elin.scali.no>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Apr 2002, Ingo Molnar wrote:

>
> On Wed, 17 Apr 2002, James Bourne wrote:
>
> > After Ingo forwarded me his original patch (I found his patch via a web
> > based medium, which had converted all of the left shifts to compares,
> > and now I'm very glad it didn't boot...) and the system is booted and is
> > balancing most of the interrupts at least.  Here's the current output of
> > /proc/interrupts
> >
> > brynhild:bash$ cat /proc/interrupts
> >            CPU0       CPU1
> >   0:     171414          0    IO-APIC-edge  timer
> >   1:          3          2    IO-APIC-edge  keyboard
> >   2:          0          0          XT-PIC  cascade
> >   8:          1          0    IO-APIC-edge  rtc
> >  18:          8          7   IO-APIC-level  aic7xxx
> >  19:      13566      12799   IO-APIC-level  eth0
> >  20:          9          7   IO-APIC-level  aic7xxx
> >  21:          9          7   IO-APIC-level  aic7xxx
> >  27:       1572       5371   IO-APIC-level  megaraid
> > NMI:          0          0
> > LOC:     171315     171251
> > ERR:          0
> > MIS:          0
>
> it's looking good.
>
> > So, the timer isn't being balanced still, others are (is there a
> > specific case in your patch for irq 0 (< 1)?  I couldn't see it but it
> > almost looks as though it's being missed..)
>
> it's a separate bug, solved by a separate patch.
>

Hi again,

Hmm, is that something ServerWorks specific because on my Plumas chipset
the timer interrupt is balanced just fine :

(sp@puma2:~)> cat /proc/interrupts
           CPU0       CPU1
  0:   14358402   14297319    IO-APIC-edge  timer
  1:          2          1    IO-APIC-edge  keyboard
  2:          0          0          XT-PIC  cascade
  4:        336        325    IO-APIC-edge  serial
  8:          1          0    IO-APIC-edge  rtc
  9:          0          0    IO-APIC-edge  acpi
 15:          3          1    IO-APIC-edge  ide1
 16:          0          0   IO-APIC-level  usb-uhci
 17:     576744     574959   IO-APIC-level  eth0
 18:          0          0   IO-APIC-level  usb-uhci
 19:          0          0   IO-APIC-level  usb-uhci
 28:      72602      71619   IO-APIC-level  aic7xxx
 29:          8          8   IO-APIC-level  aic7xxx
 31:          0          0   IO-APIC-level  e1000
 48:     289545     269389   IO-APIC-level  ssci
NMI:          0          0
LOC:   28654183   28654202
PMC:          0          0
ERR:          0
MIS:          0

Regards,
-- 
  Steffen Persvold   | Scalable Linux Systems |   Try out the world's best
 mailto:sp@scali.com |  http://www.scali.com  | performing MPI implementation:
Tel: (+47) 2262 8950 |   Olaf Helsets vei 6   |      - ScaMPI 1.13.8 -
Fax: (+47) 2262 8951 |   N0621 Oslo, NORWAY   | >320MBytes/s and <4uS latency

