Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267726AbUHTI6e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267726AbUHTI6e (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 04:58:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265099AbUHTI6e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 04:58:34 -0400
Received: from mail1.kontent.de ([81.88.34.36]:30592 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S268005AbUHTIva (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 04:51:30 -0400
From: Oliver Neukum <oliver@neukum.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: PF_MEMALLOC in 2.6
Date: Fri, 20 Aug 2004 10:52:51 +0200
User-Agent: KMail/1.6.2
Cc: Hugh Dickins <hugh@veritas.com>, Pete Zaitcev <zaitcev@redhat.com>,
       arjanv@redhat.com, alan@redhat.com, greg@kroah.com,
       linux-kernel@vger.kernel.org, riel@redhat.com, sct@redhat.com
References: <Pine.LNX.4.44.0408191320320.17508-100000@localhost.localdomain> <200408200956.50972.oliver@neukum.org> <4125B111.2040308@yahoo.com.au>
In-Reply-To: <4125B111.2040308@yahoo.com.au>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200408201052.51178.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Freitag, 20. August 2004 10:06 schrieb Nick Piggin:
> >>So I'd say try to find a way to only use PF_MEMALLOC on behalf of
> >>a PF_MEMALLOC thread or use a mempool or something.
> > 
> > 
> > Then the SCSI layer should pass down the flag.
> > 
> 
> It would be ideal from the memory allocator's point of view to do it
> on a per-request basis like that.
> 
> When the rubber hits the road, I think it is probably going to be very
> troublesome to do it right that way. For example, what happens when
> your usb-thingy-thread blocks on a memory allocation while handling a
> read request, then the system gets low on memory and someone tries to
> free some by submitting a write request to the USB device?

The write request will have to wait. Storage cannot do concurrent IO.
But all memory allocated in the read request will be GFP_NOIO or
GFP_ATOMIC so the conclusion of the memory allocation should not
wait for IO. Either it fails and we report that to the SCSI layer or it
is completed and the write serviced in turn.
At least that's the intent.

	Regards
		Oliver


