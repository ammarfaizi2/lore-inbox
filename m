Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284834AbRLDAVA>; Mon, 3 Dec 2001 19:21:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284701AbRLDAQl>; Mon, 3 Dec 2001 19:16:41 -0500
Received: from deimos.hpl.hp.com ([192.6.19.190]:39402 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S285210AbRLCVsd>;
	Mon, 3 Dec 2001 16:48:33 -0500
From: David Mosberger <davidm@hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15371.62205.231945.798891@napali.hpl.hp.com>
Date: Mon, 3 Dec 2001 13:47:41 -0800
To: Arjan van de Ven <arjanv@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-ia64@linuxia64.org,
        marcelo@conectiva.com.br, davem@redhat.com
Subject: Re: [Linux-ia64] patch to no longer use ia64's software mmu
In-Reply-To: <20011203160059.A2022@devserv.devel.redhat.com>
In-Reply-To: <20011203160059.A2022@devserv.devel.redhat.com>
X-Mailer: VM 6.76 under Emacs 20.4.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  Arjan> Hi, The patch below (against 2.4.16) makes the ia64 port no
  Arjan> longer use the (VERY slow) software IO mmu but makes it use
  Arjan> the same mechanism the x86 PAE port uses: it lets the higher
  Arjan> layers take care of the proper bouncing of PCI-unreachable
  Arjan> memory. The implemenation is pretty simple; instead of having
  Arjan> a 4Gb GFP_DMA zone and a <rest of ram> GFP_KERNEL zone, the
  Arjan> ia64 port now has a 4Gb GFP_DMA zone and a <rest of ram>
  Arjan> GFP_HIGH zone.  Since the ia64 cpu can address all of this
  Arjan> memory directly, the kmap() and related functions are
  Arjan> basically nops.

  Arjan> The result: 100 mbit ethernet performance on a ia64 machine
  Arjan> with 32Gb of ram increased more than 4x (from 20 mbit to 95
  Arjan> mbit)....

  Arjan> The only downside is that the current kernel will always
  Arjan> bounce buffer disk IO even if the scsi card is 64 bit PCI
  Arjan> capable; Jens Axboe's block highmem patch fixes that downside
  Arjan> nicely though.

How soon will Jens' patch make it into the official tree?  I think
that would be a pre-requisite before switching to a highmem based
implementation.

Another concern I have is that, fundamentally, I dislike the idea of
penalizing all IA-64 platforms due to one chipset that is, shall we
say, "lacking" (i.e., doesn't have an I/O TLB).

Could someone comment on whether the 870 will have I/O TLB support
(private mail is fine, if you don't feel comfortable sending mail to
all the lists...).

Thanks,

	--david
