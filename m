Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266978AbTAITpI>; Thu, 9 Jan 2003 14:45:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266979AbTAITpI>; Thu, 9 Jan 2003 14:45:08 -0500
Received: from palrel13.hp.com ([156.153.255.238]:35806 "HELO palrel13.hp.com")
	by vger.kernel.org with SMTP id <S266978AbTAITpH>;
	Thu, 9 Jan 2003 14:45:07 -0500
Date: Thu, 9 Jan 2003 11:52:31 -0800
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Paul Mackerras <paulus@samba.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>, davidm@hpl.hp.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       greg@kroah.com
Subject: Re: [patch 2.5] 2-pass PCI probing, generic part
Message-ID: <20030109195231.GB16698@cup.hp.com>
References: <1041942820.20658.2.camel@irongate.swansea.linux.org.uk> <Pine.LNX.4.44.0301070942440.1913-100000@home.transmeta.com> <20030109204626.A2007@jurassic.park.msu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030109204626.A2007@jurassic.park.msu.ru>
User-Agent: Mutt/1.4i
From: grundler@cup.hp.com (Grant Grundler)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 09, 2003 at 08:46:26PM +0300, Ivan Kokshaysky wrote:
> As discussed, this patch splits PCI probing into 2 phases.

Like david, both parts of the patch look good but i haven't tested
on either parisc or ia64. I don't have time right now to work on
2.5.x issues :^(

I looked at 2.5.54 to check if everything was ok and found
another nit:
    grundler <510>fgrep pci_scan_bus *.[ch]
    probe.c:struct pci_bus * __devinit pci_scan_bus_parented(struct device *parent, int bus, struct pci_ops *ops, void *sysdata)
    probe.c:EXPORT_SYMBOL(pci_scan_bus);

and :
    grundler <514>fgrep pci_scan_bus include/linux/*h
    include/linux/pci.h:struct pci_bus *pci_scan_bus_parented(struct device *parent, int bus, struct pci_ops *ops, void *sysdata);
    include/linux/pci.h:static inline struct pci_bus *pci_scan_bus(int bus, struct pci_ops *ops, void *sysdata)
    include/linux/pci.h:    return pci_scan_bus_parented(NULL, bus, ops, sysdata);

Can the EXPORT_SYMBOL(pci_scan_bus) be removed now?


BTW, thanks to whoever introduced pci_scan_bus_parented().
It's exactly what parisc code needed (lba_pci.c and dino.c use it).

I think just go ahead with your patches and we'll fix up the arch specific
stuff to follow. I'm convinced it's the right direction.

thanks,
grant
