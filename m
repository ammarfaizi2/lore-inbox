Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131868AbRCXXaV>; Sat, 24 Mar 2001 18:30:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131874AbRCXXaB>; Sat, 24 Mar 2001 18:30:01 -0500
Received: from inet-smtp3.oracle.com ([205.227.43.23]:30137 "EHLO
	inet-smtp3.oracle.com") by vger.kernel.org with ESMTP
	id <S131868AbRCXX3x>; Sat, 24 Mar 2001 18:29:53 -0500
Message-ID: <3ABD2C2A.7333D132@oracle.com>
Date: Sun, 25 Mar 2001 00:22:18 +0100
From: Alessandro Suardi <alessandro.suardi@oracle.com>
Organization: Oracle Support Services
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.3-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Tom Sightler <ttsig@tuxyturvy.com>
CC: linux-kernel@vger.kernel.org, Jeff Garzik <jgarzik@mandrakesoft.com>,
        serial-pci-info@lists.sourceforge.net
Subject: Re: [PATCH] Fix for serial.c to work with Xircom Cardbus Ethernet+Modem
In-Reply-To: <012301c0b357$3d29cc50$1601a8c0@zeusinc.com> <3ABBD639.12BE1035@oracle.com> <001e01c0b41d$1665de80$1601a8c0@zeusinc.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tom Sightler wrote:
> 
[snip]
> OK, can you try this patch?  It's very simple, and is probably not the
> correct fix (the correct fix is probably to add the Xircom card to the
> supported PCI table), but it works for me.  I'm not sure why the generic pci
> serial code counts the number of iomem regions and only uses it if it has
> exactly 0 or 1, but the Xircom has 2 iomem regions so the generic code fails
> to use it.  The following change relaxes the generic code to allow for up to
> 2 iomem regions on a PCI serial device.  I have no idea what the side
> effects would be to this change, but it makes my Xircom work again and that
> was my goal.  If I can help someone fix this correctly let me know what you
> need.

[snipped patch]

It seems something changed in 2.4.3-pre7 (against which I applied your
 patch) so that it doesn't make a difference. On startup I now get this,
 which I am CC:ing as per printk to serial-pci-info@lists.sourceforge.net

Mar 24 23:59:05 princess cardmgr[374]: initializing socket 1
Mar 24 23:59:05 princess kernel:   got res[10c04000:10c07fff] for resource 6 of PCI device 115d:0103
Mar 24 23:59:05 princess cardmgr[374]: socket 1: Xircom CBEM56G-100 CardBus 10/100 Ethernet + 56K Modem
Mar 24 23:59:05 princess kernel: PCI: Enabling device 05:00.1 (0000 -> 0003)
Mar 24 23:59:05 princess kernel: Redundant entry in serial pci_table.  Please send the output of
Mar 24 23:59:05 princess kernel: lspci -vv, this message (4445,259,4445,4481)
Mar 24 23:59:05 princess kernel: and the manufacturer and name of serial board or modem board
Mar 24 23:59:05 princess kernel: to serial-pci-info@lists.sourceforge.net.
Mar 24 23:59:05 princess kernel: register_serial(): autoconfig failed

The card is a Xircom RBEM56G-100, despite what the card advertises.

(in case you wonder, cardmgr is from pcmcia_cs-3.1.25).


Thanks & ciao,

--alessandro      <alessandro.suardi@oracle.com> <asuardi@uninetcom.it>

Linux:  kernel 2.2.19p17/2.4.3p6 glibc-2.2 gcc-2.96-69 binutils-2.11.90.0.1
Oracle: Oracle8i 8.1.7.0.1 Enterprise Edition for Linux
motto:  Tell the truth, there's less to remember.
