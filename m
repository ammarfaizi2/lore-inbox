Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263032AbRFNOmx>; Thu, 14 Jun 2001 10:42:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263033AbRFNOmn>; Thu, 14 Jun 2001 10:42:43 -0400
Received: from pizda.ninka.net ([216.101.162.242]:24752 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S263032AbRFNOmc>;
	Thu, 14 Jun 2001 10:42:32 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15144.52565.566355.291642@pizda.ninka.net>
Date: Thu, 14 Jun 2001 07:42:29 -0700 (PDT)
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: Tom Gall <tom_gall@vnet.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: Going beyond 256 PCI buses
In-Reply-To: <3B28CB1A.E8226801@mandrakesoft.com>
In-Reply-To: <3B273A20.8EE88F8F@vnet.ibm.com>
	<3B28C6C1.3477493F@mandrakesoft.com>
	<15144.51504.8399.395200@pizda.ninka.net>
	<3B28CB1A.E8226801@mandrakesoft.com>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Jeff Garzik writes:
 > Why do you want to make the bus number larger than the PCI bus number
 > register?

This isn't it.  What I'm trying to provoke thought on is
"is there a way to make mindless apps using these syscalls
work transparently"

I think the answer is no.  Apps should really fetch info out
of /proc/bus/pci and use the controller ioctl.

But someone could surprise me :-)

 > It seems like adding 'unsigned int domain_num' makes more sense, and is
 > more correct.  Maybe that implies fixing up other code to use a
 > (domain,bus) pair, but that's IMHO a much better change than totally
 > changing the interpretation of pci_bus::bus_number...

Correct, I agree.  But I don't even believe we should be sticking
the domain thing into struct pci_bus.

It's a platform thing.  Most platforms have a single domain, so why
clutter up struct pci_bus with this value?  By this reasoning we could
say that since it's arch-specific, this stuff belongs in sysdata or
wherever.

And this is what is happening right now.  So in essence, the work is
done :-)  The only "limiting factor" is that x86 doesn't support
multiple domains as some other platforms do.  So all these hot-plug
patches just need to use domains properly, and perhaps add domain
support to X86 when one of these hot-plug capable controllers are
being used.

 > > 2) Figure out what to do wrt. sys_pciconfig_{read,write}()
 > 
 > 3) (tiny issue) Change pci_dev::slot_name such that it includes the
 > domain number.  This is passed to userspace by SCSI and net drivers as a
 > way to allow userspace to associate a kernel interface with a bus
 > device.

Sure.  It's an address and the domain is part of the address.

Later,
David S. Miller
davem@redhat.com

