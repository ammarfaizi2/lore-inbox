Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932073AbWAEQlh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932073AbWAEQlh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 11:41:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932078AbWAEQlh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 11:41:37 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:33432 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP id S932073AbWAEQlg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 11:41:36 -0500
Date: Thu, 5 Jan 2006 11:41:34 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: "Scott E. Preece" <preece@motorola.com>
cc: pavel@suse.cz, <akpm@osdl.org>, <linux-pm@lists.osdl.org>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [linux-pm] [patch] pm: fix runtime powermanagement's /sys
 interface
In-Reply-To: <200601051516.k05FGC5d023781@olwen.urbana.css.mot.com>
Message-ID: <Pine.LNX.4.44L0.0601051136230.5520-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Jan 2006, Scott E. Preece wrote:

> My inclination would be to have the sysfs interface know generic terms,
> with the implementation mapping them to device-specific terms. It ought
> to be possible to build portable tools that don't have to know about
> device-specific states and have the device interfaces (in sysfs) do the
> necessary translation.
> 
> However, I also think there is value in having the sysfs interface
> recognize the device-specific values as well, so that device-specific
> tools can also be written (offering the option of taking advantage of
> special capabilities of a particular device).

Yes, that was part of my point.

> | > It would be good to make the details available so that they are there when
> | > needed.  For instance, we might export "D0", "on", "D1", "D2", "D3", and
> | > "suspend", treating "on" as a synonym for "D0" and "suspend" as a synonym
> | > for "D3".
> | 
> | Why to make it this complex?
> | 
> | I do not think there's any confusion possible. "on" always corresponds
> | to "D0", and "suspend" is "D3". Anyone who knows what "D2" means,
> | should know that, too...

Not necessarily.  For instance, a particular driver might want to map 
"suspend" to D1 instead of to D3.

Given that "on" and "suspend" are generic names and not actual states (at 
least, not for PCI devices and presumably not for others as well), I think 
it makes sense to treat them specially.

And it's not all that complex.  Certainly no more complex than forcing
userspace tools to use {"on", "D1, "D2", "suspend"} instead of the
much-more-logical {"D0", "D1", "D2", "D3"}.

Alan Stern

