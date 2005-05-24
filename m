Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262056AbVEXOyL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262056AbVEXOyL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 May 2005 10:54:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262067AbVEXOyL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 May 2005 10:54:11 -0400
Received: from alog0263.analogic.com ([208.224.222.39]:53455 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S262056AbVEXOx7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 May 2005 10:53:59 -0400
Date: Tue, 24 May 2005 10:53:24 -0400 (EDT)
From: "Richard B. Johnson" <linux-os@analogic.com>
Reply-To: linux-os@analogic.com
To: COMBES Julien - CETE Lyon/DI/ET/PAMELA <julien.combes@i-carre.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: megaraid irq disable after days
In-Reply-To: <4293368B.50808@i-carre.net>
Message-ID: <Pine.LNX.4.61.0505241051310.16158@chaos.analogic.com>
References: <4293368B.50808@i-carre.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is usually caused by the driver not returning IRQ_HANDLED.


On Tue, 24 May 2005, COMBES Julien - CETE Lyon/DI/ET/PAMELA wrote:
> Hello,
>
> I have a problem with a kernel 2.6.10 (sources from debian) which
> disable IRQ of my megraid (driver megaraid_mbox) on several servers
> after days of work and several millions of interuptions.
> When the IRQ is disable, the servers do that :
>
> May 22 03:02:20 relternet-01 kernel: irq 17: nobody cared!
> May 22 03:02:20 relternet-01 kernel:  [__report_bad_irq+42/160]
> __report_bad_irq+0x2a/0xa0
> May 22 03:02:20 relternet-01 kernel:  [handle_IRQ_event+48/112]
> handle_IRQ_event+0x30/0x70
> May 22 03:02:20 relternet-01 kernel:  [note_interrupt+112/176]
> note_interrupt+0x70/0xb0
> May 22 03:02:20 relternet-01 kernel:  [__do_IRQ+304/320]
> __do_IRQ+0x130/0x140
> May 22 03:02:20 relternet-01 kernel:  [do_IRQ+25/48] do_IRQ+0x19/0x30
> May 22 03:02:20 relternet-01 kernel:  [common_interrupt+26/32]
> common_interrupt+0x1a/0x20
> May 22 03:02:20 relternet-01 kernel:  [mwait_idle+51/80]
> mwait_idle+0x33/0x50
> May 22 03:02:20 relternet-01 kernel:  [cpu_idle+59/80] cpu_idle+0x3b/0x50
> May 22 03:02:20 relternet-01 kernel: handlers:
> May 22 03:02:20 relternet-01 kernel: [pg0+944120576/1069794304]
> (megaraid_isr+0x0/0x1e0 [megaraid_mbox])
> May 22 03:02:20 relternet-01 kernel: Disabling IRQ #17
>
> I haven't noticed something else curious on the servers.
>
> hardware of these servers :
> - bi Intel Xeon 2.4Ghz
> - 4.5 GB of RAM
> - MegaRaid SCSI 320-2 [1]
>
> The kernel use  SMP, HT, high memory support 64GB, megaraid_mbox driver
> (v2.20.4.1, in module with initrd until yesterday) and don't use preempt.
>
> As I didn't find anything that match IRQ disable and megaraid under
> internet, I have tried several ways :
> - at the beginning, the IRQ of eth0 and megaraid was shared. I have
> corrected this [2] but the problem is staying.
> - I have try newer version of the kernel 2.6.9 to 2.6.10. No benefic
> result.
> - I have try the boot option "acpi=ht". No benefic result.
> - the firmeware of the megaraid has been upgraded (to the 1L37
> version). No benefic result.
>
> Since yesterday, I am trying, on all server which have the problem,
> kernel  2.6.11.10 (source take kernel.org) with megaraid_mbox built-in
> (v2.20.4.5) and with differents boot options on servers :
> - "noirqdebug" and "acpi=ht"
> - "noirqdebug" and "acpi=off"
> - "acpi=off"
> - "acpi=ht"
>
> I have this problem  since I installed them few weeks ago with my new
> FAI (Debian Fully autmatic Installation). I have a lot of difficulty for
> solving the probleme because servers can run without problem one or two
> weeks. These servers are not yet in production but still in tests of
> charge; they should be in production in one or two weeks... if I find a
> way to correct this problem !
>
> Do you have any ideas of which way I can search ?
>
> Regards,
> Julien
>
> [1] 0000:03:08.0 RAID bus controller: LSI Logic / Symbios Logic MegaRAID
> (rev 01)
>        Subsystem: LSI Logic / Symbios Logic MegaRAID 518 SCSI 320-2
> Controller
>        Flags: bus master, fast Back2Back, 66MHz, slow devsel, latency
> 32, IRQ 17
>        Memory at d0500000 (32-bit, prefetchable) [size=64K]
>        Capabilities: [80] Power Management version 2
>
> [2]
> irq  0:  88018734 timer                 irq 16:  21659113 eth0
> irq  1:         9 i8042                 irq 17:  12532775 megaraid
> irq  2:         0 cascade [4]           irq 18:        30 aic79xx
> irq 12:         3                       irq 19:        30 aic79xx
> irq 14:         1 ide0                  irq 23:         0 ehci_hcd
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

Cheers,
Dick Johnson
Penguin : Linux version 2.6.11.9 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.
