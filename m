Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276793AbRJIMLM>; Tue, 9 Oct 2001 08:11:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276950AbRJIMLD>; Tue, 9 Oct 2001 08:11:03 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:10504 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S276840AbRJIMK4>; Tue, 9 Oct 2001 08:10:56 -0400
Subject: Re: [PATCH] change name of rep_nop
To: kaos@ocs.com.au (Keith Owens)
Date: Tue, 9 Oct 2001 13:15:49 +0100 (BST)
Cc: benh@kernel.crashing.org (Benjamin Herrenschmidt),
        linux-kernel@vger.kernel.org
In-Reply-To: <30619.1002627002@ocs3.intra.ocs.com.au> from "Keith Owens" at Oct 09, 2001 09:30:02 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15qvnZ-0003xo-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> consider modules as well as the kernel.  modutils 2.4.8 added support
> for ppc archdata to allow dynamic patching of modules using the ftr
> data.  There also has to be code in kernel/module.c::module_arch_init()
> to take the archdata and do whatever is required.

I am considering the possibility for the x86 ppro fix but firstly I want
to be sure the spin_unlock change is necessary. The PCI one is much less
of an impact since we don't go around doing it all the time.

> If anybody starts doing dynamic patching, please let me know so I can
> handle modutils and module_arch_init().

For testing purposes it won't be needed thankfully - a non nop patched
module might just be a tiny bit slower. 

Anyway firstly I have to reasonably show PPro errata 66/92 are what is
causing the odd weird ppro crash (the evidence so far is the xchg
based unlock helps). The WC v UC misordered store one is a proven case,
as is the 0x70000000->0x7003FFFF wbinvd hang which turns up on some ppro
boxes that never got the bios E820 fixup

Alan
