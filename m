Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1164036AbWLHAEb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1164036AbWLHAEb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 19:04:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1164175AbWLHAEb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 19:04:31 -0500
Received: from mx4.cs.washington.edu ([128.208.4.190]:39138 "EHLO
	mx4.cs.washington.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1164036AbWLHAEa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 19:04:30 -0500
Date: Thu, 7 Dec 2006 16:04:25 -0800 (PST)
From: David Rientjes <rientjes@cs.washington.edu>
To: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
cc: Amit Choudhary <amit2030@gmail.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.6.19] drivers/media/video/cpia2/cpia2_usb.c: Free
 previously allocated memory (in array elements) if kmalloc() returns NULL.
In-Reply-To: <200612080050.53895.m.kozlowski@tuxland.pl>
Message-ID: <Pine.LNX.4.64N.0612071602540.3592@attu4.cs.washington.edu>
References: <20061206211317.b996bc34.amit2030@gmail.com>
 <200612080050.53895.m.kozlowski@tuxland.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Dec 2006, Mariusz Kozlowski wrote:

> > --- a/drivers/media/video/cpia2/cpia2_usb.c
> > +++ b/drivers/media/video/cpia2/cpia2_usb.c
> > @@ -640,6 +640,10 @@ static int submit_urbs(struct camera_dat
> >  		cam->sbuf[i].data =
> >  		    kmalloc(FRAMES_PER_DESC * FRAME_SIZE_PER_DESC, GFP_KERNEL);
> >  		if (!cam->sbuf[i].data) {
> > +			for (--i; i >= 0; i--) {
> > +				kfree(cam->sbuf[i].data);
> > +				cam->sbuf[i].data = NULL;
> > +			}
> >  			return -ENOMEM;
> >  		}
> >  	}
> 
> Just for future. Shorter and more readable version of your for(...) thing:
> 
> 	while (i--) {
> 		...
> 	}
> 

No, that is not equivalent.

You want
	while (i-- >= 0) {
		...
	}
