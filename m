Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316538AbSFJE2n>; Mon, 10 Jun 2002 00:28:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316548AbSFJE2m>; Mon, 10 Jun 2002 00:28:42 -0400
Received: from pizda.ninka.net ([216.101.162.242]:33461 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S316538AbSFJE2l>;
	Mon, 10 Jun 2002 00:28:41 -0400
Date: Sun, 09 Jun 2002 21:24:22 -0700 (PDT)
Message-Id: <20020609.212422.70462475.davem@redhat.com>
To: Oliver.Neukum@lrz.uni-muenchen.de
Cc: roland@topspin.com, linux-kernel@vger.kernel.org
Subject: Re: PCI DMA to small buffers on cache-incoherent arch
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <200206090640.g596e6X14829@fachschaft.cup.uni-muenchen.de>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Oliver Neukum <Oliver.Neukum@lrz.uni-muenchen.de>
   Date: Sun, 9 Jun 2002 08:45:49 +0200

   Am Sonntag, 9. Juni 2002 07:29 schrieb David S. Miller:
   >    From: Roland Dreier <roland@topspin.com>
   >    Date: 08 Jun 2002 18:26:12 -0700
   >
   >    Just to make sure I'm reading this correctly, you're saying that as
   >    long as a buffer is OK for DMA, it should be OK to use a
   >    sub-cache-line chunk as a DMA buffer via pci_map_single(), and
   >    accessing the rest of the cache line should be OK at any time before,
   >    during and after the DMA.
   >
   > Yes.
   
   Does this mean that this piece of memory does have to be declared
   uncacheable until DMA is finished ?
   How else do you solve th problem of validity during DMA and
   especially after DMA ?

You flush either before/after depending upon whether the cpu caches
are writeback in nature or not, and the cpu is not allowed to touch
those addresses while the device is doing the DMA.
