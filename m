Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268118AbUHXARa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268118AbUHXARa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 20:17:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266836AbUHXAN0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 20:13:26 -0400
Received: from c3-1d224.neo.lrun.com ([24.93.233.224]:54658 "EHLO neo.rr.com")
	by vger.kernel.org with ESMTP id S269059AbUHXAKx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 20:10:53 -0400
Date: Mon, 23 Aug 2004 20:00:31 +0000
From: Adam Belay <ambx1@neo.rr.com>
To: Len Brown <len.brown@intel.com>
Cc: linux-kernel@vger.kernel.org, greg@kroah.com, rml@ximian.com,
       mochel@digitalimplant.org
Subject: Re: [RFC] Bus Resource Management
Message-ID: <20040823200031.GA7138@neo.rr.com>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>,
	Len Brown <len.brown@intel.com>, linux-kernel@vger.kernel.org,
	greg@kroah.com, rml@ximian.com, mochel@digitalimplant.org
References: <20040819133550.GH3824@neo.rr.com> <1093289962.17215.45.camel@dhcppc4>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1093289962.17215.45.camel@dhcppc4>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 23, 2004 at 03:39:22PM -0400, Len Brown wrote:
> On Thu, 2004-08-19 at 09:35, Adam Belay wrote:
>
> > 2.) Sysfs user interface
> > - userspace applications can determine resource usage and
> > dependencies.
> > - userspace applications can disable and enable devices
> > - userspace applications can assign resources to a device
> > - userspace applications can pause the operation of a device, and
> > rebalance
> >   its resources
>
> I agree that run-time hotplug policy and re-balancing would all be very
> snappy from user-space - users should be in charge when setting policy.
> Heck, humans may even be needed to make some decisions regarding
> resource conflicts...
>
> But I'm wondering where the proper line is between that and the resource
> management that we have to do on boot before user-space exists.
>
> cheers,
> -Len
>

For the minimum, I'm leaning toward in-kernel configuration of devices needed
for boot and their parents. I would like to see features such as rebalancing
performed from userspace.  However, if there is a specific reason for this to be
in the kernel, I'd be happy to implement it.  Right now I'm just trying to
establish an infustructure that we can adapt to our needs.

Also there is the option of using initrd and further limiting the number of
devices that have to be configured before userspace is loaded.

When and how devices and their drivers should be configure for resources and
other settings is really a matter that needs to be discussed.  Do we want more
userspace involvement or less userspace involvement?  Also should the kernel be
able to operate independently of userspace in every situation?  One advantage I
see with userspace involement is that it would allow for a cache of previous
configuration settings.  This would make it possible to ensure that all devices
are configured consistently between boots.  It could apply not only to resource
settings, but also to driver settings currently handled by module params.  We
could even control the binding of drivers to devices.

Thanks,
Adam
