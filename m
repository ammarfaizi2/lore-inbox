Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310190AbSB1Wj2>; Thu, 28 Feb 2002 17:39:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310182AbSB1Whg>; Thu, 28 Feb 2002 17:37:36 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:41991 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S310179AbSB1WdK>;
	Thu, 28 Feb 2002 17:33:10 -0500
Message-ID: <3C7EB026.52ED48B3@mandrakesoft.com>
Date: Thu, 28 Feb 2002 17:33:10 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19pre1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Rui Sousa <rui.p.m.sousa@clix.pt>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        German Gomez Garcia <german@piraos.com>,
        "=?iso-8859-1?Q?Jos=E9?= Carlos Monteiro" <jcm@netcabo.pt>,
        linux-kernel@vger.kernel.org,
        emu10k1-devel <emu10k1-devel@lists.sourceforge.net>,
        Steve Stavropoulos <steve@math.upatras.gr>,
        Daniel Bertrand <d.bertrand@ieee.org>, dledford@redhat.com
Subject: Re: [Emu10k1-devel] Re: Emu10k1 SPDIF passthru doesn't work if
In-Reply-To: <Pine.LNX.4.44.0202282042150.1215-100000@sophia-sousar2.nice.mindspeed.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rui Sousa wrote:
> 
> On Wed, 27 Feb 2002, Alan Cox wrote:
> 
> It's true dma_addr_t does change from u32 to u64 and we do thinks like:
> 
> (32 bit pci register) = cpu_to_le32(dma_handle)
> 
> What is the correct way of doing this?
> 
> (32 bit pci register) = cpu_to_le32((u32)dma_handle)

If you only have 32 bits, then I presume 64-bit DMA isn't supported.

So, (1) never pass more than 0xffffffff to pci_set_dma_mask, and (2)
just truncate dma_addr_t (addr & 0xffffffff) so that you only read the
low 32-bits, always.

	Jeff



-- 
Jeff Garzik      | "UNIX enhancements aren't."
Building 1024    |           -- says /usr/games/fortune
MandrakeSoft     |
