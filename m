Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262625AbUEQWRZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262625AbUEQWRZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 May 2004 18:17:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262910AbUEQWRZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 May 2004 18:17:25 -0400
Received: from mail.kroah.org ([65.200.24.183]:19123 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262625AbUEQWRS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 May 2004 18:17:18 -0400
Date: Mon, 17 May 2004 15:13:20 -0700
From: Greg KH <greg@kroah.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.6 "IDE cache-flush at shutdown fixes"
Message-ID: <20040517221320.GA20768@kroah.com>
References: <20040514175918.6b9f4c9d.akpm@osdl.org> <E1BOs7C-0003Bd-00@gondolin.me.apana.org.au> <20040514231620.0f653afd.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040514231620.0f653afd.akpm@osdl.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 14, 2004 at 11:16:20PM -0700, Andrew Morton wrote:
> Herbert Xu <herbert@gondor.apana.org.au> wrote:
> >
> > Andrew Morton <akpm@osdl.org> wrote:
> > > 
> > > I don't know if it's worth the effort though.  Is any other driver likely
> > > to want to discriminate between reboot and shutdown?
> > 
> > e100 used to (and still does in 2.4) send the device into D3 on shutdown.
> > This causes problems on a number of boards if the box is only rebooting
> > as the driver fails to bring the device back out of D3.
> 
> Ho hum.  Greg, any preferences?  We can either:
> 
> a) Add a `restart' driver method and call that during reboot instead of
>    ->shutdown, if the driver implements ->restart.  Otherwise call
>    ->shutdown or
> 
> b) stick with the
> 
> 	if (system_state == SYSTEM_RESTART)
> 		...
> 
>    thing in IDE and potentially a couple of other places?

I think we should stick with option b) for now, as we are already
keeping this system state, right?  The number of different drivers that
will care about this is probably quite small.

But if I'm proven wrong, we can add "restart" to 2.7 :)

thanks,

greg k-h

