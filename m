Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129032AbRBNG2o>; Wed, 14 Feb 2001 01:28:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130258AbRBNG2e>; Wed, 14 Feb 2001 01:28:34 -0500
Received: from mandrakesoft.mandrakesoft.com ([216.71.84.35]:32524 "EHLO
	mandrakesoft.mandrakesoft.com") by vger.kernel.org with ESMTP
	id <S129032AbRBNG2X>; Wed, 14 Feb 2001 01:28:23 -0500
Date: Wed, 14 Feb 2001 00:27:53 -0600 (CST)
From: Jeff Garzik <jgarzik@mandrakesoft.mandrakesoft.com>
To: "Zink, Dan" <Dan.Zink@compaq.com>
cc: Tim Wright <timw@splhi.com>, Adam Lackorzynski <al10@inf.tu-dresden.de>,
        Jan-Benedict Glaw <jbglaw@lug-owl.de>, linux-kernel@vger.kernel.org
Subject: RE: PCI bridge handling 2.4.0-test10 -> 2.4.2-pre3
In-Reply-To: <8C91B010B3B7994C88A266E1A72184D3116FD6@cceexc19.americas.cpqcorp.net>
Message-ID: <Pine.LNX.3.96.1010214001811.24061I-100000@mandrakesoft.mandrakesoft.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Feb 2001, Zink, Dan wrote:
> Does it make sense to try and keep up with the latest and greatest in
> chipsets
> when there is a hardware independent way of doing things?  You may be able
> to
> get information on current chipsets, but every time something changes, the
> kernel may be broken for a time.  If we rely on the BIOS, the kernel can
> stay
> out of the chipset information race.  I understand the reluctance to depend
> on BIOS in general but isn't it safe to say that systems using the
> ServerWorks
> chipsets in question are likely servers with a non-broken BIOS?
> 
> I can tell you that if the BIOS doesn't report this stuff right on a
> ProLiant
> server, it would never make it out the door.  It would break too many things
> to go unnoticed.  From this standpoint, the kernel is less likely to break
> if
> it relies on the BIOS rather than assuming some particular chipset design
> that can easily change in the future.  This is a fundamental reason for the
> BIOS's existence.

It's common knowledge that Linux is often better for hardware testing
than Microsoft's pitiful ACT software.  Intel and other companies have
discovered hardware flaws that Linux exposes which all the Windows
(and ACT) testing does not.  (see early P4's...)  Similarly, most
BIOS out there work wonderfully with Windows but often have quirks
with Linux.  An overall policy of BIOS independence minimizes if not
eliminates the chances of such quirks affecting Linux users.

Getting a vendor to fix a broken BIOS is like trying to get a reluctant
cow out of the barn:  oftimes is just doesn't happen, especially if
it is a Linux-only problem.  Toshiba laptops have had broken ACPI
tables for ages, but I have yet to see any BIOS updates regardless
of the number of reports sent to Toshiba.

Now, that said, in x86 land, we actually -do- allow the BIOS to
setup the PCI bus for us, and for the most part, we leave that setup
completely alone.  grep for 'pcibios_assign_all_busses'...  and note
it is defined to zero for x86, and 1 for alpha.

Finally, minimizing BIOS dependencies is also important for applications
like linuxbios -- an embedded firmware that initializes the CPU and
DRAM, and then passes control to a Linux kernel to do the rest.

Regards,

	Jeff



