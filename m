Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132636AbRDGLeN>; Sat, 7 Apr 2001 07:34:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132633AbRDGLeD>; Sat, 7 Apr 2001 07:34:03 -0400
Received: from endjinn.austria.eu.net ([193.81.13.2]:25477 "EHLO
	relay2.austria.eu.net") by vger.kernel.org with ESMTP
	id <S132628AbRDGLdx>; Sat, 7 Apr 2001 07:33:53 -0400
Message-ID: <3ACEFB05.C9C0AB3C@eunet.at>
Date: Sat, 07 Apr 2001 13:33:25 +0200
From: Michael Reinelt <reinelt@eunet.at>
Organization: netWorks
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@mandrakesoft.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Multi-function PCI devices
In-Reply-To: <3ACECA8F.FEC9439@eunet.at> <3ACED679.7E334234@mandrakesoft.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-AntiVirus: OK (checked by AntiVir Version 6.6.0.12)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> 
> Michael Reinelt wrote:
> > basically an extension of the pci id tables; and I hope it's in the
> > queue for the official kernel.
> 
> Where is this patch available?  I haven't heard of an extension to the
> pci id tables, so I wonder if it's really in the queue for the official
> kernel.

The patches went to Jens Maurer (pci_ids.h), Theodore Y. Ts'o (serial.c
and pci_ids.h) and Tim Waugh (parport_pc.c and pci_ids.h).

Well, and 'extension' may be the wrong word. I just added entries to
pci_ids.h and to the detection tables in parport_pc.c and serial.c

> > pci_announce_device() will be called only if there's no other driver
> > claiming the device. This explains why either the parallel or the serial
> > port will be detected: The first driver loaded will see the device, the
> > next drivers won't.

> There is no need to register more than one driver per PCI device -- just
> create a PCI driver whose probe routine registers serial and parallel,
> and whose remove routine unregisters same.

This means create a new module, which does the detection and uses
serial.c and parport_pc.c? I could do this (at least try to :-), but I'd
need some help here. I'm not a kernel hacker, and don't know much about
the pci code, module dependencies, driver tables, hotplugging and all
that stuff. If someone could provide a small sample (or skeleton) code
for this, I'd try my best....

On the other hand, how should the serial and parallel driver detect the
netmos card, if it's a independant module? How could this interfere with
devfs? How should devfsd know if it should load serial.o or netmos.o?

Adding PCI entries to both serial.c and parport_pc.c was that easy....

bye, Michael

-- 
netWorks       	                                  Vox: +43 316  692396
Michael Reinelt                                   Fax: +43 316  692343
Geisslergasse 4					  GSM: +43 676 3079941
A-8045 Graz, Austria			      e-mail: reinelt@eunet.at
