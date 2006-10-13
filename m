Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751021AbWJMTer@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751021AbWJMTer (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Oct 2006 15:34:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751821AbWJMTer
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Oct 2006 15:34:47 -0400
Received: from bellona.wg.saar.de ([192.109.53.23]:35857 "EHLO
	bellona.wg.saar.de") by vger.kernel.org with ESMTP id S1751021AbWJMTer
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Oct 2006 15:34:47 -0400
Message-ID: <452FE995.5020001@hal.saar.de>
Date: Fri, 13 Oct 2006 21:31:33 +0200
From: Michael Kress <kress@hal.saar.de>
User-Agent: Thunderbird 1.5.0.7 (Windows/20060909)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: irq issues ("nobody cared")
References: <45291832.4010705@hal.saar.de>
In-Reply-To: <45291832.4010705@hal.saar.de>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have to reply myself with a workaround and in my case it's a part time
solution:
rmmod uhci_hcd
As you can see in /proc/bus/usb/devices, I've got a Peppercon eric card,
which contains the irq16+17 handled usb devices (obviously
keybord&mouse). Whenever I really need it, I'll modprobe it. That's
still ok, because the "nobody cared" message appears after quite a
while. But I won't need it as for kernel upgrades I can even shutdown -r
from an ssh shell, which is enough for the card's purpose (show grub &
bios menus).
Without the module, the messages don't arise anymore.
   Regards, Michael

Michael Kress wrote:
> I'm having trouble with irqs ...
>
> Oct  8 10:38:51 matrix kernel: irq 16: nobody cared (try booting with
> the "irqpoll" option)
> Oct  8 10:38:51 matrix kernel:
> Oct  8 10:38:51 matrix kernel: Call Trace: <IRQ>
> <ffffffff801519b0>{__report_bad_irq+48}
> Oct  8 10:38:51 matrix kernel:       
> <ffffffff80151c0f>{note_interrupt+511} <ffffffff80151324>{__do_IRQ+212}
> Oct  8 10:38:51 matrix kernel:        <ffffffff8010dae4>{do_IRQ+68}
> <ffffffff80250fad>{evtchn_do_upcall+205}
> Oct  8 10:38:51 matrix kernel:       
> <ffffffff8010ba0a>{do_hypervisor_callback+30}
> <ffffffff8011da36>{ia32_syscall+30                                        }
> Oct  8 10:38:51 matrix kernel:       
> <ffffffff8010722a>{hypercall_page+554}
> <ffffffff8010722a>{hypercall_page+554}
> Oct  8 10:38:51 matrix kernel:       
> <ffffffff80250eda>{force_evtchn_callback+10}
> <ffffffff80134587>{__do_softirq+103                                        }
> Oct  8 10:38:51 matrix kernel:       
> <ffffffff8010beda>{call_softirq+30} <ffffffff8010dc97>{do_softirq+71}
> Oct  8 10:38:51 matrix kernel:        <ffffffff8010dae9>{do_IRQ+73}
> <ffffffff80250fad>{evtchn_do_upcall+205}
> Oct  8 10:38:51 matrix kernel:       
> <ffffffff8010ba0a>{do_hypervisor_callback+30} <EOI>
> Oct  8 10:38:51 matrix kernel:        <ffffffff8011da36>{ia32_syscall+30}
> Oct  8 10:38:51 matrix kernel: handlers:
> Oct  8 10:38:52 matrix kernel: [<ffffffff802aa310>] (usb_hcd_irq+0x0/0x60)
> Oct  8 10:38:52 matrix kernel: [<ffffffff802aa310>] (usb_hcd_irq+0x0/0x60)
> Oct  8 10:38:52 matrix kernel: Disabling IRQ #16
>
> Sometimes it's also irq 17. Of course I tried irqpoll, but that's no use
> here.
>   
...
> [root@matrix ~]# cat /proc/bus/usb/devices
>   
...
> T:  Bus=02 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#=  2 Spd=12  MxCh= 0
> D:  Ver= 1.10 Cls=00(>ifc ) Sub=00 Prot=00 MxPS=64 #Cfgs=  1
> P:  Vendor=14dd ProdID=1002 Rev= 0.01
> S:  Manufacturer=Peppercon AG
> S:  Product=MultiDevice
> S:  SerialNumber=123456789012
> C:* #Ifs= 2 Cfg#= 1 Atr=80 MxPwr=100mA
> I:  If#= 0 Alt= 0 #EPs= 1 Cls=03(HID  ) Sub=01 Prot=01 Driver=usbhid
> E:  Ad=84(I) Atr=03(Int.) MxPS=   8 Ivl=10ms
> I:  If#= 1 Alt= 0 #EPs= 1 Cls=03(HID  ) Sub=00 Prot=02 Driver=usbhid
> E:  Ad=83(I) Atr=03(Int.) MxPS=   8 Ivl=10ms
>   

-- 
Michael Kress, kress@hal.saar.de
http://www.michael-kress.de / http://kress.net
P E N G U I N S   A R E   C O O L

