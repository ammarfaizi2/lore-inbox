Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266163AbUIODuL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266163AbUIODuL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 23:50:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267184AbUIODuK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 23:50:10 -0400
Received: from mail.kroah.org ([69.55.234.183]:64478 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S266163AbUIODuE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 23:50:04 -0400
Date: Tue, 14 Sep 2004 20:48:53 -0700
From: Greg KH <greg@kroah.com>
To: Kay Sievers <kay.sievers@vrfy.org>
Cc: Robert Love <rml@ximian.com>, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [patch] kernel sysfs events layer
Message-ID: <20040915034853.GC30747@kroah.com>
References: <20040904005433.GA18229@kroah.com> <1094353088.2591.19.camel@localhost> <20040905121814.GA1855@vrfy.org> <20040906020601.GA3199@vrfy.org> <20040910235409.GA32424@kroah.com> <1094875775.10625.5.camel@lucy> <20040911165300.GA17028@kroah.com> <20040913144553.GA10620@vrfy.org> <20040915000753.GA24125@kroah.com> <20040915010901.GA19524@vrfy.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040915010901.GA19524@vrfy.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 15, 2004 at 03:09:01AM +0200, Kay Sievers wrote:
> On Tue, Sep 14, 2004 at 05:07:53PM -0700, Greg KH wrote:
> > On Mon, Sep 13, 2004 at 04:45:53PM +0200, Kay Sievers wrote:
> > > Do we agree on the model that the signal is a simple verb and we keep
> > > only a small dictionary of _static_ signal strings and no fancy compositions?
> > 
> > I agree with this.  And because of that, we should enforce that, and
> > help prevent typos in the signals.  So, here's a patch that does just
> > that, making it a lot harder to mess up (although you still can, as
> > enumerated types aren't checked by the compiler...)  This patch booted
> > on my test box.
> > 
> > Anyone object to me adding this patch?  If not, I'll fix up Kay's patch
> > for mounting to use this interface and add both of them.
> 
> I like it, so the printf is gone :) Fine with me.
> 
> > > And we should reserve the "add" and "remove" only for the hotplug events.
> > 
> > I don't know, the firmware objects already use "add" for an event.
> 
> Yes, but isn't the firmware event a real hotplug event? I just want to
> be sure, that it's easy to recognize the hotplug events from userspace.

It's a "real" one in that it is generated :)

request_firmware() causes the hotplug event to happen, so that we know
to load firmware to the device that requested it.

> > I didn't put a check in the kobject_uevent() calls to prevent the add and
> > remove, but now it's a lot easier to do so if you think it's necessary.
> 
> Don't think that this is needed. I will add somthing to the kobject
> documentation, if it's stable and merged.

Ok, I'll add this patch and wait for the documentation :)

thanks,

greg k-h
