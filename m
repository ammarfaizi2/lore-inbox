Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264424AbRF1VNn>; Thu, 28 Jun 2001 17:13:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264423AbRF1VNf>; Thu, 28 Jun 2001 17:13:35 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:400 "EHLO e33.bld.us.ibm.com")
	by vger.kernel.org with ESMTP id <S264424AbRF1VNX>;
	Thu, 28 Jun 2001 17:13:23 -0400
Message-ID: <3B3B9D83.F95D4496@vnet.ibm.com>
Date: Thu, 28 Jun 2001 21:11:31 +0000
From: Tom Gall <tom_gall@vnet.ibm.com>
Reply-To: tom_gall@vnet.ibm.com
Organization: IBM
X-Mailer: Mozilla 4.61 [en] (X11; U; Linux 2.2.10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: =?iso-8859-1?Q?G=E9rard?= Roudier <groudier@club-internet.fr>
CC: Jeff Garzik <jgarzik@mandrakesoft.com>, linux-kernel@vger.kernel.org
Subject: Re: RFC: Changes for PCI
In-Reply-To: <20010628223210.Q1578-100000@>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gérard Roudier wrote:
> 
> On Wed, 27 Jun 2001, Jeff Garzik wrote:
> 
> > Tom Gall wrote:
> > > Well you have device drivers like the symbios scsi driver for instance that
> > > tries to determine if it's seen a card before. It does this by looking at the
> > > bus,dev etc numbers...  It's quite reasonable for two different scsi cards to be
> > > on the same bus number, same dev number etc yet they are in different PCI
> > > domains.
> > >
> > > Is this a device driver bug or feature?
> >
> > I hesitate to call it a device driver bug, because that was likely the
> > best decision Gerard could make at the time.
> >
> > However, I think the driver (only going by your description) would be
> > more correct to use a pointer to struct pci_dev.  We have a token in the
> > kernel that is guaranteed 100% unique to any given PCI device:  the
> > pointer to its struct pci_dev.
> 
> The driver checks against PCI bus+dev+func in 2 situations:
> 
> 1) To apply the boot order that user can set up in the controller NVRAMs.
> 2) To detect buggy double reporting of the same device by the kernel PCI
>    code (this made lot of troubles at some time).

Thanks much for the clarification. Do you still battle buggy double reporting?
Has this been fixed? Is it a bug on some specific architecture?
 
> The great bug is to invent useless abstractions that don't match reality.
> Such brain masturbation leads to confusion (hence subtle bugs)  and
> useless software bloatage (thus _real_ resource wastage).

Agreed. (A couple of my posts last night didn't make it through... appears that
us.ibm.com isn't set up entirely right for ENC)

> If we want to handle _real_ PCI bus domains, we just have to add a domain
> number to identify a _real_ PCI device. Anything that wants to hide such
> reality in some opaque data looks like brain masturbation to me.

Again also agreed. Now I'm REALLY anxious for 2.5 8-)

>   Gérard.

Regards,

Tom

-- 
Tom Gall - PPC64 Maintainer      "Where's the ka-boom? There was
Linux Technology Center           supposed to be an earth
(w) tom_gall@vnet.ibm.com         shattering ka-boom!"
(w) 507-253-4558                 -- Marvin Martian
(h) tgall@rochcivictheatre.org
http://www.ibm.com/linux/ltc/projects/ppc
