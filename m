Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312684AbSDJOEk>; Wed, 10 Apr 2002 10:04:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313075AbSDJOEj>; Wed, 10 Apr 2002 10:04:39 -0400
Received: from ns1.advfn.com ([212.161.99.144]:57872 "EHLO mail.advfn.com")
	by vger.kernel.org with ESMTP id <S312684AbSDJOEj>;
	Wed, 10 Apr 2002 10:04:39 -0400
Message-Id: <200204101404.g3AE4bs30567@mail.advfn.com>
Content-Type: text/plain; charset=US-ASCII
From: Tim Kay <timk@advfn.com>
Reply-To: timk@advfn.com
Organization: Advfn.com
To: linux-kernel@vger.kernel.org
Subject: Re: how to balance interrupts between 2 CPUs?
Date: Wed, 10 Apr 2002 15:06:50 +0100
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <b5926afe75.afe75b5926@water.pku.edu.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Using a poweredge XXXXX with apic enabled (the default) will give you CPU 
interrupt sharing:

          CPU0       CPU1
  0:   34977278   34950769    IO-APIC-edge  timer
  1:          1          1    IO-APIC-edge  keyboard
  2:          0          0          XT-PIC  cascade
 14:          5          1    IO-APIC-edge  ide0
 16:  149330778  149335816   IO-APIC-level  eth0
 30:    2975700    2977038   IO-APIC-level  aic7xxx
 31:          7          9   IO-APIC-level  aic7xxx
NMI:          0          0
LOC:   69933245   69933202
ERR:          0
MIS:          0

but /var/log/messages will overflow with APIC errors and your machine will 
eventually (in my exp) die as it stops answering the interrupt requests so 
you should stick to append="noapic" in your lilo.conf or whatever. The above  
is happening to us on PE 1550s 2450s & 6400s anyway. I believe <DUCKS> that, 
unless you are running single CPU hogging apps on a one per processor basis,  
you dont lose a great deal with one processor dealing with the IRQs and the 
other(s) running the software.

Tim   

On Wednesday 10 Apr 2002 13:23, zxj@water.pku.edu.cn wrote:
> Hello
>
>     I am using two Intel Giga NICs in a DELL PowerEdge 4600
>     with 2 Intel XEON 1.8GHz CPUs.
>     The matherboard is ServerWorks GC-HE.
>     The OS is RedHat 7.2, and the release of kernel is "2.4.7-10smp".
>
>     The CPU0 has very heavy interrupt traffic,
>     you can see the following information:
>
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
>
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
----------------
Tim Kay
systems administrator
Advfn.com Plc - http://www.advfn.com/
timk@advfn.com
Tel: 020 7070 0941
Fax: 020 7070 0959
