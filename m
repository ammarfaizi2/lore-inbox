Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266536AbRGDICT>; Wed, 4 Jul 2001 04:02:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266538AbRGDICK>; Wed, 4 Jul 2001 04:02:10 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:43280 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S266536AbRGDICA>;
	Wed, 4 Jul 2001 04:02:00 -0400
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15170.52297.374186.21895@tango.paulus.ozlabs.org>
Date: Wed, 4 Jul 2001 17:56:57 +1000 (EST)
To: mdaljeet@in.ibm.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: virt_to_bus and virt_to_phys on Apple G4 target
In-Reply-To: <CA256A7E.0020F52C.00@d73mta01.au.ibm.com>
In-Reply-To: <CA256A7E.0020F52C.00@d73mta01.au.ibm.com>
X-Mailer: VM 6.75 under Emacs 20.7.2
Reply-To: paulus@samba.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mdaljeet@in.ibm.com writes:

> I am running linux 2.4.2 on Apple G4 machine. I think the 'PCI bus
> addresses' and 'physical addresses' are same on this architecture. I

They are the same on an Apple G4 but not necessarily on other PowerPC
machines.  It depends on the PCI host bridge implementation.

> expected the two be different but according to asm/io.h 'virt_to_bus(addr)
> = virt_to_phys(addr) + PCI_DRAM_OFFSET'. I printed the value of
> 'PCI_DRAM_OFFSET' and that come out to be zero. Is this correct?

Yes, for an Apple G4.

> If I somehow get the physical address of a user space buffer in a module
> and take this as a PCI bus address, will I be able to do DMA properly?

Yes, on an Apple G4.  If you use virt_to_bus then it should work on
all PowerPC machines that I know of (that run 32-bit PPC/Linux).  But
as Dave points out, you should use the interfaces described in
Documentation/DMA-mapping.txt instead if at all possible.  It's quite
possible that virt_to_bus will be removed during 2.5.x development.

Paul.
