Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262127AbREPXOm>; Wed, 16 May 2001 19:14:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262129AbREPXOc>; Wed, 16 May 2001 19:14:32 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:9185 "HELO havoc.gtf.org")
	by vger.kernel.org with SMTP id <S262127AbREPXOW>;
	Wed, 16 May 2001 19:14:22 -0400
Message-ID: <3B0309CB.1346D25F@mandrakesoft.com>
Date: Wed, 16 May 2001 19:14:19 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.5-pre2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jonathan Lundell <jlundell@pobox.com>
Cc: "Khachaturov, Vassilii" <Vassilii.Khachaturov@comverse.com>,
        LINUX Kernel <linux-kernel@vger.kernel.org>
Subject: Re: ((struct pci_dev*)dev)->resource[...].start
In-Reply-To: <6B1DF6EEBA51D31182F200902740436802678ED4@mail-in.comverse-in.com>
	 <3B02F30F.5D05C77E@mandrakesoft.com> <p05100306b728b73efd94@[10.128.7.49]>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jonathan Lundell wrote:
> 
> At 5:37 PM -0400 2001-05-16, Jeff Garzik wrote:
> >This is not a safe assumption, because the OS may reprogram the PCI BARs
> >at certain times.  The rule is:  ALWAYS read from dev->resource[] unless
> >you are a bus driver (PCI bridges, for example, need to assign
> >resources).
> 
> Would you please elaborate? If I understand what you're saying, you
> can't rely on the "pointer" returned by ioremap() because the OS
> might reprogram the relevant BAR out from under you. So one would
> need to know: when does a driver have to re-ioremap() due to the BAR
> having been (potentially) changed? I'd expect the answer to be: for
> all practical purposes never.

no-no-no.  I DON'T mean that OS will reprogram the BARs underneath you.

Only that it is the responsibility of the OS to program the BARs, and
that you should be getting the BAR info out of dev->resource[].

Note only does this make the code much cleaner, but this gives us a lot
more flexibility about when and how we program the PCI bus.  The PCI
driver only needs to know the location and size of the region it needs
to access.  If the OS, in the future, has to support some weird IOMMU or
PCI mapping capabilities, we don't have to go through and change all the
drivers which are suddenly broken by this new hardware... we just change
it in one canonical place: the PCI core.  (at this point the lecture
turns into why APIs exist and should be used, and it gets more boring
from there...)

-- 
Jeff Garzik      | Game called on account of naked chick
Building 1024    |
MandrakeSoft     |
