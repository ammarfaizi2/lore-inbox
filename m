Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263760AbUA3UuQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jan 2004 15:50:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263796AbUA3UuQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jan 2004 15:50:16 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:18174 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S263760AbUA3UuJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jan 2004 15:50:09 -0500
In-Reply-To: <0041A388-5121-11D8-B18F-000A95A0560C@us.ibm.com>
References: <401026CD.2030600@us.ibm.com> <0041A388-5121-11D8-B18F-000A95A0560C@us.ibm.com>
Mime-Version: 1.0 (Apple Message framework v612)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <DD98690D-5365-11D8-ABCB-000A95A0560C@us.ibm.com>
Content-Transfer-Encoding: 7bit
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, mochel@digitalimplant.org,
       Andrew Morton <akpm@osdl.org>
From: Hollis Blanchard <hollisb@us.ibm.com>
Subject: Re: (driver model) bus kset list manipulation bug
Date: Fri, 30 Jan 2004 14:49:58 -0600
To: Greg KH <greg@kroah.com>
X-Mailer: Apple Mail (2.612)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jan 27, 2004, at 5:31 PM, Hollis Blanchard wrote:
>
> devices_subsys looks like it's only used for two things: global 
> hotplug policy and suspend. Of the 3 hotplug functions it provides 
> (dev_hotplug_filter, dev_hotplug_name, and dev_hotplug), 2 of them 
> refer to bus data or code anyways.
>
> I'm very surprised to see it's used by device_shutdown(). I thought 
> one of the points of the device tree was to do depth-first-suspend, so 
> e.g we don't try to suspend a PCI bridge and *then* try to suspend 
> children of that bridge. Instead we're walking a global list in the 
> reverse order they were registered. I guess this works because busses 
> are discovered from the root down, so going backwards will give you 
> the deepest first.

To reply to myself again (starting to get the hint...), I wonder how 
long the global devices_subsys list will work for power-suspend once we 
start hotplugging devices and busses? Seems to me that a cascading bus 
power-down message is what has to happen...

-- 
Hollis Blanchard
IBM Linux Technology Center

