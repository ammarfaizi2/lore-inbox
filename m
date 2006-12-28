Return-Path: <linux-kernel-owner+w=401wt.eu-S1754808AbWL1KoI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754808AbWL1KoI (ORCPT <rfc822;w@1wt.eu>);
	Thu, 28 Dec 2006 05:44:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754813AbWL1KoH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Dec 2006 05:44:07 -0500
Received: from coyote.holtmann.net ([217.160.111.169]:57167 "EHLO
	mail.holtmann.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754808AbWL1KoG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Dec 2006 05:44:06 -0500
Subject: Re: bluetooth memory corruption (was Re: ext3-related crash in
	2.6.20-rc1)
From: Marcel Holtmann <marcel@holtmann.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: Andrew Morton <akpm@osdl.org>, kernel list <linux-kernel@vger.kernel.org>,
       maxk@qualcomm.com, bluez-devel@lists.sourceforge.net
In-Reply-To: <20061228084251.GB3955@ucw.cz>
References: <20061223234305.GA1809@elf.ucw.cz>
	 <20061223235501.GA1740@elf.ucw.cz> <1166971163.15485.21.camel@violet>
	 <20061224234357.GA1817@elf.ucw.cz>  <20061228084251.GB3955@ucw.cz>
Content-Type: text/plain
Date: Thu, 28 Dec 2006 11:40:25 +0100
Message-Id: <1167302425.2417.18.camel@violet>
Mime-Version: 1.0
X-Mailer: Evolution 2.9.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavel,

> > > > > I got this nasty oops while playing with debugger. Not sure if that is
> > > > > related; it also might be something with bluetooth; I already know it
> > > > > corrupts memory during suspend, perhaps it corrupts memory in some
> > > > > error path?
> > > > 
> > > > Okay, I spoke too soon. bluetooth & suspend memory corruption was
> > > > _way_ harder to reproduce than expected. Took me 5-or-so-suspend
> > > > cycles... so it is probably unrelated to the previous crash.
> > > 
> > > can you try to reproduce this with 2.6.20-rc2 as well.
> > 
> > (reproduced in another mail).
> > 
> >         _urb_queue_tail(__pending_q(husb, _urb->type), _urb);
> >         err = usb_submit_urb(urb, GFP_ATOMIC);
> >         if (err) {
> >                 BT_ERR("%s tx submit failed urb %p type %d err %d",
> >                                 husb->hdev->name, urb, _urb->type, err);
> >                 _urb_unlink(_urb);
> > 
> >                 ~~~~~~~~~~~~~~~~~~
> > 	 	 Do we need to remove urb from pending_q here?
> > 
> >                 _urb_queue_tail(__completed_q(husb, _urb->type), _urb);
> >         } else
> >                 atomic_inc(__pending_tx(husb, _urb->type));
> > 
> 
> Any news? Should I convert above idea to a patch? Or should I make
> bluetooth suspend() routine return error so corruption is impossible
> to hit?

to be honest, I have no idea. This code is way to ugly anyway.

Regards

Marcel


