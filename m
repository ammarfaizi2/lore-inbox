Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293057AbSBWAdp>; Fri, 22 Feb 2002 19:33:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293058AbSBWAdg>; Fri, 22 Feb 2002 19:33:36 -0500
Received: from [192.68.228.82] ([192.68.228.82]:50449 "HELO
	fcexgw03.efi.internal") by vger.kernel.org with SMTP
	id <S293057AbSBWAdR>; Fri, 22 Feb 2002 19:33:17 -0500
Message-ID: <3C76E4EF.1A4AE878@efi.com>
Date: Fri, 22 Feb 2002 16:40:15 -0800
From: Kallol Biswas <kallol@efi.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2-2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: eepro100 driver can't read serial eeprom that is beyond a bridge
In-Reply-To: <3C6DBA20.28E40161@efi.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The problem has been fixed changing the access to the eeprom comtrol
register from I/O to memory.

The lines that have been changed:
                    do_eeprom_cmd() {
                      change io_outw to outw
                      and out_inw to inw
                   }
speedo_found1() {

             /*
                iobase = pci_resource_start(pdev, 1);
             */
                iobase = ioaddr;
}



Kallol Biswas wrote:

> Hi,
>      We have a system  running 2.4.17 with the following configuration.
>
>     ------North Bridge---------PCI-PCI-BRIDGE----82559ER
>                                                        |
>                                                    82559ER
> # lspci
> ......
> 00:12.0 Ethernet controller: Intel Corp. 82559ER (rev 09)
> .......
> 00:0f.0 PCI bridge: Digital Equipment Corporation DECchip 21152 (rev 03)
>
> .........
> 02:01.0 Ethernet controller: Intel Corp. 82559ER (rev 09)
>
> #insmod eepro100
>
> .........
> eth0: Intel Corp. 82559ER, l00:eC0:s85:/30:292:.9F, 4IRQ 12.
> ............
>
> eth1: OEM i82557/i82558 10/100 Ethernet, FF:FF:FF:FF:FF:FF, IRQ 10.
> ........
>
> It seems  eepro100 driver can't read the eeprom from the 2nd card. I
> have
> printed the data bits in the
> do_eeprom_cmd  routine, all were 1. Adjusting the delay  did not help.
>
> The eepro100 driver on 2.2 kernel works fine and even intel's e100
> driver on
> 2.4.17 also works fine.
>
> I guess there may be some timing issues involved.
>
> Are the  devices beyond a bridge  imapped to I/O space properly in 2.4
> kernel? Intel's driver reads the EEPROM
> control register using memory cycles.
>
> Kallol
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

