Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261361AbSI3Uen>; Mon, 30 Sep 2002 16:34:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261363AbSI3Uen>; Mon, 30 Sep 2002 16:34:43 -0400
Received: from pizda.ninka.net ([216.101.162.242]:25780 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S261361AbSI3Uem>;
	Mon, 30 Sep 2002 16:34:42 -0400
Date: Mon, 30 Sep 2002 13:33:01 -0700 (PDT)
Message-Id: <20020930.133301.83692002.davem@redhat.com>
To: alan@lxorguk.ukuu.org.uk
Cc: perex@suse.cz, jgarzik@pobox.com, linux-kernel@vger.kernel.org,
       alan@redhat.com
Subject: Re: [PATCH] ALSA update [6/10] - 2002/07/20
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <1033390451.16337.33.camel@irongate.swansea.linux.org.uk>
References: <Pine.LNX.4.33.0209292230500.591-100000@pnote.perex-int.cz>
	<20020929.175311.97852433.davem@redhat.com>
	<1033390451.16337.33.camel@irongate.swansea.linux.org.uk>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Alan Cox <alan@lxorguk.ukuu.org.uk>
   Date: 30 Sep 2002 13:54:11 +0100

   On Mon, 2002-09-30 at 01:53, David S. Miller wrote:
   > EISA/ISA DMA is defined as using a hwdev of NULL or requiring
   > <16MB address, he is preserving GFP_DMA in those cases.
   
   Firstly the DMA mask on x86 can't be below 24bits, we don't support
   allocation from a smaller zone.

Understood.

   Secondly what about PCI for 25-31bits -
   there we do need to force gfp_dma to have any chance of getting the
   right pages
   
Look at what his code does after the GFP_DMA setting, it goes
a non-GFP_DMA setting, and if the 25-31 bits case is not satisfied
it backs down to GFP_DMA.

   Giving the page allocator a mask argument does sound a lot nicer
   
It's pretty simple to implement too since we do have page_to_phys.
