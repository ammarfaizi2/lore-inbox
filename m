Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292537AbSBTV52>; Wed, 20 Feb 2002 16:57:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292535AbSBTV5J>; Wed, 20 Feb 2002 16:57:09 -0500
Received: from callisto.affordablehost.com ([64.23.37.14]:3599 "HELO
	callisto.affordablehost.com") by vger.kernel.org with SMTP
	id <S292533AbSBTV45>; Wed, 20 Feb 2002 16:56:57 -0500
Message-ID: <3C741BAF.9090300@keyed-upsoftware.com>
Date: Wed, 20 Feb 2002 15:57:03 -0600
From: David Stroupe <dstroupe@keyed-upsoftware.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.2.1) Gecko/20010901
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Q: PCI Driver ioremap
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am creating a PCI driver for a custom card and want to write 0xffff to 
a location offset from the base by 0x48 and
have the following code:

<snip>
unsigned int io_addr;
unsigned int io_size;
void* base;
pci_enable_device (pdev)
io_addr = pci_resource_start(pdev, 0);
io_size = pci_resource_len(pdev, 0);
if ((pci_resource_flags(pdev, 0) & IORESOURCE_MEM)){
       if(check_mem_region(io_addr, io_size))
            DBG("Already In Use");//this is never reached
        request_mem_region(io_addr, io_size , "Card Driver");
        base=ioremap(io_addr, io_size);
        if(base==0)
           DBG("memory mapped wrong\n");//this is never reached
        writew(0xffff, base + 0x48);
<snip>


The card is found, io_addr = 0xe9011000 and io_size = 0x200.

The write is unsuccessful or at least the data never reaches the card. 
 What am I doing incorrectly?

Thanks and best regards,
David

