Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751834AbWG0AWA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751834AbWG0AWA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jul 2006 20:22:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751835AbWG0AWA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jul 2006 20:22:00 -0400
Received: from mail.kroah.org ([69.55.234.183]:28810 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751834AbWG0AWA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jul 2006 20:22:00 -0400
Date: Wed, 26 Jul 2006 17:20:09 -0700
From: Greg KH <gregkh@suse.de>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org, greg@kroah.com
Subject: Re: [RFC PATCH] Multi-threaded device probing
Message-ID: <20060727002009.GA9390@suse.de>
References: <20060725203028.GA1270@kroah.com> <200607270202.00854.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200607270202.00854.arnd@arndb.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 27, 2006 at 02:02:00AM +0200, Arnd Bergmann wrote:
> On Tuesday 25 July 2006 22:30, Greg KH wrote:
> > --- gregkh-2.6.orig/include/linux/device.h
> > +++ gregkh-2.6/include/linux/device.h
> > @@ -105,6 +105,8 @@ struct device_driver {
> > ????????void????(*shutdown)?????(struct device * dev);
> > ????????int?????(*suspend)??????(struct device * dev, pm_message_t state);
> > ????????int?????(*resume)???????(struct device * dev);
> > +
> > +???????unsigned int multithread_probe:1;
> > ?};
> > ?
> 
> Why use a bit field here? It ends up consuming sizeof(long) anyway
> and causes more complex code, with no obvious benefit.

Because we don't yet have a boolean type :)

Honestly, I don't really care, I can make it a char if people really
care (but due to padding, it would take up the same size as unsigned
long anyway...)

thanks,

greg k-h
