Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315261AbSEBSel>; Thu, 2 May 2002 14:34:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315256AbSEBSek>; Thu, 2 May 2002 14:34:40 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:56545 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S315261AbSEBSei>; Thu, 2 May 2002 14:34:38 -0400
Date: Thu, 02 May 2002 12:31:52 -0700
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: Andrea Arcangeli <andrea@suse.de>
cc: Daniel Phillips <phillips@bonn-fries.net>,
        Russell King <rmk@arm.linux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Bug: Discontigmem virt_to_page() [Alpha,ARM,Mips64?]
Message-ID: <143790000.1020367912@flay>
In-Reply-To: <20020502184037.J11414@dualathlon.random>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> You don't need any additional common code abstraction to make virtual
> address 3G+256G to point to physical address 1G as in my example above,
> after that you're free to put the physical ram between 1G and 1G+256M
> into the zone normal of node 1 and the stuff should keep working but
> with zone-normal spread in more than one node.  You just have full
> control on virt_to_page, pci_map_single, __va.  Actually it may be as
> well cleaner to just let the arch define page_address() when
> discontigmem is enabled (instead of hacking on top of __va), that's a
> few liner. (the only true limit you have is on the phys ram above 4G,
> that cannot definitely go into zone-normal regardless if it belongs to a
> direct mapping or not because of pci32 API)

The thing that's special about ZONE_NORMAL is that it's permanently
mapped into kernel virtual address space, so you *cannot* put memory
in other nodes into ZONE_NORMAL without changing the mapping
between physical to virtual memory to a non 1-1 mapping.

No, you don't need to call changing that mapping "CONFIG_NONLINEAR",
but that's basically what the bulk of Dan's patch does, so I think we should 
steal it with impunity ;-) 

M.


