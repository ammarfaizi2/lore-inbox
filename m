Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263574AbUFQU7v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263574AbUFQU7v (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jun 2004 16:59:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263174AbUFQU7u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jun 2004 16:59:50 -0400
Received: from mail.kroah.org ([65.200.24.183]:1735 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263629AbUFQU7h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jun 2004 16:59:37 -0400
Date: Thu, 17 Jun 2004 13:58:25 -0700
From: Greg KH <greg@kroah.com>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: Zwane Mwaikambo <zwane@fsmlabs.com>, "David S. Miller" <davem@redhat.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][2.6] fix bridge sysfs improperly initialised knobject
Message-ID: <20040617205825.GB3138@kroah.com>
References: <Pine.LNX.4.58.0406161247140.1944@montezuma.fsmlabs.com> <20040617134636.216f430e@dell_ss3.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040617134636.216f430e@dell_ss3.pdx.osdl.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 17, 2004 at 01:46:36PM -0700, Stephen Hemminger wrote:
> Yes, this would get rid of the name, but then wouldn't bridge show up
> as top level subsystem /sys/bridge. 

If you register it, yes it would.  Hm, what happens if you don't
register it...

> Is there no way to register without causing bogus hotplug events?

You are wanting to prevent hotplug events for a subset of a subsystem's
devices, right?  You faked out the core by providing a fake subsystem.
How about just using the filter of the subsystem you really want these
entries to show up under?  Would that work?

> I am getting a bad taste about the whole sysfs programming model, since
> it seems like programming by side effect. it would be better for sysfs
> to handle the case of hidden subsystems, or provide an alternate way
> not to generate hotplug events.

Well, we never considered that you would want to nest subsystems in such
a wierd way :)

Anyway, take a look at the filter ability to see if that would work out
for you instead of having to create a new subsystem.

thanks,

greg k-h
