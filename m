Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316580AbSE3LJk>; Thu, 30 May 2002 07:09:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316583AbSE3LJi>; Thu, 30 May 2002 07:09:38 -0400
Received: from pizda.ninka.net ([216.101.162.242]:25015 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S316580AbSE3LJf>;
	Thu, 30 May 2002 07:09:35 -0400
Date: Thu, 30 May 2002 03:54:07 -0700 (PDT)
Message-Id: <20020530.035407.49404208.davem@redhat.com>
To: emmanuel_michon@realmagic.fr
Cc: adam@yggdrasil.com, linux-kernel@vger.kernel.org
Subject: Re: Does pci_alloc_consisent really need to zero memory?
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <7w4rgpc2vd.fsf@avalon.france.sdesigns.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Emmanuel Michon <emmanuel_michon@realmagic.fr>
   Date: 30 May 2002 13:05:26 +0200

   "David S. Miller" <davem@redhat.com> writes:
   
   > I'd rather see a patch to DMA-mapping.txt that specifies the memory
   > returned is zeroed out, as this is what every implementation appears
   > to do.
   
   What was the idea when writing the code that zeroes memory? It seems
   so useless.
   
Because 9 out of 10 drivers where I had to change virt_to_bus
into the portable pci_alloc_consistent were using get_free_pages()
which zeros things out for you.

I do actually remember that many of those instances in fact did
depend on the memory being zero'd for them, they weren't using the
"zero the pages too" variant instead of __get_free_pages()
gratuitously.
