Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268809AbRHMTKq>; Mon, 13 Aug 2001 15:10:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268675AbRHMTK0>; Mon, 13 Aug 2001 15:10:26 -0400
Received: from postfix2-2.free.fr ([213.228.0.140]:52493 "HELO
	postfix2-2.free.fr") by vger.kernel.org with SMTP
	id <S266806AbRHMTKQ> convert rfc822-to-8bit; Mon, 13 Aug 2001 15:10:16 -0400
Date: Mon, 13 Aug 2001 21:07:50 +0200 (CEST)
From: =?ISO-8859-1?Q?G=E9rard_Roudier?= <groudier@free.fr>
X-X-Sender: <groudier@gerard>
To: "David S. Miller" <davem@redhat.com>
Cc: <alan@lxorguk.ukuu.org.uk>, <sandy@storm.ca>,
        <linux-kernel@vger.kernel.org>
Subject: Re: struct page to 36 (or 64) bit bus address?
In-Reply-To: <20010813.072157.71088670.davem@redhat.com>
Message-ID: <20010813205023.P806-100000@gerard>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 13 Aug 2001, David S. Miller wrote:

>    From: Alan Cox <alan@lxorguk.ukuu.org.uk>
>    Date: Mon, 13 Aug 2001 15:09:31 +0100 (BST)
>
>    > To make sure we're on the same wave length, are you suggesting
>    > this is the kind of thing we'd call in a callback from the PCI
>    > DMA support layer?
>
>    Well that would be an ugly layer violation, but how about
>
>    	scsi_retry_command_waitq(SCpnt, &dma_waitq)
>
>    ?
>
> I don't mean "PCI DMA support layer knows scsi routines to
> call", rather I mean:
>
> ... register_new_scsi_host() ...
>
> 	add_notifier(&pci_dma_freespace_notifier, &host->dma_notifier_block);
>
> And net drivers would do something similar, registering something
> that will do "netdev_wake_queue();" etc.
>
> Also, the DMA support layer must either:
>
> 1) require users of it to provide a kernel thread in which
>    to execute these things in the correct context
>
> 2) have a kernel thread of it's own to do this
>
> 3) or somehow else be able to accept this notification
>    from any kind of execution context
>
> The notifier is capable of happening anywhere, anytime.
> Right?

That's the major problem if we ever want to preserve some ordering in the
queuing of SCSI IOs. It is not clear to me why a thread may help here. A
thread may help if you actually want to thread the queuing and/or if you
want to wait on resource. Note that using a thread for the queuing might
be a solution for preserving queuing ordering, but it is not the sole
solution.

Defunct T10/CAM addresses ordering problems especially during error
recovery by a freeze/unfreeze mechanism of device queues handled by SIMs
(SIMs are low-level drivers under Linux). Using threads, call-backs or any
other evil things on top of this mechanism can be a matter of O/S
dependent issues, but it is not the solution of the problem.

> Later,
> David S. Miller
> davem@redhat.com

Later,
Gérard P. Roudier
groudier@free.fr

:)

