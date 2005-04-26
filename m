Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261371AbVDZHDI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261371AbVDZHDI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 03:03:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261381AbVDZHBm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 03:01:42 -0400
Received: from lyle.provo.novell.com ([137.65.81.174]:23350 "EHLO
	lyle.provo.novell.com") by vger.kernel.org with ESMTP
	id S261371AbVDZHAd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 03:00:33 -0400
Date: Tue, 26 Apr 2005 00:00:03 -0700
From: Greg KH <gregkh@suse.de>
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Cc: dtor_core@ameritech.net, sensors@stimpy.netroedge.com,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC/PATCH 0/22] W1: sysfs, lifetime and other fixes
Message-ID: <20050426070003.GE5889@suse.de>
References: <200504210207.02421.dtor_core@ameritech.net> <1114089504.29655.93.camel@uganda> <d120d50005042107314cbacdea@mail.gmail.com> <1114420131.8527.52.camel@uganda> <d120d50005042509326241a302@mail.gmail.com> <20050426001500.6a199399@zanzibar.2ka.mipt.ru> <d120d500050425132250916bcb@mail.gmail.com> <1114497816.8527.66.camel@uganda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1114497816.8527.66.camel@uganda>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 26, 2005 at 10:43:36AM +0400, Evgeniy Polyakov wrote:
> On Mon, 2005-04-25 at 15:22 -0500, Dmitry Torokhov wrote:
> > On 4/25/05, Evgeniy Polyakov <johnpol@2ka.mipt.ru> wrote:
> > > While thinking about locking schema
> > > with respect to sysfs files I recalled,
> > > why I implemented such a logic -
> > > now one can _always_ remove _any_ module
> > > [corresponding object is removed from accessible
> > > pathes and waits untill all exsting users are gone],
> > > which is very good - I really like it in networking model,
> > > while with whole device driver model
> > > if we will read device's file very quickly
> > > in several threads we may end up not unloading it at all.
> > 
> > I am sorrry, that is complete bull*. sysfs also allows removing
> > modules at an arbitrary time (and usually without annoying "waiting
> > for refcount" at that)... You just seem to not understand how driver
> > code works, thus the need of inventing your own schema.
> 
> Ok, let's try again - now with explanation, 
> since it looks like you did not even try to understand what I said.
> If you will remove objects from ->remove() callback
> you may end up with rmmod being stuck.

Yes, and that is acceptable.  networking implemented their own locking
method to allow unloading of their drivers in such a manner.  No other
subsystem is going to do that kind of implementation, so Dmitry is
correct here.

thanks,

greg k-h
