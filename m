Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262521AbVBXWev@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262521AbVBXWev (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 17:34:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262523AbVBXWev
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 17:34:51 -0500
Received: from quark.didntduck.org ([69.55.226.66]:50634 "EHLO
	quark.didntduck.org") by vger.kernel.org with ESMTP id S262521AbVBXWeZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 17:34:25 -0500
Message-ID: <421E5674.5000901@didntduck.org>
Date: Thu, 24 Feb 2005 17:34:28 -0500
From: Brian Gerst <bgerst@didntduck.org>
User-Agent: Mozilla Thunderbird  (X11/20041216)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Terence Ripperda <tripperda@nvidia.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 64-bit pci bar on a 32-bit kernel
References: <20050224202218.GK4801@hygelac>
In-Reply-To: <20050224202218.GK4801@hygelac>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Terence Ripperda wrote:
> Hello,
> 
> we've gotten a customer report of a problem whereby our framebuffer is
> not visible through the kernel. the kernel data structures in struct
> pci_dev have bar1 (our framebuffer) set to 0, and the bar does not
> appear in /proc/pci.
> 
> after a little investigation, it appears that the bios allocated a
> 64-bit bar in pci config space. our gpu claims 64-bit support in pci
> config space and the cpu is an em64t. but the customer is running a
> 32-bit kernel on the em64t, which is a reasonable thing to do. it
> turns out the pci driver does not like 64-bit bars on a 32-bit kernel
> and prints out the following messages during boot:
> 
> PCI: PCI BIOS revision 2.10 entry at 0xf0031, last bus=5
> PCI: Using configuration type 1
> PCI: Probing PCI hardware
> PCI: Probing PCI hardware (bus 00)
> PCI: Ignoring BAR0-3 of IDE controller 00:1f.1
> PCI: Unable to handle 64-bit address space for
> PCI: Unable to handle 64-bit address space for
> PCI: Unable to handle 64-bit address for device 03:00.0
> PCI: Unable to handle 64-bit address space for
> 
> Is this an expected problem? Is there any reason why the 32-bit kernel
> couldn't handle 64-bit bars?
> 
> here's what pci config space for our gpu looks like:
> 
> 00: de 10 ce 00 07 01 10 00 a2 00 00 03 10 00 00 00
> 10: 00 00 00 de 0c 00 00 f8 0f 00 00 00 04 00 00 dd
> 20: 00 00 00 00 00 00 00 00 00 00 00 00 de 10 43 02
> 30: 00 00 ee df 60 00 00 00 00 00 00 00 0a 01 00 00
> 
> Thanks,
> Terence
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

It looks like support for 64-bit struct resouce is being worked on in 
the -mm tree.

--
				Brian Gerst
