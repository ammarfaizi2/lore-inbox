Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269447AbUINWD6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269447AbUINWD6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 18:03:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269583AbUINV7c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 17:59:32 -0400
Received: from mail.kroah.org ([69.55.234.183]:8866 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S266170AbUINVv7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 17:51:59 -0400
Date: Tue, 14 Sep 2004 14:51:22 -0700
From: Greg KH <greg@kroah.com>
To: "Marco d'Itri" <md@Linux.IT>
Cc: "Giacomo A. Catenazzi" <cate@pixelized.ch>, linux-kernel@vger.kernel.org
Subject: Re: udev is too slow creating devices
Message-ID: <20040914215122.GA22782@kroah.com>
References: <41473972.8010104@debian.org> <41474926.8050808@nortelnetworks.com> <20040914195221.GA21691@kroah.com> <414757FD.5050209@pixelized.ch> <20040914213506.GA22637@kroah.com> <20040914214552.GA13879@wonderland.linux.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040914214552.GA13879@wonderland.linux.it>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 14, 2004 at 11:45:52PM +0200, Marco d'Itri wrote:
> On Sep 14, Greg KH <greg@kroah.com> wrote:
> 
> > What's wrong with the /etc/dev.d/ location for any type of script that
> > you want to run after a device node has appeared?  This is an
> > application specific issue, not a kernel issue.
> The problem is that since most distributions cannot make udev usage
> mandatory, this would require duplicating in the init script and in the
> dev.d script whatever needs to be done with the device.

Well, that sounds like a distro problem then, not a kernel or udev one :)

> Then there are the issues of scripts needing programs in /usr, which may
> not be mounted when the module is loaded, or which are interactive and
> need console access (think fsck).

True, so sit and spin and sleep until you see the device node.  That's
how a number of distros have fixed the fsck startup issue.

> Basically asyncronous creation of devices requires a ground up redesign
> of the init scripts of a distribution. I'm not claiming that this is not
> possible, but it's not going to happen soon.

Well, it needs to go that way, as the kernel moves toward not providing
the device node right when modprobe returns with the advent of
multi-threading device discovery and such.  That's why the /etc/dev.d
heirachy was created, it's not dependant on udev to provide such a
solution.  I suggest that distros that do not use udev (of which Debian
is slowly becoming a miniority) create a tool that causes /etc/dev.d
events for a static /dev tree.

thanks,

greg k-h
