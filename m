Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262780AbSLRDFs>; Tue, 17 Dec 2002 22:05:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265012AbSLRDFs>; Tue, 17 Dec 2002 22:05:48 -0500
Received: from deimos.hpl.hp.com ([192.6.19.190]:56026 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S262780AbSLRDFr>;
	Tue, 17 Dec 2002 22:05:47 -0500
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15871.59369.54363.167770@napali.hpl.hp.com>
Date: Tue, 17 Dec 2002 19:13:45 -0800
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFT][PATCH] generic device DMA implementation
In-Reply-To: <200212180301.gBI31wE06794@localhost.localdomain>
References: <200212180301.gBI31wE06794@localhost.localdomain>
X-Mailer: VM 7.07 under Emacs 21.2.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  James> The attached should represent close to final form for the
  James> generic DMA API.  It includes documentation (surprise!) and
  James> and implementation in terms of the pci_ API for every arch
  James> (apart from parisc, which will be submitted later).

  James> I've folded in the feedback from the previous thread.
  James> Hopefully, this should be ready for inclusion.  If people
  James> could test it on x86 and other architectures, I'd be
  James> grateful.

  James> comments and feedback from testing welcome.

Would you mind doing a s/consistent/coherent/g?  This has been
misnamed in the PCI DMA interface all along, but I didn't think it's
worth breaking drivers because of it.  But since this is a new
interface, there is no such issue.

(Consistency says something about memory access ordering, coherency
only talks about there not being multiple values for a given memory
location.  On DMA-coherent platforms with weakly-ordered memory
systems, the returned memory really is only coherent, not consistent,
i.e., you have to use memory barriers if you want to enforce
ordering.)

Thanks,

	--david
