Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751591AbWF1WFV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751591AbWF1WFV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 18:05:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751593AbWF1WFV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 18:05:21 -0400
Received: from smtp.osdl.org ([65.172.181.4]:19633 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751591AbWF1WFU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 18:05:20 -0400
Date: Wed, 28 Jun 2006 15:05:06 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Jeff Garzik <jeff@garzik.org>
cc: Marcel Holtmann <marcel@holtmann.org>, Greg KH <greg@kroah.com>,
       Dmitry Torokhov <dtor_core@ameritech.net>,
       Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [git pull] Input update for 2.6.17
In-Reply-To: <44A229C0.5060702@garzik.org>
Message-ID: <Pine.LNX.4.64.0606281502280.12404@g5.osdl.org>
References: <200606260235.03718.dtor_core@ameritech.net> 
 <Pine.LNX.4.64.0606262247040.3927@g5.osdl.org>  <20060627063734.GA28135@kroah.com>
  <Pine.LNX.4.64.0606271131590.3927@g5.osdl.org>  <Pine.LNX.4.64.0606271211110.3927@g5.osdl.org>
  <Pine.LNX.4.64.0606271231440.3927@g5.osdl.org> <1151437593.25011.38.camel@localhost>
 <Pine.LNX.4.64.0606272057160.3927@g5.osdl.org> <Pine.LNX.4.64.0606272114330.3927@g5.osdl.org>
 <44A229C0.5060702@garzik.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 28 Jun 2006, Jeff Garzik wrote:

> Linus Torvalds wrote:
> > Anyway, "urb->transfer_buffer" was initialized with
> > 
> > 	urb->transfer_buffer = skb->data;
> > 
> > and I'm pretty damn sure you're supposed to just kfree() it.
> 
> eh?  I would think dev_kfree_skb(), because who knows whether the skb was
> cloned, split, data buffer adjusted, destructors need to be called...

Well, we don't actually have the skb available any more.

> kfree()ing skb->data sounds like a recipe for corruption and crashes...

Yeah. But I didn't actually look very deeply, maybe I mistook the init 
sequence. That said, corruption and crashes is obviously what I see, and 
why I started looking at it ;)

Marcel?

		Linus
