Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266095AbSKZDtx>; Mon, 25 Nov 2002 22:49:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266106AbSKZDtx>; Mon, 25 Nov 2002 22:49:53 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:7184 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S266095AbSKZDtw>;
	Mon, 25 Nov 2002 22:49:52 -0500
Date: Mon, 25 Nov 2002 19:49:25 -0800
From: Greg KH <greg@kroah.com>
To: "Adam J. Richter" <adam@yggdrasil.com>
Cc: rusty@rustcorp.com.au, kai@tp1.ruhr-uni-bochum.de,
       linux-kernel@vger.kernel.org, perex@suse.cz
Subject: Re: [PATCH] Module alias and table support
Message-ID: <20021126034924.GC27006@kroah.com>
References: <200211260326.TAA22022@adam.yggdrasil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200211260326.TAA22022@adam.yggdrasil.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 25, 2002 at 07:26:27PM -0800, Adam J. Richter wrote:
> 	I really like Rusty's "module aliases" idea.
> 
> 	Its full potential has not been recognized in this discussion.
> 
> 	If we're going to use strings for device ID matching,
> then we can consolidate all of the xxx_device_id types into one:
> 
> 
> struct device_id {
> 	const char	*pattern;
> 	/* In practice, many drivers want scalar driver data, many
> 	   want an integer, and a few could benefit from having both.
> 	   Alternatively, we could have no extra match data at all
> 	   and make drivers declare a parallel table, for it, but
> 	   most drivers only have a few ID's to match, so the cost of
> 	   providing these fields is small. */
> 	int		match_scalar;
> 	void		*match_ptr;
> };

Nice idea, but how are you going to get the pre-processor to generate a
string with the proper pattern, based on a bunch of flags and integers?
(not to say it can't be done, just tricky stuff...)

> 	There would be a long period of backward compatability wrappers
> and porting to use the interface directly, but eventually we would have:
> 
> 	- only one kind of module device table for generating module aliases,

Very nice goal.

> 	- device ID matching consolidated into drivers/base,

Sorry, can't be fully done.  A number of drivers really want to poke
around at the device before they say they really claim the device.  So
we still need to call into them somehow.

> 	- No need for user level programs to query devices to generate
> 	  hotplug information (goodbye pcimodules, usbmodules,
> 	  isapnpmodules),

I think these can almost already go away now, with the info we have in
sysfs.

> 	- Zero changes to user or kernel needed to add a new hotplug
> 	  bus type (just drop the driver modules in /lib/modules/nnn/
> 	  and run depmod).

That is also a very nice goal.

Again, nice idea, have any idea how the code would look?

thanks,

greg k-h
