Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <160175-212>; Sun, 14 Mar 1999 14:09:35 -0500
Received: by vger.rutgers.edu id <160061-212>; Sun, 14 Mar 1999 14:09:16 -0500
Received: from mail13.digital.com ([192.208.46.30]:1166 "EHLO mail13.digital.com" ident: "NO-IDENT-SERVICE[2]") by vger.rutgers.edu with ESMTP id <160047-215>; Sun, 14 Mar 1999 14:09:04 -0500
Message-Id: <199903141602.LAA01022@alpha1.estabrook.org>
X-Mailer: exmh version 2.0.2
To: Jakub Jelinek <jj@sunsite.ms.mff.cuni.cz>
Cc: axp-list@redhat.com, debian-alpha@lists.debian.org, linux-kernel@vger.rutgers.edu
From: Jay.Estabrook@digital.com
Subject: Re: > 1GB on alpha. Patch to 1TB? 
In-Reply-To: Your message of Sat, 13 Mar 1999 21:48:45 +0100. <199903132048.VAA11627@sunsite.mff.cuni.cz> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 14 Mar 1999 11:02:18 -0500
Sender: owner-linux-kernel@vger.rutgers.edu


>>> Jakub Jelinek said:
> 
> There is something in the sparc tree, which is used also for sun4c and sun4d
> (where there is only 64MB of DMA per board, so one has to remap DMA areas
> during runtime).
> Besically, each driver before it starts doing dma uses some function which
> translates virtual address + length to dma address and allocates it, then
> after the dma the driver has to release it again.

This is a technique that would work on the Alphas as well, but as noted above,
it *does* require driver modifications to manage the resource correctly.

On Alpha, in addition to the direct-map DMA windows which are currently
used, one can define what we call "scatter-gather" DMA windows. The range of
PCI addresses that fall into one of these windows are re-directed to host
memory via a page table, where the address in a PTE can be *any* page in the
possible installed memory - no bounce buffers needed... :-)
 
> Martin Mares and myself are considering this as part of the new buses
> interface we plan for 2.3. The Ultra port supports even now huge amounts of
> memory, but uses bounce buffers for that. I plan to change it in early 2.3.

Great! Keep us posted with your progress.

--Jay++

-------------------------------------------------------------------------------
  American Non Sequitur Society: we don't make sense, but we do like pizza...

Jay A Estabrook                            Alpha Motherboards - LINUX Project
Compaq Computer Corporation                (508) 841-3241 or (DTN) 237-3241
334 South Street, Shrewsbury, MA 01545     Jay.Estabrook@digital.com
-------------------------------------------------------------------------------





-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
