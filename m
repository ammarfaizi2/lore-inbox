Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261246AbUCQJPl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Mar 2004 04:15:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261239AbUCQJPl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Mar 2004 04:15:41 -0500
Received: from zone3.gcu-squad.org ([217.19.50.74]:39950 "EHLO
	zone3.gcu-squad.org") by vger.kernel.org with ESMTP id S261232AbUCQJP0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Mar 2004 04:15:26 -0500
Message-ID: <1079515049.405817a9a3da0@imp.gcu.info>
Date: Wed, 17 Mar 2004 10:17:29 +0100
From: Jean Delvare <khali@linux-fr.org>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com,
       Michael Hunold <hunold@convergence.de>
Subject: Re: [RFC][2.6] Additional i2c adapter flags for i2c client isolation
References: <4056C805.8090004@convergence.de> <20040316154454.GA13854@kroah.com> <20040316201426.1d01f1d3.khali@linux-fr.org> <20040316195325.GA22473@kroah.com>
In-Reply-To: <20040316195325.GA22473@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.2.2 / FreeBSD-4.6.2
X-Originating-IP: 62.23.237.137
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

According to Greg KH <greg@kroah.com>:

> > I guess that chip drivers would be allowed to define only one
> > class while adapters could possibly define more than one?
> 
> Not necessarily.  Just make the class a bit field, showing what kind
> of devices each expects to handle.

Of course, this is how I meant it.  The way things are done for now, the
class value is already a bitfield and I'm fine with that.  This makes
full sense for adapters.  What I was wondering is whether it would be
allowed to set more than one class bit for a chip driver.   Not that is
necessarily matters much, I'm just curious.  Have we ever heard of
chips that would belong to more than one class as we defined them?

> > We also would want to introduce an I2C_ADAP_CLASS_ANY define,
> > which would be what the eeprom driver would use, for example
> > (since it can be hosted on any kind of bus). Generic bus drivers
> > such as i2c-parport would also use I2C_ADAP_CLASS_ANY, since the
> > nature of the hosted chips is unknown.
> 
> Sure:
> 	#define I2C_ADAP_CLASS_ANY	0xffffffff
> works for me :)

Exactly what I had in mind ;)

> > Having clients define a class sounds also interesting from a
> > user-space's point of view. If we would export this information
> > through sysfs for example, programs such as "sensors" could
> > limit their work to chips of the correct class
> > (I2C_ADAP_CLASS_SMBUS at the moment, but a renaming is planned).
> 
> That also is a good idea.

How would we export the value though? Numerical, with user-space headers
to be included by user-space applications? Or converted to some
explicit text strings so that no headers are needed?

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/

