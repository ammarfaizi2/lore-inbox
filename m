Return-Path: <linux-kernel-owner+w=401wt.eu-S964998AbWL1InH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964998AbWL1InH (ORCPT <rfc822;w@1wt.eu>);
	Thu, 28 Dec 2006 03:43:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965000AbWL1InH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Dec 2006 03:43:07 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:2884 "EHLO spitz.ucw.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S964998AbWL1InE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Dec 2006 03:43:04 -0500
Date: Thu, 28 Dec 2006 08:42:52 +0000
From: Pavel Machek <pavel@ucw.cz>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Andrew Morton <akpm@osdl.org>, kernel list <linux-kernel@vger.kernel.org>,
       maxk@qualcomm.com, bluez-devel@lists.sourceforge.net
Subject: Re: bluetooth memory corruption (was Re: ext3-related crash in 2.6.20-rc1)
Message-ID: <20061228084251.GB3955@ucw.cz>
References: <20061223234305.GA1809@elf.ucw.cz> <20061223235501.GA1740@elf.ucw.cz> <1166971163.15485.21.camel@violet> <20061224234357.GA1817@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061224234357.GA1817@elf.ucw.cz>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > > I got this nasty oops while playing with debugger. Not sure if that is
> > > > related; it also might be something with bluetooth; I already know it
> > > > corrupts memory during suspend, perhaps it corrupts memory in some
> > > > error path?
> > > 
> > > Okay, I spoke too soon. bluetooth & suspend memory corruption was
> > > _way_ harder to reproduce than expected. Took me 5-or-so-suspend
> > > cycles... so it is probably unrelated to the previous crash.
> > 
> > can you try to reproduce this with 2.6.20-rc2 as well.
> 
> (reproduced in another mail).
> 
>         _urb_queue_tail(__pending_q(husb, _urb->type), _urb);
>         err = usb_submit_urb(urb, GFP_ATOMIC);
>         if (err) {
>                 BT_ERR("%s tx submit failed urb %p type %d err %d",
>                                 husb->hdev->name, urb, _urb->type, err);
>                 _urb_unlink(_urb);
> 
>                 ~~~~~~~~~~~~~~~~~~
> 	 	 Do we need to remove urb from pending_q here?
> 
>                 _urb_queue_tail(__completed_q(husb, _urb->type), _urb);
>         } else
>                 atomic_inc(__pending_tx(husb, _urb->type));
> 

Any news? Should I convert above idea to a patch? Or should I make
bluetooth suspend() routine return error so corruption is impossible
to hit?
						Pavel
-- 
Thanks for all the (sleeping) penguins.
