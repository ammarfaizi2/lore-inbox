Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751173AbWCJQ6g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751173AbWCJQ6g (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Mar 2006 11:58:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751228AbWCJQ6g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Mar 2006 11:58:36 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:980 "EHLO
	aria.kroah.org") by vger.kernel.org with ESMTP id S1751173AbWCJQ6g
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Mar 2006 11:58:36 -0500
Date: Fri, 10 Mar 2006 08:58:13 -0800
From: Greg KH <gregkh@suse.de>
To: "Bryan O'Sullivan" <bos@pathscale.com>
Cc: Roland Dreier <rdreier@cisco.com>, rolandd@cisco.com, akpm@osdl.org,
       davem@davemloft.net, linux-kernel@vger.kernel.org,
       openib-general@openib.org
Subject: Re: [PATCH 9 of 20] ipath - char devices for diagnostics and lightweight subnet management
Message-ID: <20060310165813.GB11382@suse.de>
References: <eac2ad3017b5f160d24c.1141922822@localhost.localdomain> <ada8xrjfbd8.fsf@cisco.com> <1141948367.10693.53.camel@serpentine.pathscale.com> <20060310004505.GB17050@suse.de> <1141951725.10693.88.camel@serpentine.pathscale.com> <20060310010403.GC9945@suse.de> <1141965696.14517.4.camel@camp4.serpentine.com> <ada7j72detl.fsf@cisco.com> <1141998230.28926.4.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1141998230.28926.4.camel@localhost.localdomain>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 10, 2006 at 05:43:50AM -0800, Bryan O'Sullivan wrote:
> On Thu, 2006-03-09 at 21:55 -0800, Roland Dreier wrote:
> 
> > No, the only problems are with the way the various pieces of your
> > drivers refer to devices by index.
> 
> OK.  What's a safe way to iterate over the devices in the presence of
> hotplug, then?  I assume it's list_for_each_mumble; I just don't know
> what mumble is :-)

You keep an internal list of devices, if you really need to do such a
thing.

> > Also you only do this when the module is loaded, so you won't handle
> > devices that are hot-plugged later.
> 
> No, ipath_max is updated any time a probe routine is called.
> 
> >   And I don't see anything that
> > would handle hot unplug either.
> 
> What would this anything look like, if I were hoping for an example to
> emulate?  There's nothing in LDD3 about this, so I'm kind of in the
> dark.

It's just the "disconnect" PCI function being called, which can happen
at any time.

thanks,

greg k-h
