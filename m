Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289348AbSBEIJg>; Tue, 5 Feb 2002 03:09:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289353AbSBEIJ1>; Tue, 5 Feb 2002 03:09:27 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:2316 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S289348AbSBEIJZ>;
	Tue, 5 Feb 2002 03:09:25 -0500
Message-ID: <3C5F9312.DB8766B9@zip.com.au>
Date: Tue, 05 Feb 2002 00:08:50 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18-pre7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: spider@darkmere.wanfear.com
CC: linux-kernel@vger.kernel.org
Subject: Re: [BUG] Oops booting linux-2.4.18-pre7-ac3
In-Reply-To: <20020205021933.34aff42f.spider@darkmere.wanfear.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Spider wrote:
> 
> This is pretty much the same as "oops booting 2.4.18-pre7-ac3" by "Todd M. Roy" <troy@holstein.com> but I post it as well.
> 
> I'm not subscribed, so if you wish more information (.config, other info on hardware/software installed) please cc' me.
> 
> //Spider
> 
> PCI: PCI BIOS revision 2.10 entry at 0xf1150, last bus=1
> PCI: Using configuration type 1
> PCI: Probing PCI hardware
> PCI: Using IRQ router VIA [1106/0686] at 00:04.0
> PCI: Disabling Via external APIC routing
> PnPBIOS: Found PnP BIOS installation structure at 0xc00fc2b0.
> PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0xc2e0, dseg 0xf0000.
> PnPBIOS: 12 nodes reported by PnP BIOS; 12 recorded by driver.
> PnPBIOS: PNP0c02: ioport range 0xe400-0xe47f has been reserved.
> PnPBIOS: PNP0c02: ioport range 0xe800-0xe83f could not be reserved.
> Linux NET4.0 for Linux 2.4
> Based upon Swansea University Computer Society NET3.039
> Initializing RT netlink socket
> Unable to handle kernel NULL pointer dereference at virtual address 0000002c

Yes, sorry - I didn't test against Alan's pnpbios driver.

The problem is this, in init/main.c:

#ifdef CONFIG_PNPBIOS
    pnpbios_init();
#endif
    ....
    start_context_thread();
    do_initcalls();

pnpbios_init() launches a kernel thread which calls the kernel/user.c
code before the user.c's initcall has had a chance to initialise things.

I've asked Alan to back out the rather unimportant set_user-in-reparent_to_init
fix while we contemplate this.

I suggest you disable the pnpbios driver in kernel config in -ac3.


-
