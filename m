Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269081AbRHMOWT>; Mon, 13 Aug 2001 10:22:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269001AbRHMOWL>; Mon, 13 Aug 2001 10:22:11 -0400
Received: from pizda.ninka.net ([216.101.162.242]:20096 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S269972AbRHMOVw>;
	Mon, 13 Aug 2001 10:21:52 -0400
Date: Mon, 13 Aug 2001 07:21:57 -0700 (PDT)
Message-Id: <20010813.072157.71088670.davem@redhat.com>
To: alan@lxorguk.ukuu.org.uk
Cc: sandy@storm.ca, linux-kernel@vger.kernel.org
Subject: Re: struct page to 36 (or 64) bit bus address?
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <E15WIPL-0007UX-00@the-village.bc.nu>
In-Reply-To: <no.id>
	<E15WIPL-0007UX-00@the-village.bc.nu>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Alan Cox <alan@lxorguk.ukuu.org.uk>
   Date: Mon, 13 Aug 2001 15:09:31 +0100 (BST)

   > To make sure we're on the same wave length, are you suggesting
   > this is the kind of thing we'd call in a callback from the PCI
   > DMA support layer?
   
   Well that would be an ugly layer violation, but how about
   
   	scsi_retry_command_waitq(SCpnt, &dma_waitq)
   
   ?

I don't mean "PCI DMA support layer knows scsi routines to
call", rather I mean:

... register_new_scsi_host() ...

	add_notifier(&pci_dma_freespace_notifier, &host->dma_notifier_block);

And net drivers would do something similar, registering something
that will do "netdev_wake_queue();" etc.

Also, the DMA support layer must either:

1) require users of it to provide a kernel thread in which
   to execute these things in the correct context

2) have a kernel thread of it's own to do this

3) or somehow else be able to accept this notification
   from any kind of execution context

The notifier is capable of happening anywhere, anytime.
Right?

Later,
David S. Miller
davem@redhat.com
