Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S261404AbVCFPPS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261404AbVCFPPS (ORCPT <rfc822;akpm@zip.com.au>);
	Sun, 6 Mar 2005 10:15:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261418AbVCFPPR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Mar 2005 10:15:17 -0500
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:6856 "EHLO
	pd2mo2so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S261404AbVCFPPK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Mar 2005 10:15:10 -0500
Date: Sun, 06 Mar 2005 09:14:33 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: NMI watchdog question
In-reply-to: <3EShS-A1-9@gated-at.bofh.it>
To: linux-kernel <linux-kernel@vger.kernel.org>
Message-id: <422B1E59.4060009@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; format=flowed; charset=ISO-8859-1
Content-transfer-encoding: 7bit
X-Accept-Language: en-us, en
References: <3EShS-A1-9@gated-at.bofh.it>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pallai Roland wrote:
> Hi,
>  I'm playing with the NMI watchdog (nmi_watchdog=1) on a reproductable
> hard lockup (no keyboard, etc) but seems like it doesn't works and I
> can't understand why, please explain to me the possible causes.. I
> belive it should work in this situation..
> 
> environment:
>  P4C800 motherboard, P4-2.4 cpu (APIC 2.0 on)
>  Promise 20378 SATA controller on the motherboard (sil_promise driver)
>  Maxtor diamondmax plus 9 200G sata disk
>  (and an empty PCI expander plus some more other under-testing hardware
> which doesn't matter in the experiment)
> 
>  mainline kernel 2.6.11
>  serial and VGA console, root on NFS
> 
> 
> steps to the lockup:
>  1. booting the machine with sata drive on the promise controller
>  2. dd if=/dev/sda of=/dev/null bs=4k
>  3. unplug the power from drive
>  4. waiting about 2 seconds
>  5. plug the power back
> 
>  dd stucked in 'D' here for 10-15 seconds and than the kernel say:
>   ata1: command timeout
> 
>  and voila, the box is dead, but without any message from the NMI
> watchdog :(

The NMI watchdog only triggers if something is blocking interrupts from 
getting through - if timer interrupts are still happening it won't 
activate. You can try Alt-Sysrq-T to get a traceback of where the 
current process is stuck..
