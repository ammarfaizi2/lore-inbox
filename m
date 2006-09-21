Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751004AbWIUCNx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751004AbWIUCNx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 22:13:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751005AbWIUCNx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 22:13:53 -0400
Received: from smtp.osdl.org ([65.172.181.4]:47069 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751003AbWIUCNw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 22:13:52 -0400
Date: Wed, 20 Sep 2006 19:13:36 -0700
From: Andrew Morton <akpm@osdl.org>
To: Dmitry Torokhov <dtor@insightbb.com>
Cc: Aristeu Sergio Rozanski Filho <aris@cathedrallabs.org>,
       Michael Hanselmann <linux-kernel@hansmi.ch>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ams: remove usage of input_dev cdev
Message-Id: <20060920191336.001b2c6a.akpm@osdl.org>
In-Reply-To: <200609202159.53628.dtor@insightbb.com>
References: <20060921005158.GB16002@cathedrallabs.org>
	<200609202159.53628.dtor@insightbb.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Sep 2006 21:59:53 -0400
Dmitry Torokhov <dtor@insightbb.com> wrote:

> On Wednesday 20 September 2006 20:51, Aristeu Sergio Rozanski Filho wrote:
> > This patch removes usage of 'cdev' member of input_dev, not present
> > on that struct anymore.
> > 
> 
> Where did it go?

Sigh.  That would make a good ./.signature

> > Signed-off-by: Aristeu S. Rozanski F. <aris@cathedrallabs.org>
> > 
> > --- mm.orig/drivers/hwmon/ams/ams-mouse.c	2006-09-20 13:57:59.000000000 -0300
> > +++ mm/drivers/hwmon/ams/ams-mouse.c	2006-09-20 21:01:59.000000000 -0300
> > @@ -66,7 +66,6 @@
> >  	ams_info.idev->name = "Apple Motion Sensor";
> >  	ams_info.idev->id.bustype = ams_info.bustype;
> >  	ams_info.idev->id.vendor = 0;
> > -	ams_info.idev->cdev.dev = &ams_info.of_dev->dev;
> >  
> >  	input_set_abs_params(ams_info.idev, ABS_X, -50, 50, 3, 0);
> >  	input_set_abs_params(ams_info.idev, ABS_Y, -50, 50, 3, 0);
> > 

I think the right fix is s/cdev.dev/d.parent/g.  But Greg has moved all
those patches out of the tree which I'll henceforth be merging into -mm, so
we can stop worrying about it.  
