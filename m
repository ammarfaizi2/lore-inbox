Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313054AbSDJNZd>; Wed, 10 Apr 2002 09:25:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313057AbSDJNZc>; Wed, 10 Apr 2002 09:25:32 -0400
Received: from [211.152.42.5] ([211.152.42.5]:58385 "HELO mail.netstd.com")
	by vger.kernel.org with SMTP id <S313054AbSDJNZb>;
	Wed, 10 Apr 2002 09:25:31 -0400
Message-ID: <006301c1e092$97659af0$0316a8c0@XXOO>
From: "lm0re" <lm0re@yahoo.com>
To: <zxj@water.pku.edu.cn>, <linux-kernel@vger.kernel.org>
In-Reply-To: <b5926afe75.afe75b5926@water.pku.edu.cn>
Subject: Re: how to balance interrupts between 2 CPUs?
Date: Wed, 10 Apr 2002 21:21:14 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I think your got something  wrong, I've a 2 cpus box, all is ok,see below:

[root@info /proc]# cat interrupts
           CPU0       CPU1
  0:    1245694    1389471    IO-APIC-edge  timer
  1:        157        121    IO-APIC-edge  keyboard
  2:          0          0          XT-PIC  cascade
  8:          0          1    IO-APIC-edge  rtc
 10:      10685      10958   IO-APIC-level  usb-uhci, e100
 14:      36926      50216    IO-APIC-edge  ide0
 15:          1          1    IO-APIC-edge  ide1
NMI:          0          0
LOC:    2635076    2635074
ERR:          0
MIS:          0

Read the IRQ-affinity.txt which should usual be at
/usr/src/linux/Documentation, and change the configuration maybe your can
specify cpu1 processes the IRQ 18. And check the result.

lm0re


----- Original Message -----
From: <zxj@water.pku.edu.cn>
To: <linux-kernel@vger.kernel.org>
Sent: Wednesday, April 10, 2002 8:23 PM
Subject: how to balance interrupts between 2 CPUs?


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


