Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263727AbUC3PcL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 10:32:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263721AbUC3PcK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 10:32:10 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:55475 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263727AbUC3PbV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 10:31:21 -0500
Message-ID: <406992BC.60503@pobox.com>
Date: Tue, 30 Mar 2004 10:31:08 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Marc Bevand <bevand_m@epita.fr>
CC: Andrew Morton <akpm@osdl.org>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] speed up SATA
References: <4066021A.20308@pobox.com> <40695FF6.3020401@epita.fr>
In-Reply-To: <40695FF6.3020401@epita.fr>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marc Bevand wrote:
> Jeff Garzik wrote:
> 
>>
>> [...]
>> With this simple patch, the max request size goes from 128K to 32MB... 
>> so you can imagine this will definitely help performance.  Throughput 
>> goes up.  Interrupts go down.  Fun for the whole family.
>> [...]
> 
> 
> I have experienced a noticeable improvement concerning the CPU usage
> and disk throughput with this patch.
> 
> Benchmark specs:
> 
>  o read from only 1 disk (sda), or from 2 disks (sda+sdb), with
>    1 or 2 instances of "dd if=/dev/sd? of=/dev/null bs=100M".
>  o hardware: two Seagate 160GB SATA, on a Silicon Image 3114, on a
>    32-bit/33MHz PCI bus, 1GB RAM.
>  o software: kernel 2.6.5-rc2-bk6-libata2.

[...]

Very cool, thanks for benching!


> As other people were complaining that the 32MB max request size might be 
> too
> high, I did give a try to 1MB (by replacing "65534" by "2046" in the 
> patch).
> There is no visible differences between 32MB and 1MB.

This is not surprising, since:
* the scatter-gather table imposes a limit of 8MB
* the VM further imposes limits on readahead and writeback

So 32MB is the hardware max, but not really achieveable due to other 
factors.


> PS: Jeff: "pci_dma_mapping_error()", in libata-core.c from your latest
> 2.6-libata patch, is an unresolved symbol. I have had to comment it out
> to be able to compile the kernel.

Yeah, this is only found in the bleeding-edge-latest 2.6.x kernels.  You 
did the right thing...

Regards,

	Jeff



