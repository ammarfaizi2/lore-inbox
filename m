Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313131AbSDJOPA>; Wed, 10 Apr 2002 10:15:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313122AbSDJOO7>; Wed, 10 Apr 2002 10:14:59 -0400
Received: from elin.scali.no ([62.70.89.10]:22539 "EHLO elin.scali.no")
	by vger.kernel.org with ESMTP id <S313131AbSDJOO5>;
	Wed, 10 Apr 2002 10:14:57 -0400
Subject: Re: how to balance interrupts between 2 CPUs?
From: Terje Eggestad <terje.eggestad@scali.com>
To: zxj@water.pku.edu.cn
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <b5926afe75.afe75b5926@water.pku.edu.cn>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 
Date: 10 Apr 2002 16:14:52 +0200
Message-Id: <1018448092.1479.39.camel@pc-16.office.scali.no>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

That is wierd you should have 4 CPU's. However I remember that Alan made
a patch for hyperthreading I *belive* is not in any 2.4.7 kernel.

I've a dual P4 Xeon 1.8Ghz with Intel chipset and 2.4.18smp, and I've:

te gcle1 ~ 4> cat /proc/interrupts
           CPU0       CPU1       CPU2       CPU3       
  0:     117524     117823     117105     117564    IO-APIC-edge  timer
  1:        108        105        109        109    IO-APIC-edge
keyboard
  2:          0          0          0          0          XT-PIC 
cascade
  4:         96        119         92        116    IO-APIC-edge  serial
  8:          1          0          0          0    IO-APIC-edge  rtc
  9:          0          0          0          0    IO-APIC-edge  acpi
 15:          2          1          1          0    IO-APIC-edge  ide1
 16:          0          0          0          0   IO-APIC-level
usb-uhci
 17:       1554       1572       1499       1622   IO-APIC-level  eth0
 18:          0          0          0          0   IO-APIC-level 
usb-uhci
 19:          0          0          0          0   IO-APIC-level 
usb-uhci
 28:       4937       4915       4881       5053   IO-APIC-level 
aic7xxx
 29:          4          4          4          4   IO-APIC-level 
aic7xxx
NMI:          0          0          0          0 te gcle1 ~ 4> cat
/proc/interrupts
           CPU0       CPU1       CPU2       CPU3       
  0:     117524     117823     117105     117564    IO-APIC-edge  timer
  1:        108        105        109        109    IO-APIC-edge 
keyboard
  2:          0          0          0          0          XT-PIC 
cascade
  4:         96        119         92        116    IO-APIC-edge  serial
  8:          1          0          0          0    IO-APIC-edge  rtc
  9:          0          0          0          0    IO-APIC-edge  acpi
 15:          2          1          1          0    IO-APIC-edge  ide1
 16:          0          0          0          0   IO-APIC-level 
usb-uhci
 17:       1554       1572       1499       1622   IO-APIC-level  eth0
 18:          0          0          0          0   IO-APIC-level 
usb-uhci
 19:          0          0          0          0   IO-APIC-level 
usb-uhci
 28:       4937       4915       4881       5053   IO-APIC-level 
aic7xxx
 29:          4          4          4          4   IO-APIC-level 
aic7xxx
NMI:          0          0          0          0 
LOC:     469377     469403     469435     469433 
PMC:          0          0          0          0 
ERR:          0
MIS:          0
te gcle1 ~ 5> 

LOC:     469377     469403     469435     469433 
PMC:          0          0          0          0 
ERR:          0
MIS:          0
te gcle1 ~ 5> 


On Wed, 2002-04-10 at 14:23, zxj@water.pku.edu.cn wrote:
> Hello
> 
>     I am using two Intel Giga NICs in a DELL PowerEdge 4600
>     with 2 Intel XEON 1.8GHz CPUs.
>     The matherboard is ServerWorks GC-HE.
>     The OS is RedHat 7.2, and the release of kernel is "2.4.7-10smp".
> 
>     The CPU0 has very heavy interrupt traffic,
>     you can see the following information:
> >>>>>
> [root@giga root]# cat /proc/interrupts
>            CPU0       CPU1       
>   0:     395117          0    IO-APIC-edge  timer
>   1:        653          0    IO-APIC-edge  keyboard
>   2:          0          0          XT-PIC  cascade
>   8:          1          0    IO-APIC-edge  rtc
>  12:         23          0    IO-APIC-edge  PS/2 Mouse
>  14:          2          0    IO-APIC-edge  ide0
>  18:         30          0   IO-APIC-level  aic7xxx
>  19:      86013          0   IO-APIC-level  eth0
>  20:      10394          0   IO-APIC-level  aic7xxx
>  21:         30          0   IO-APIC-level  aic7xxx
>  27:    5480873          0   IO-APIC-level  e1000
>  39:  164889152          0   IO-APIC-level  e1000
> NMI:          0          0 
> LOC:     395013     395012 
> ERR:          0
> MIS:          0
> >>>>>
> 
>     The kernel's SMP option is enable, but the CPU1 is always idle.
>     How to balance the interrpupts between two CPUs?
>     If you are convenient, please give me some advice quickly.
> 
>     Thank you!
> 
> Best regard
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
-- 
_________________________________________________________________________

Terje Eggestad                  mailto:terje.eggestad@scali.no
Scali Scalable Linux Systems    http://www.scali.com

Olaf Helsets Vei 6              tel:    +47 22 62 89 61 (OFFICE)
P.O.Box 150, Oppsal                     +47 975 31 574  (MOBILE)
N-0619 Oslo                     fax:    +47 22 62 89 51
NORWAY            
_________________________________________________________________________

