Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130206AbRCCBJR>; Fri, 2 Mar 2001 20:09:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130208AbRCCBJH>; Fri, 2 Mar 2001 20:09:07 -0500
Received: from pizda.ninka.net ([216.101.162.242]:55941 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S130206AbRCCBIw>;
	Fri, 2 Mar 2001 20:08:52 -0500
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15008.17440.670230.389557@pizda.ninka.net>
Date: Fri, 2 Mar 2001 17:08:48 -0800 (PST)
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: <linux-kernel@vger.kernel.org>, <linuxppc-dev@lists.linuxppc.org>
Subject: Re: The IO problem on multiple PCI busses
In-Reply-To: <19350125045659.29820@mailhost.mipsys.com>
In-Reply-To: <15006.45225.631466.969004@pizda.ninka.net>
	<19350125045659.29820@mailhost.mipsys.com>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Benjamin Herrenschmidt writes:
 > There is still the need, in the ioctl we use the "select" what need to be
 > mapped by the next mmap, to ask for the "legacy IO range of the bus where
 > the card reside" (if it exist of course). That would be the 0-64k (or less,
 > actually a couple of pages would probably be enough) that generates IO cycles
 > in the "low" addresses used for VGA registers on the card.

As I've stated in another email, this is perfectly fine and is
precisely the kind of thing implied by my original proposal
in this thread.

You can even have arch-specific "next mmap is" ioctl values to do
"special things".

The generic part of the ioctl()/mmap() bits the PCI driver will have
added won't care about these ioctl's all that much, the
include/asm/pcimmap.h header will deal with all such details.  This
header is also where the physical address and the actual creation of
the page table mappings will occur.  The generic PCI code will only
provide the skeletal parts of the mmap() method and call into the
arch-specific hooks coded in asm/pcimmap.h

Later,
David S. Miller
davem@redhat.com
