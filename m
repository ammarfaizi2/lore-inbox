Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132313AbRDMWw2>; Fri, 13 Apr 2001 18:52:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132316AbRDMWwT>; Fri, 13 Apr 2001 18:52:19 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:23739 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S132313AbRDMWwC>;
	Fri, 13 Apr 2001 18:52:02 -0400
Message-ID: <3AD7830D.BD326BFE@mandrakesoft.com>
Date: Fri, 13 Apr 2001 18:51:57 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.3-17mdksmp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Michael Reinelt <reinelt@eunet.at>
Cc: =?iso-8859-1?Q?G=E9rard?= Roudier <groudier@club-internet.fr>,
        Tim Waugh <twaugh@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Multi-function PCI devices
In-Reply-To: <Pine.LNX.4.10.10104071507230.1561-100000@linux.local> <3ACF5E15.2A6E4F3C@eunet.at> <3ACF5FFE.24ECA0CA@mandrakesoft.com> <3AD04DA0.A1BC49B7@eunet.at>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Reinelt wrote:
> 
> Jeff Garzik wrote:
> >
> > > Another (design) question: How will such a driver/module deal with
> > > autodetection and/or devfs? I don't like to specify 'alias /dev/tts/4
> > > netmos', because thats pure junk to me. What about pci hotplugging?
> >
> > pci hotplugging happens pretty much transparently.  When a new device is
> > plugged in, your pci_driver::probe routine is called.  When a new device
> > is removed, your pci_driver::remove routine is called.
> 
> Thats clear to me. But the probe and remove routine can only be called
> if the module is already loaded. My question was: who will load the
> module? (I'll call it 'netmos.o')

typically a hotplug agent, cardmgr in this case.

> If I do a 'modprobe serial', how should the serial driver know that the
> netmos.o should be loaded, too?

cardmgr ideally should load netmos.o, which will automatically pull in
serial.o.

(cardmgr is from the pcmcia-cs package, at
http://pcmcia-cs.sourceforge.net/)

Regards,

	Jeff



-- 
Jeff Garzik       | Sam: "Mind if I drive?"
Building 1024     | Max: "Not if you don't mind me clawing at the dash
MandrakeSoft      |       and shrieking like a cheerleader."
