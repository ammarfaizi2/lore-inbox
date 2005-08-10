Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965138AbVHJO5U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965138AbVHJO5U (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Aug 2005 10:57:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965145AbVHJO5U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Aug 2005 10:57:20 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:22520 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S965138AbVHJO5T
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Aug 2005 10:57:19 -0400
Subject: Re: BUG: Real-Time Preemption 2.6.13-rc5-RT-V0.7.52-16
From: Daniel Walker <dwalker@mvista.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Andrew Burgess <aab@cichlid.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20050810115214.GA26108@elte.hu>
References: <200508092158.j79LwlmM010246@cichlid.com>
	 <1123633588.13135.27.camel@dhcp153.mvista.com>
	 <20050810115214.GA26108@elte.hu>
Content-Type: text/plain
Date: Wed, 10 Aug 2005 07:54:50 -0700
Message-Id: <1123685690.19139.9.camel@c-67-188-6-232.hsd1.ca.comcast.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-08-10 at 13:52 +0200, Ingo Molnar wrote:
> * Daniel Walker <dwalker@mvista.com> wrote:
> 
> > This may fix the warning , but I doubt it does anything for any hangs..
> > 
> > --- linux-2.6.12.orig/drivers/usb/core/hcd.c    2005-08-09 22:41:18.000000000 +0000
> > +++ linux-2.6.12/drivers/usb/core/hcd.c 2005-08-10 00:23:16.000000000 +0000
> > @@ -540,8 +540,7 @@ void usb_hcd_poll_rh_status(struct usb_h
> >         if (length > 0) {
> > 
> >                 /* try to complete the status urb */
> > -               local_irq_save (flags);
> > -               spin_lock(&hcd_root_hub_lock);
> > +               spin_lock_irqsave(&hcd_root_hub_lock, flags);
> >                 urb = hcd->status_urb;
> >                 if (urb) {
> >                         spin_lock(&urb->lock);
> 
> what -RT tree is this against? This change is already in the -16 tree.


Not the latest .. If this change is in -16 , then what's disabling
interrupts ? Must something like this only deeper, I guess.

Daniel

