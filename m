Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265001AbTGBNtg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jul 2003 09:49:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265002AbTGBNtg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jul 2003 09:49:36 -0400
Received: from Mail1.kontent.de ([81.88.34.36]:53734 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S265001AbTGBNtf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jul 2003 09:49:35 -0400
From: Oliver Neukum <oliver@neukum.org>
To: ranty@debian.org, Manuel Estrada Sainz <ranty-bulk@ranty.pantax.net>,
       Oliver Neukum <neukum@fachschaft.cup.uni-muenchen.de>
Subject: Re: orinoco_usb Request For Comments
Date: Wed, 2 Jul 2003 16:02:47 +0200
User-Agent: KMail/1.5.1
Cc: LKML <linux-kernel@vger.kernel.org>, orinoco-usb-devel@ranty.pantax.net
References: <20030626205811.GA25783@ranty.pantax.net> <Pine.LNX.4.53.0306271213350.5135@fachschaft.cup.uni-muenchen.de> <20030702101747.GA4137@ranty.pantax.net>
In-Reply-To: <20030702101747.GA4137@ranty.pantax.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307021602.47534.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 2. Juli 2003 12:17 schrieb Manuel Estrada Sainz:
> On Fri, Jun 27, 2003 at 12:15:04PM +0200, Oliver Neukum wrote:
> > 
> > 
> > On Fri, 27 Jun 2003, Manuel Estrada Sainz wrote:
> > 
> > > On Thu, Jun 26, 2003 at 11:41:18PM +0200, Oliver Neukum wrote:
> > > > 		/* We don't like racing :) */
> > > > 		ctx->outurb->transfer_flags &= ~URB_ASYNC_UNLINK;
> > > > 		usb_unlink_urb(ctx->outurb);
> > > > 		del_timer_sync(&ctx->timer);
> > > >
> > > > But neither do we like sleeping in interrupt. You can't simply unset the flag
> > > > if somebody else may be needing it.
> > > >
> > > > More when I am rested :-)
> > >
> > >  How about the attached patch, not pretty, but it should work.
> > 
> > It is much too ugly. Please use a struct completion or a waitqueue.
>  
>  How about this?
> 
>  The other choice is to just wait on the completion unconditionally and
>  let timers expire on their own if needed.
>  
>  That would probably be more robust, and waiting a few extra seconds on
>  module removal (which would just happen when the card hangs) is
>  probably OK.  What do you think?

You also need this code path on hotunplugging.
Please take out the test for EINPROGRESS and examine the return
value of usb_unlink_urb() to decide whether you have to wait.
 
>  PS: Ideas on how to make the PCMCIA vs. USB integration (specially the
>  locking) cleaner would be very, very welcomed. 

I know too little about the PCMCIA cards. Sorry.

	Regards
		Oliver

