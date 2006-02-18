Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751240AbWBRNAt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751240AbWBRNAt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Feb 2006 08:00:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751244AbWBRNAt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Feb 2006 08:00:49 -0500
Received: from pcpool00.mathematik.uni-freiburg.de ([132.230.30.150]:45495
	"EHLO pcpool00.mathematik.uni-freiburg.de") by vger.kernel.org
	with ESMTP id S1751240AbWBRNAs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Feb 2006 08:00:48 -0500
Date: Sat, 18 Feb 2006 14:00:47 +0100
From: "Bernhard R. Link" <brlink@debian.org>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, linux-parport@lists.infradead.org
Subject: Re: [PATCH] register sysfs device for lp devices
Message-ID: <20060218130047.GA30491@pcpool00.mathematik.uni-freiburg.de>
Mail-Followup-To: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org,
	linux-parport@lists.infradead.org
References: <20060217113836.GA26254@pcpool00.mathematik.uni-freiburg.de> <20060218014541.GA17364@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060218014541.GA17364@kroah.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > + * can display it in their sysfs nodes */
> > +#define parport_set_dev(port,devptr) ((port)->dev = (devptr))
> 
> If you are going to save off a pointer to a structure, you need to
> increment it's reference count.  You aren't doing that here, and bad
> things might happen if it gets removed from under you :(

Guess I should think a bit more and copy other code a bit less.
The two examples I looked at were sound and network devices.
While they differ by calling class_device_create more directly,
this does not call a get_device either. (Or where have I missed
it?)

I thought that parport would only exist while the device exists and
is bound to the driver, when that stops it is removed anyway.
But lp.c does not implement lp_detach, so it still keeps this data
and it is really exposed even when the device vanished.

Some unrelated strage behaviour from this: When I manualy unbind
and bind an parport supplier, via 
echo -n "id" > /sys/bus/.../drivers/.../unbind
and then echo -n "id" > /sys/bus/.../drivers/.../bind
I get a new lp device every time without the old one vanishing.

Hochachtungsvoll,
	Bernhard R. Link
