Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272544AbRH3XHE>; Thu, 30 Aug 2001 19:07:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272546AbRH3XGz>; Thu, 30 Aug 2001 19:06:55 -0400
Received: from pizda.ninka.net ([216.101.162.242]:51859 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S272543AbRH3XGo>;
	Thu, 30 Aug 2001 19:06:44 -0400
Date: Thu, 30 Aug 2001 16:06:51 -0700 (PDT)
Message-Id: <20010830.160651.75218604.davem@redhat.com>
To: kraxel@bytesex.org
Cc: linux-kernel@vger.kernel.org
Newsgroups: lists.linux.kernel
Subject: Re: [UPDATE] 2.4.10-pre2 PCI64, API changes README
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <slrn9oscm3.4o6.kraxel@bytesex.org>
In-Reply-To: <20010829.181852.98555095.davem@redhat.com>
	<slrn9oscm3.4o6.kraxel@bytesex.org>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Gerd Knorr <kraxel@bytesex.org>
   Date: 30 Aug 2001 12:34:11 GMT

   These days I tried what happens if I start a PCI->PCI transfer this way:
   Open the framebuffer device, mmap the framebuffer memory, then ask bttv
   to blit one video frame to the framebuffer by passing the pointer of the
   fb mapping to bttv's read() function.
   
   Didn't work, looks like map_user_buf can deal with main memory only, but
   not with I/O memory.  It gave me NULL pointers in the iobuf page list.

Right.
   
   Is there any way (portable) way to deal with this situation?  I'd expect
   I can get the physical address for the I/O memory by walking the page
   tables, but then I'd have to translate that to a bus address somehow.
   How PCI->PCI transfers are handled on architectures with a iommu?  Do I
   need a iommu entry for them?

Not currently.  Note that just using that physical address you'd find
in the page tables might not even work on many platforms.  And
anyways, the DMA-mapping.txt document is pretty clear that of what
types of memory can be passed in to get DMA mappings for.

You _REALLY_ need to know the PCI device in question before you can
properly and portably set up a PCI peer to peer transfer.  We have no
API for this yet though.

When such an API would be created, it would take two PCI_DEV structs,
and it would possibly fail.  On sparc64 for example, it is not
possible to PCI peer-to-peer DMA between two PCI devices behind
different PCI controllers, it simply doesn't work.

Later,
David S. Miller
davem@redhat.com
