Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264395AbRF1VMD>; Thu, 28 Jun 2001 17:12:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264415AbRF1VLx>; Thu, 28 Jun 2001 17:11:53 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:41367 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S264395AbRF1VLi>;
	Thu, 28 Jun 2001 17:11:38 -0400
Message-ID: <3B3B9DAF.56119F88@mandrakesoft.com>
Date: Thu, 28 Jun 2001 17:12:15 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.6-pre5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: =?iso-8859-1?Q?G=E9rard?= Roudier <groudier@club-internet.fr>
Cc: tom_gall@vnet.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: RFC: Changes for PCI
In-Reply-To: <20010628223210.Q1578-100000@>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gérard Roudier wrote:
> The driver checks against PCI bus+dev+func in 2 situations:
> 
> 1) To apply the boot order that user can set up in the controller NVRAMs.
> 2) To detect buggy double reporting of the same device by the kernel PCI
>    code (this made lot of troubles at some time).

Cool.  The premise of the thread was that you merely were checking for
uniqueness, not order.  That changes our answer...


> The great bug is to invent useless abstractions that don't match reality.
> Such brain masturbation leads to confusion (hence subtle bugs)  and
> useless software bloatage (thus _real_ resource wastage).
> 
> If we want to handle _real_ PCI bus domains, we just have to add a domain
> number to identify a _real_ PCI device. Anything that wants to hide such
> reality in some opaque data looks like brain masturbation to me.

I think all of us agree on this:  in 2.5, our solution is to have a
system domain number, which increases from zero each time you add sbus,
pci bus, isa bus, etc.

For 2.4, non-x86 arches first had to deal with PCI domains, so the
solution was to stick "arch-specific data" into pci_dev->sysdata, which
in some cases was the PCI domain number.

So, you have an ugly solution in drivers for 2.4 if you need to know PCI
domain for what reason, and a clean solution in 2.5.

	Jeff


-- 
Jeff Garzik      | Andre the Giant has a posse.
Building 1024    |
MandrakeSoft     |
