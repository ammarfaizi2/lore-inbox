Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264663AbRGLOIU>; Thu, 12 Jul 2001 10:08:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264752AbRGLOIK>; Thu, 12 Jul 2001 10:08:10 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:35985 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S264663AbRGLOIC>;
	Thu, 12 Jul 2001 10:08:02 -0400
Message-ID: <3B4DAF3F.37C2EBC6@mandrakesoft.com>
Date: Thu, 12 Jul 2001 10:07:59 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.7-pre3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Zehetbauer Thomas <TZ@link.topcall.co.at>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: Cannot access PCI device
In-Reply-To: <41EA756DBC9FD0118CFC0020AFDB5C5A188E07@tcint1ntsrv>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zehetbauer Thomas wrote:
> 
> Hi! I am trying to access a custom PCI device on a Walnut Rev. D system
> running Hard Hat Linux Rev. 1.2 with Montavista kernel snapshot
> 01.04.12. The following code is beeing executed in the probe function of
> a kernel module and works well on Linux 2.4.2/Intel but returns useless
> values on PowerPC.
> 
> ### begin code ###
>         unsigned long linux_addr_start, linux_addr_end, val;
>         u32 config_addr;
> 
>         pdev = pci_find_device(0x10ee, 0x4030, pdev);
>         if (NULL == pdev)
>                 return(-1);

use pci_register_driver or pci_module_init not pci_find_device

>         if (pci_enable_device(pdev))
>                 return(-1);
>         linux_addr_start = pci_resource_start(pdev, 0);
>         linux_addr_end = pci_resource_end(pdev, 0);
>         pci_read_config_dword(pdev, PCI_BASE_ADDRESS_0, &config_addr);
>         printk("Found %s\n", pdev->name);
>         printk("pci_resource_start=%lx\n", linux_addr_start);
>         printk("pci_resource_end=%lx\n", linux_addr_end);
>         printk("PCI_BASE_ADDRESS_0=%lx\n", config_addr);
>         IOAddress = ioremap(config_addr, 0xffff);

bug: calling ioremap with config_addr value directly from PCI BAR
register.  You should mask the value.  However, it is irrelevant: 
linux_addr_start make config_addr unnecessary.

-- 
Jeff Garzik      | A recent study has shown that too much soup
Building 1024    | can cause malaise in laboratory mice.
MandrakeSoft     |
