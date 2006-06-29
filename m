Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751746AbWF2HLj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751746AbWF2HLj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 03:11:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751624AbWF2HLj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 03:11:39 -0400
Received: from mkedef1.rockwellautomation.com ([208.22.104.18]:60979 "EHLO
	ranasmtp01.ra.rockwell.com") by vger.kernel.org with ESMTP
	id S1751746AbWF2HLj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 03:11:39 -0400
To: Esben Nielsen <nielsen.esben@googlemail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BUG] Linux-2.6.17-rt3 on arm ixdp465
MIME-Version: 1.0
X-Mailer: Lotus Notes Release 5.0.12   February 13, 2003
Message-ID: <OF333B3CA3.DCE515CC-ONC125719C.00265C3B-C125719C.0026A1E2@ra.rockwell.com>
From: Milan Svoboda <msvoboda@ra.rockwell.com>
Date: Thu, 29 Jun 2006 09:01:23 +0200
X-MIMETrack: Serialize by Router on RANASMTP01/NorthAmerica/RA/Rockwell(Release 6.5.4FP1|June
 19, 2005) at 06/29/2006 02:12:26 AM,
	Serialize complete at 06/29/2006 02:12:26 AM
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> # 
> # Tulip family network device support 
> # 
> # CONFIG_NET_TULIP is not set 
> # CONFIG_HP100 is not set 
> CONFIG_NET_PCI=y 
> # CONFIG_PCNET32 is not set 
> # CONFIG_AMD8111_ETH is not set 
> # CONFIG_ADAPTEC_STARFIRE is not set 
> # CONFIG_B44 is not set 
> # CONFIG_FORCEDETH is not set 
> # CONFIG_DGRS is not set 
> CONFIG_EEPRO100=y 
> # CONFIG_E100 is not set 
> # CONFIG_FEALNX is not set 

I use "old" eepro100 network device driver...

Thank you for your answer, I look at it too...

Milan






Esben Nielsen <nielsen.esben@googlemail.com>
06/28/2006 07:02 PM

 
        To:     Milan Svoboda <msvoboda@ra.rockwell.com>
        cc:     linux-kernel@vger.kernel.org
        Subject:        Re: [BUG] Linux-2.6.17-rt3 on arm ixdp465


On Wed, 28 Jun 2006, Milan Svoboda wrote:

> Hello,
>
> I tried this kernel on arm ixdp465, it works well, but I got many
> of these messages:
>
> BUG: scheduling with irqs disabled: IRQ 25/0x00000000/683
> caller is rt_lock_slowlock+0xd8/0x1c8
> BUG: scheduling with irqs disabled: IRQ 25/0x00000000/683
> caller is rt_lock_slowlock+0xd8/0x1c8
> BUG: scheduling with irqs disabled: IRQ 25/0x00000000/683
> caller is rt_lock_slowlock+0xd8/0x1c8
> BUG: scheduling with irqs disabled: IRQ 25/0x00000000/683
> caller is rt_lock_slowlock+0xd8/0x1c8
> BUG: scheduling with irqs disabled: IRQ 25/0x00000000/683
> caller is rt_lock_slowlock+0xd8/0x1c8
>
> # cat /proc/interrupts
>           CPU0
> 5:      29620   IXP4xx Timer Tick
> 15:        876   serial
> 25:       3813   eth0
> Err:          0
>

Looks like a bug in your ethernet driver, which is?
It could be that that driver is not SMP compliant and uses irq 
disable/enable
as locking method instead of a spinlock.

Esben

> PS: Please CC me, I'm not subscribed...
>
> Best Regards,
> Milan Svoboda
>
>
>



