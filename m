Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261406AbVCAIQJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261406AbVCAIQJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Mar 2005 03:16:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261600AbVCAIOY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Mar 2005 03:14:24 -0500
Received: from mail.kroah.org ([69.55.234.183]:26558 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261406AbVCAIOK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Mar 2005 03:14:10 -0500
Date: Mon, 28 Feb 2005 23:56:26 -0800
From: Greg KH <greg@kroah.com>
To: Kay Sievers <kay.sievers@vrfy.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: split kobject creation and hotplug event generation
Message-ID: <20050301075626.GA3890@kroah.com>
References: <20050226055316.GA14317@vrfy.org> <20050228194642.GA21323@kroah.com> <20050228202443.GA25248@vrfy.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050228202443.GA25248@vrfy.org>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 28, 2005 at 09:24:43PM +0100, Kay Sievers wrote:
> On Mon, Feb 28, 2005 at 11:46:42AM -0800, Greg KH wrote:
> > On Sat, Feb 26, 2005 at 06:53:16AM +0100, Kay Sievers wrote:
> > > This splits the implicit generation of a hotplug events from
> > > kobject_add() and kobject_del(), to give the user of of these
> > > functions control over the time the event is created.
> > > 
> > > The kobject_register() and unregister functions still have the same
> > > behavior and emit the events by themselves.
> > > 
> > > The class, block and device core is changed now to emit the hotplug
> > > event _after_ the "dev" file, the "device" symlink and the default
> > > attributes are created. This will save udev from spinning in a stat() loop
> > > to wait for the files to appear, which is expensive if we have a lot of
> > > concurrent events.
> > 
> > So, does this solve the issue that everyone has been complaining about
> > for years with the hotplug event happening before the sysfs files are
> > present?
> 
> I expect most of them, yes. It is not a guarantee, cause drivers can and will
> create attributes at any time. :) But the most interesting default ones, that
> people tend to expect at event time will be there _before_ the event happens.
> 
> To get this for the whole system and not only the class+block core, a few remainig
> places that use kobject_register() need to be changed to use kobject_add(), but
> that is a trivial change and nice too, cause it cleans up some error pathes, where
> a device needs to be unregistered in the same function and it emits two completely
> useless events for that.

Ok, I'll add this patch to my queue, feel free to send a follow-on patch
to also fix up this stuff.

thanks,

greg k-h
