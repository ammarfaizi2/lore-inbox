Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932376AbWHJVKo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932376AbWHJVKo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 17:10:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932367AbWHJVKn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 17:10:43 -0400
Received: from terminus.zytor.com ([192.83.249.54]:43670 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S932365AbWHJVKl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 17:10:41 -0400
Message-ID: <44DBA03D.1050505@zytor.com>
Date: Thu, 10 Aug 2006 14:08:13 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Donald Becker <becker@scyld.com>
CC: Alan Shieh <ashieh@cs.cornell.edu>,
       Daniel Rodrick <daniel.rodrick@gmail.com>,
       Linux Newbie <linux-newbie@vger.kernel.org>,
       kernelnewbies <kernelnewbies@nl.linux.org>, linux-net@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: Univeral Protocol Driver (using UNDI) in Linux
References: <Pine.LNX.4.44.0608101156490.20933-100000@bluewest.scyld.com>
In-Reply-To: <Pine.LNX.4.44.0608101156490.20933-100000@bluewest.scyld.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Donald Becker wrote:
> On Tue, 8 Aug 2006, Alan Shieh wrote:
> 
>> With help from the Etherboot Project, I've recently implemented such a 
>> driver for Etherboot 5.4. It currently supports PIO NICs (e.g. cards 
>> that use in*/out* to interface with CPU). It's currently available in a 
>> branch, and will be merged into the trunk by the Etherboot project. It 
>> works reliably with QEMU + PXELINUX, with the virtual ne2k-pci NIC.
>>
>> Barring unforseen issues, I should get MMIO to work soon; target 
>> platform would be pcnet32 or e1000 on VMware, booted with PXELINUX.
> 
> Addressing a very narrow terminology issue:
> 
> I think that there a misuse of terms here.  PIO, or Programmed I/O, is 
> data transfer mode where the CPU explicitly passes data to and from a 
> device through a single register location.
> 
> The term is unrelated to the device being addressed in I/O or memory 
> space.  On the x86, hardware devices were usually in the I/O address space 
> and there are special "string" I/O instructions, so PIO and I/O space were 
> usually paired.  But processors without I/O instructions could still do 
> PIO transfers.
> 
> Memory Mapped I/O, MMIO, is putting the device registers in memory space.  
> In the past it specifically meant sharing memory on the device e.g. when 
> the packet buffer memory on a WD8013 NIC was jumpered into the ISA address 
> space below 1MB.  The CPU still controls the data transfer, generating a 
> write for each word transfered.  But the address changed with each write, 
> just like a memcpy.
> 

Basically:

	PIO	= CPU initiates transfers
	DMA	= device initiates transfers(*)
	IOIO	= I/O mapped PIO
	MMIO	= Memory mapped PIO


> Today "MMIO" is sometimes misused to mean simply using a PCI memory 
> mapping rather than a PCI I/O space mapping.  PCI actually has three 
> address spaces: memory, I/O and config spaces.  Many devices allow 
> accessing the operational registers either through I/O or memory spaces.

Why is that a misuse?

	-hpa


(*) There are actually two kinds of DMA, bus mastering DMA, in which the 
device itself initiates transfers, and slave DMA, in which a third agent 
(the DMA controller) initiates transfers.  In modern PC systems slave 
DMA is extremely slow and is only used for legacy devices, pretty much 
the floppy disk and nothing else, but some other architectures have 
modern implementations and slave DMA is widely used.
