Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261695AbVEaOeB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261695AbVEaOeB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 May 2005 10:34:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261688AbVEaOd7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 May 2005 10:33:59 -0400
Received: from styx.suse.cz ([82.119.242.94]:27846 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S261733AbVEaObS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 May 2005 10:31:18 -0400
Date: Tue, 31 May 2005 16:31:17 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Aristeu Sergio Rozanski Filho <aris@cathedrallabs.org>
Cc: Ian Campbell <icampbell@arcom.com>, linux-kernel@vger.kernel.org
Subject: Re: [UINPUT] Allow EV_ABS to work in uinput.c
Message-ID: <20050531143117.GB11108@ucw.cz>
References: <1117023999.20237.8.camel@icampbell-debian> <20050525123626.GC3772@cathedrallabs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050525123626.GC3772@cathedrallabs.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 25, 2005 at 09:36:26AM -0300, Aristeu Sergio Rozanski Filho wrote:
> > uinput_alloc_device() is supposed to return the number of bytes read,
> > the value is returned to uinput_write() and from there to userspace. If
> > EV_ABS is set then it returns the value from uinput_validate_absbits()
> > instead, which is zero when everything is ok instead of the count.
> > 
> > Signed-off-by: Ian Campbell <icampbell@arcom.com>
> Acked-by: Aristeu Rozanski <aris@cathedrallabs.org>

Thanks; added to my tree.

> > --- 2.6.orig/drivers/input/misc/uinput.c	2005-05-25 10:45:56.000000000 +0100
> > +++ 2.6/drivers/input/misc/uinput.c	2005-05-25 10:47:02.000000000 +0100
> > @@ -216,9 +216,11 @@
> >  	/* check if absmin/absmax/absfuzz/absflat are filled as
> >  	 * told in Documentation/input/input-programming.txt */
> >  	if (test_bit(EV_ABS, dev->evbit)) {
> > -		retval = uinput_validate_absbits(dev);
> > -		if (retval < 0)
> > +		int err = uinput_validate_absbits(dev);
> > +		if (err < 0) {
> > +			retval = err;
> >  			kfree(dev->name);
> > +		}
> >  	}
> >  
> >  exit:
> 
> -- 
> Aristeu
> 
> 

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
