Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266069AbSKZDTf>; Mon, 25 Nov 2002 22:19:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266078AbSKZDTf>; Mon, 25 Nov 2002 22:19:35 -0500
Received: from h-64-105-35-74.SNVACAID.covad.net ([64.105.35.74]:57776 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S266069AbSKZDTe>; Mon, 25 Nov 2002 22:19:34 -0500
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Mon, 25 Nov 2002 19:26:27 -0800
Message-Id: <200211260326.TAA22022@adam.yggdrasil.com>
To: rusty@rustcorp.com.au
Subject: Re: [PATCH] Module alias and table support
Cc: greg@kroah.com, kai@tp1.ruhr-uni-bochum.de, linux-kernel@vger.kernel.org,
       perex@suse.cz
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	I really like Rusty's "module aliases" idea.

	Its full potential has not been recognized in this discussion.

	If we're going to use strings for device ID matching,
then we can consolidate all of the xxx_device_id types into one:


struct device_id {
	const char	*pattern;
	/* In practice, many drivers want scalar driver data, many
	   want an integer, and a few could benefit from having both.
	   Alternatively, we could have no extra match data at all
	   and make drivers declare a parallel table, for it, but
	   most drivers only have a few ID's to match, so the cost of
	   providing these fields is small. */
	int		match_scalar;
	void		*match_ptr;
};


	There would be a long period of backward compatability wrappers
and porting to use the interface directly, but eventually we would have:

	- only one kind of module device table for generating module aliases,

	- device ID matching consolidated into drivers/base,

	- No need for user level programs to query devices to generate
	  hotplug information (goodbye pcimodules, usbmodules,
	  isapnpmodules),

	- Zero changes to user or kernel needed to add a new hotplug
	  bus type (just drop the driver modules in /lib/modules/nnn/
	  and run depmod).

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."
