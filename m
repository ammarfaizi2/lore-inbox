Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965077AbVHJLwJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965077AbVHJLwJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Aug 2005 07:52:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965078AbVHJLwJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Aug 2005 07:52:09 -0400
Received: from mx1.elte.hu ([157.181.1.137]:49358 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S965077AbVHJLwI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Aug 2005 07:52:08 -0400
Date: Wed, 10 Aug 2005 13:52:14 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Daniel Walker <dwalker@mvista.com>
Cc: Andrew Burgess <aab@cichlid.com>, linux-kernel@vger.kernel.org
Subject: Re: BUG: Real-Time Preemption 2.6.13-rc5-RT-V0.7.52-16
Message-ID: <20050810115214.GA26108@elte.hu>
References: <200508092158.j79LwlmM010246@cichlid.com> <1123633588.13135.27.camel@dhcp153.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1123633588.13135.27.camel@dhcp153.mvista.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Daniel Walker <dwalker@mvista.com> wrote:

> This may fix the warning , but I doubt it does anything for any hangs..
> 
> --- linux-2.6.12.orig/drivers/usb/core/hcd.c    2005-08-09 22:41:18.000000000 +0000
> +++ linux-2.6.12/drivers/usb/core/hcd.c 2005-08-10 00:23:16.000000000 +0000
> @@ -540,8 +540,7 @@ void usb_hcd_poll_rh_status(struct usb_h
>         if (length > 0) {
> 
>                 /* try to complete the status urb */
> -               local_irq_save (flags);
> -               spin_lock(&hcd_root_hub_lock);
> +               spin_lock_irqsave(&hcd_root_hub_lock, flags);
>                 urb = hcd->status_urb;
>                 if (urb) {
>                         spin_lock(&urb->lock);

what -RT tree is this against? This change is already in the -16 tree.

	Ingo
