Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932391AbWAUCJY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932391AbWAUCJY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 21:09:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932395AbWAUCJY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 21:09:24 -0500
Received: from wproxy.gmail.com ([64.233.184.200]:28248 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932391AbWAUCJX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 21:09:23 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=p/5hSdoOzmgX4b3Y6GJgIQl13oI9WcYn45MRopQ9oyUShqQY1JhWLuPvUz7TF1lBQoX/rjkTpcdhdYyFiRS5Gtn00JuzlYzLeg9NmroQ8r5V4nXhgBAaPBbnH361X8vsqqq1w5TE9TSIhUXP8Iwub/FCJlcnY8FXyaB7E2Kz2pw=
Message-ID: <43D197C9.7050507@gmail.com>
Date: Sat, 21 Jan 2006 11:09:13 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051019)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Luyer <david@luyer.net>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: Re: ASUS A7V-E SE + Linux Kernel 2.6.15.1 = SATA Issues
References: <200601181512.k0IFCsfU021937@typhaon.pacific.net.au>
In-Reply-To: <200601181512.k0IFCsfU021937@typhaon.pacific.net.au>
Content-Type: text/plain; charset=EUC-KR
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Luyer wrote:
> I have a system which was working perfectly with A7V motherboard and
> kernel 2.6.13.2.  After a motherboard upgrade to A7V-E SE (only other
> changes being graphics card and power supply), kernel 2.6.13.2 hung
> during initial ATA detection, so I am now attempting to get 2.6.15.1
> working (as the latest stable kernel).
> 
> 2.6.15.1 can read the hard disks, just very slowly (with many timeouts,
> I am now leaving the system overnight to boot up - so far, it has
> autorun the MD arrays and detected the ReiserFS format).
> 
> System summary:
>         Motherboard: ASUS A7V-E SE
>         BIOS: 1007; set to IDE in "SATA Mode" (IDE or RAID)
>         Kernel: 2.6.15.1 with CONFIG_SCSI_SATA_VIA
>         Hard disks: 2 x WDC WD2500KS-00M Rev 02.0; Linux MD RAID1
> 
> Hangs are experienced followed by the following lines on the console:
>         ata1: slow completion (cmd ef)
>         ata2: slow completion (cmd ef)
>                 -- above messages occur once each per boot
>         ata1: command 0x25 timeout, stat 0x50 host_stat 24
>         ata2: command 0x25 timeout, stat 0x50 host_stat 24
>                 -- above messages occur numerous times,
>                    perhaps even every block read
> 
> Other interesting bootup messages include numerous PCI: Via IRQ fixup
> messages (presumably one per device, definitely including the SATA
> controller).
> 
> dmesg and lspci -vvx will be sent through if the boot completes,
> assuming the kernel log buffer is long enough to perform a dmesg
> with information other than all the timeouts once the boot
> completes.  Or, if the boot doesn't complete by tomorrow, I'll
> look into building a kernel with significantly reduced SATA
> command timeouts (and a larger kernel log buffer if required),
> to try and get this information.
> 
> Any initial suggestions in the interim?  I need PCI Express
> for a graphics card to support a Dell 3007FPW, avoided nForce4
> due to excessive random corruption with the nForce4 and WD2500KS
> drives under Windows in another system, and would really prefer
> not to buy yet another motherboard, so I would really like
> to get this working.

It seems like IRQ routing problem.  The driver never receives the
completion interrupts.  When it times out, it finds out that the command
is actually complete, so the slow completion messages.  Turning off ACPI
seems to be a popular solution.

> 
> Random irrelevant evil thoughts: could Intel VT make BIOS hard
> disk access viable for Linux by proxying disk accesses through
> a second virtual machine?  Or even Windows SATA driver support
> through SAMBA to a disk image on a Windows machine on a second
> virtual machine?

Oh well, it would be much easier/better to just fix the original problem.

-- 
tejun
