Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314101AbSDWCWp>; Mon, 22 Apr 2002 22:22:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314439AbSDWCWo>; Mon, 22 Apr 2002 22:22:44 -0400
Received: from ns0.tateyama.or.jp ([210.128.170.1]:33554 "HELO
	ns0.tateyama.or.jp") by vger.kernel.org with SMTP
	id <S314101AbSDWCWn> convert rfc822-to-8bit; Mon, 22 Apr 2002 22:22:43 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Gabor Kerenyi <wom@tateyama.hu>
To: linux-kernel@vger.kernel.org
Subject: unconfigure PCI dev
Date: Tue, 23 Apr 2002 11:28:09 +0900
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200204231128.09461.wom@tateyama.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi!

I've got a strange problem.

I'm writing a driver for a PCI card.
The card has a problem because the serial eeprom where the pci configuration 
data is loaded from is not valid and therefore the PLX-9050 chip gives some 
default value. It shows vendor:devid as 10b5:9050 and the kernel identifies 
it as a PLX PCI <-> IOBus Bridge. (kernel 2.5.7)

The serial eeprom can be read written at 50h in the local config area.
When I load my driver and it wants to request a memory region it seems that it 
is already mapped. (I modified the driver to look for 0x10b5:9050)

So it fails. 

The cat /proc/pci shows a memory region at 0xf4200000. 

int plc_init_dev1(struct pci_dev *dev)
{
	printk("%x\n", pci_resource_start(dev, 0);
	return -EBUSY;
	if (check_mem_region(pci_resource_start(dev, 0), 128))
		return -EBUSY;
}

So why is it already in use?
I have to access that memory area. How can I do it if my driver doesn't load?
That's the only way to modify the eeprom contents.

Thanks.

Gabor

