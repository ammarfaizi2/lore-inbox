Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264858AbUF1Hvx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264858AbUF1Hvx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jun 2004 03:51:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264880AbUF1Hvx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jun 2004 03:51:53 -0400
Received: from gprs187-64.eurotel.cz ([160.218.187.64]:20352 "EHLO
	midnight.ucw.cz") by vger.kernel.org with ESMTP id S264858AbUF1Hvv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jun 2004 03:51:51 -0400
Date: Mon, 28 Jun 2004 09:51:24 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/19] New set of input patches
Message-ID: <20040628075124.GA1507@ucw.cz>
References: <200406280008.21465.dtor_core@ameritech.net> <20040628065259.GA1291@ucw.cz> <200406280213.58978.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200406280213.58978.dtor_core@ameritech.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 28, 2004 at 02:13:58AM -0500, Dmitry Torokhov wrote:

> > IMO drivers have no bussiness messing with the serio locks. We could use
> > 'plug' and 'unplug' functions like the network driver use, or handle it
> > inside the driver, but taking the lock is the wrong thing to do.
> 
> OK, I just don't want to introduce another lock just for that...

I think a bit in flags "PSMOUSE_ENABLED", like we have the
"ATKBD_ENABLED" bit might be just fine - handle the interrupt, but throw
away the data during the protocol switch. We aren't interested in the
data anyway.

> > > 15-synaptics-passthrough-handling.patch
> > >         - If data looks like a pass-through packet and tuchpad has
> > >           pass-through capability do not pass it to the main handler
> > >           if child port is disconnected.
> > 
> > I'll have to look closer on this one - I think we want to pass the data
> > to the serio layer even if there is no driver listening on the
> > passthrough serio.
> 
> We probably should issue serio_interrupt on child port to force rescan but
> that packet has no business in parent's motion handling routine and that's
> what this patch tries to fix. Anyway, I will look at it more later.

Indeed, we need it for the rescan. It shouldn't be that hard to fix at
once.

>   
> > > (*) These patches have also been sent to Greg KH.
> > 
> > Did he accept them already?
>  
> No, not yet. He promised to take a look at platoform_device_register_simple by
> the end of the week but I guess kernel.bkbits.net troubles might intervene...
> And other 2 I just send out today.

Ok. I'll wait then.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
