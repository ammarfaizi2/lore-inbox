Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932176AbWHVLe5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932176AbWHVLe5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Aug 2006 07:34:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932177AbWHVLe5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Aug 2006 07:34:57 -0400
Received: from smtp-relay.dca.net ([216.158.48.66]:35495 "EHLO
	smtp-relay.dca.net") by vger.kernel.org with ESMTP id S932176AbWHVLe4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Aug 2006 07:34:56 -0400
Date: Tue, 22 Aug 2006 07:34:47 -0400
From: "Mark M. Hoffman" <mhoffman@lightlink.com>
To: Dmitry Torokhov <dtor@insightbb.com>
Cc: Jean Delvare <khali@linux-fr.org>, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>,
       Michal Piotrowski <michal.k.k.piotrowski@gmail.com>,
       lm-sensors@lm-sensors.org
Subject: Re: [lm-sensors] [RFC][PATCH] hwmon:fix sparse warnings + error handling
Message-ID: <20060822113447.GA28702@jupiter.solarsys.private>
References: <44E8C9AE.3060307@gmail.com> <20060821100416.4d356328.khali@linux-fr.org> <200608212043.06256.dtor@insightbb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200608212043.06256.dtor@insightbb.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry:

* Dmitry Torokhov <dtor@insightbb.com> [2006-08-21 20:43:05 -0400]:
> On Monday 21 August 2006 04:04, Jean Delvare wrote:
> > > --- linux-work-clean/drivers/hwmon/w83627hf.c	2006-08-20 22:02:40.000000000 +0200
> > > +++ linux-work/drivers/hwmon/w83627hf.c	2006-08-20 22:27:14.000000000 +0200
> > > @@ -513,9 +513,21 @@ static DEVICE_ATTR(in0_max, S_IRUGO | S_
> > > 
> > >  #define device_create_file_in(client, offset) \
> > >  do { \
> > > -device_create_file(&client->dev, &dev_attr_in##offset##_input); \
> > > -device_create_file(&client->dev, &dev_attr_in##offset##_min); \
> > > -device_create_file(&client->dev, &dev_attr_in##offset##_max); \
> > > +	err = device_create_file(&client->dev, &dev_attr_in##offset##_input); \
> > > +	if (err) {\
> > > +		hwmon_device_unregister(data->class_dev); \
> > > +		return err; \
> > > +	} \
> > > +	err = device_create_file(&client->dev, &dev_attr_in##offset##_min); \
> > > +	if (err) {\
> > > +		hwmon_device_unregister(data->class_dev); \
> > > +		return err; \
> > > +	} \
> > > +	err = device_create_file(&client->dev, &dev_attr_in##offset##_max); \
> > > +	if (err) {\
> > > +		hwmon_device_unregister(data->class_dev); \
> > > +		return err; \
> > > +	} \
> > >  } while (0)
> > 
> > _Never_ use "return" in a macro. It's way too confusing for whoever will
> > read the code later.
> >
> 
> Also I believe it is good practice to remove created attributes explicitely
> instead of relying on sysfs to do the cleanup - I beliee Greg was going to
> remove it from sysfs at some point of time... 

Yep: the patches that are floating on the lm-sensors mailing list do fix this
also.  Again, see here:

http://lists.lm-sensors.org/pipermail/lm-sensors/2006-August/017204.html

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com

