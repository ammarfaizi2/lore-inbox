Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263953AbUAZQhc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jan 2004 11:37:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264284AbUAZQhc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jan 2004 11:37:32 -0500
Received: from relaycz.systinet.com ([62.168.12.68]:32896 "HELO
	relaycz.systinet.com") by vger.kernel.org with SMTP id S263953AbUAZQh3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jan 2004 11:37:29 -0500
Subject: Re: DMA timeout error and then kernel halted
From: Jan Mynarik <mynarikj@phoenix.inf.upol.cz>
To: linux-kernel@vger.kernel.org
Cc: andre@linux-ide.org
In-Reply-To: <1074533362.7913.14.camel@narsil>
References: <1074533362.7913.14.camel@narsil>
Content-Type: text/plain
Message-Id: <1075135039.3449.23.camel@narsil>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 26 Jan 2004 17:37:19 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've resolved my problem, DMA must be turned on by "Use DMA by default
in kernel config", it siply doesn't like latter attempts by hdparm. I
tried to have DMA by default previously but only by ide2=dma kernel boot
parameter.

Now, I'm on 40MB/s and happy :-)

Jan "Pogo" Mynarik

On Mon, 2004-01-19 at 18:29, Jan Mynarik wrote:
> Hi,
> 
> I have DMA problems with HPT366 on BP6 (newest BIOS version RU incl.
> 1.28 BIOS for HPT366) and Seagate's 80 GB disk (please see exact model
> numbers in attached dmesg).
> 
> It's reproducible (with or without SMP, various kernel versions,
> overclocking or not, ACPI on and off) on 2.4.22 and 2.6.0 (test9, test11
> and vanilla) and 2.6.1-rc3. On 2.4 kernel it doesn't halt kernel.
> 
> Problem description:
> When I try to set DMA by hdparm, after several seconds the HDD led gets
> on and remains on for another amount of seconds, then I got
> 
> hde: dma_timer_expiry: dma status == 0x21
> 
> and after a while
> 
> hde: DMA timeout error
> 
> then kernel is halted and I need to reset my PC.
> 
> 
> After some investigations I realized that the problem could be in the
> combination of HPT366 and Seagate disk. In the source code of
> HighPoint's driver
> (http://www.highpoint-tech.com/hpt3xx-opensource-v131.tgz - link is in
> kernel's drivers/ide/pci/hpt366.c) I can see some function
> (seagate_hdd_fix) used to fix
> some seagate disk initialization problem which is not present in
> hpt366.c in kernel. I think that's the problem because I
> haven't found any reported problem and I think that BP6 is still widely
> used.
> 
> Is it known? Any patches, workarounds, or other suggestions?
> 
> Regards,
> 
> Jan "Pogo" Mynarik
-- 
Jan Mynarik <mynarikj@phoenix.inf.upol.cz>

