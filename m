Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262934AbRFNOdN>; Thu, 14 Jun 2001 10:33:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263016AbRFNOdD>; Thu, 14 Jun 2001 10:33:03 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:7823 "HELO havoc.gtf.org")
	by vger.kernel.org with SMTP id <S262934AbRFNOdB>;
	Thu, 14 Jun 2001 10:33:01 -0400
Message-ID: <3B28CB1A.E8226801@mandrakesoft.com>
Date: Thu, 14 Jun 2001 10:32:58 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.6-pre3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
Cc: Tom Gall <tom_gall@vnet.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: Going beyond 256 PCI buses
In-Reply-To: <3B273A20.8EE88F8F@vnet.ibm.com>
		<3B28C6C1.3477493F@mandrakesoft.com> <15144.51504.8399.395200@pizda.ninka.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David S. Miller" wrote:
> 1) Extending the type bus numbers use inside the kernel.
> 
>    Basically how most multi-controller platforms work now
>    is they allocate bus numbers in the 256 bus space as
>    controllers are probed.  If we change the internal type
>    used by the kernel to "u32" or whatever, we expand that
>    available space accordingly.
> 
>    For the lazy, basically go into include/linux/pci.h
>    and change the "unsigned char"s in struct pci_bus into
>    some larger type.  This is mindless work.

Why do you want to make the bus number larger than the PCI bus number
register?

It seems like adding 'unsigned int domain_num' makes more sense, and is
more correct.  Maybe that implies fixing up other code to use a
(domain,bus) pair, but that's IMHO a much better change than totally
changing the interpretation of pci_bus::bus_number...


> 2) Figure out what to do wrt. sys_pciconfig_{read,write}()

3) (tiny issue) Change pci_dev::slot_name such that it includes the
domain number.  This is passed to userspace by SCSI and net drivers as a
way to allow userspace to associate a kernel interface with a bus
device.


> Basically, this 256 bus limit in Linux is a complete fallacy.

yep

Regards,

	Jeff


-- 
Jeff Garzik      | Andre the Giant has a posse.
Building 1024    |
MandrakeSoft     |
