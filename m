Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261892AbTDHV0o (for <rfc822;willy@w.ods.org>); Tue, 8 Apr 2003 17:26:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261893AbTDHV0o (for <rfc822;linux-kernel-outgoing>); Tue, 8 Apr 2003 17:26:44 -0400
Received: from granite.he.net ([216.218.226.66]:12051 "EHLO granite.he.net")
	by vger.kernel.org with ESMTP id S261892AbTDHV0k (for <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Apr 2003 17:26:40 -0400
Date: Tue, 8 Apr 2003 14:40:45 -0700
From: Greg KH <greg@kroah.com>
To: Duncan Sands <baldrick@wanadoo.fr>
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [linux-usb-devel] [PATCH] USB speedtouch: don't open a connection if no firmware
Message-ID: <20030408214045.GA6376@kroah.com>
References: <200304080926.43403.baldrick@wanadoo.fr> <20030408201239.GA5828@kroah.com> <200304082222.10919.baldrick@wanadoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200304082222.10919.baldrick@wanadoo.fr>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 08, 2003 at 10:22:10PM +0200, Duncan Sands wrote:
> > > +	udsl_fire_receivers (instance);
> > >
> > >  	dbg ("udsl_atm_open successful");
> > >
> > > +	MOD_INC_USE_COUNT;
> > > +
> > >  	return 0;
> > >  }
> >
> > Any way you can convert this driver to not use MOD_INC_USE_COUNT, as
> > it's racy and not really supported anymore?  But if you _really_ have to
> > use it, you need to call it at the first possible chance to make any
> > race window smaller.
> 
> Hi Greg, I'm waiting on the fixes to the ATM layer (coming soon to a kernel
> near you).

Ah, ok, that makes sense.

> As for the position of MOD_INC_USE_COUNT, did you ever hear
> of anyone getting bitten by a race like this?  If it makes you feel better, I
> will move it up, probably just before I take the semaphore (since that is the
> first place we can sleep).  I will do it tomorrow, OK?

Yes, it needs to be before any function that can sleep.  I'll hold off
applying this patch then.

thanks,

greg k-h
