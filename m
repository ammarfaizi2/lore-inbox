Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132540AbRDHLij>; Sun, 8 Apr 2001 07:38:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132541AbRDHLi3>; Sun, 8 Apr 2001 07:38:29 -0400
Received: from mlist.austria.eu.net ([193.81.83.3]:17382 "EHLO
	hausmasta.austria.eu.net") by vger.kernel.org with ESMTP
	id <S132540AbRDHLiO>; Sun, 8 Apr 2001 07:38:14 -0400
Message-ID: <3AD04DA0.A1BC49B7@eunet.at>
Date: Sun, 08 Apr 2001 13:38:08 +0200
From: Michael Reinelt <reinelt@eunet.at>
Organization: netWorks
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@mandrakesoft.com>
CC: =?iso-8859-1?Q?G=E9rard?= Roudier <groudier@club-internet.fr>,
        Tim Waugh <twaugh@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Multi-function PCI devices
In-Reply-To: <Pine.LNX.4.10.10104071507230.1561-100000@linux.local> <3ACF5E15.2A6E4F3C@eunet.at> <3ACF5FFE.24ECA0CA@mandrakesoft.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-AntiVirus: OK (checked by AntiVir Version 6.6.0.12)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> 
> > Another (design) question: How will such a driver/module deal with
> > autodetection and/or devfs? I don't like to specify 'alias /dev/tts/4
> > netmos', because thats pure junk to me. What about pci hotplugging?
> 
> pci hotplugging happens pretty much transparently.  When a new device is
> plugged in, your pci_driver::probe routine is called.  When a new device
> is removed, your pci_driver::remove routine is called.

Thats clear to me. But the probe and remove routine can only be called
if the module is already loaded. My question was: who will load the
module? (I'll call it 'netmos.o')

devfs in its standard configuration knows about loading serial.o or
parport.o when /dev/tts/* or /dev/parport/* is accessed. Some other
module loads are triggered by module dependancies (e.g. lp.o requires
parport.o)

If I do a 'modprobe serial', how should the serial driver know that the
netmos.o should be loaded, too?

There is a file called 'modules.pcimap', which contains modules for
specific PCI devices. That's how hotplugging could detect that there's a
netmos card and that netmos.o should be loaded. That looks clean to me,
but I'm not shure if this sort of PCI hotplugging is already
implemented.

bye, Michael

-- 
netWorks       	                                  Vox: +43 316  692396
Michael Reinelt                                   Fax: +43 316  692343
Geisslergasse 4					  GSM: +43 676 3079941
A-8045 Graz, Austria			      e-mail: reinelt@eunet.at
