Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267704AbUGaPpj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267704AbUGaPpj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Jul 2004 11:45:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267939AbUGaPpj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Jul 2004 11:45:39 -0400
Received: from mail.kroah.org ([69.55.234.183]:13989 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S267704AbUGaPph (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Jul 2004 11:45:37 -0400
Date: Sat, 31 Jul 2004 08:42:22 -0700
From: Greg KH <greg@kroah.com>
To: Jon Smirl <jonsmirl@yahoo.com>
Cc: Vojtech Pavlik <vojtech@suse.cz>, Jesse Barnes <jbarnes@engr.sgi.com>,
       linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: [PATCH] add PCI ROMs to sysfs
Message-ID: <20040731154222.GA23098@kroah.com>
References: <20040731100318.GA1799@ucw.cz> <20040731132828.39719.qmail@web14928.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040731132828.39719.qmail@web14928.mail.yahoo.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 31, 2004 at 06:28:28AM -0700, Jon Smirl wrote:
> --- Vojtech Pavlik <vojtech@suse.cz> wrote:
> > On Fri, Jul 30, 2004 at 02:53:25PM -0700, Jon Smirl wrote:
> > > Here's another grungy thing I needed to do to PCI. Multi-headed
> > video
> > 
> > You can do that, but where is the problem with your probe function
> > being
> > called twice - once for each of the devices? You should be able to
> > sort
> > out which one is which rather easily.
> 
> I wrote this a while ago, but I believe the problem was that by
> accepting two probes I get two hotplug ADD events that I can't tell
> apart. This scheme avoids triggering hotplug. The other problem was
> that the ADD events get started in parallel and I couldn't figure out
> how to serialize them. The parallel hotplug programs got into a race to
> see who could initialize the card first.
> 
> Now that I know more about hotplug I could modify the hotplug
> parameters to indicate primary vs secondary and ignore the secondary
> one. But this will still cause two apps to be started in parallel. 

But as it's easy to tell which one is the secondary, just don't run the
userspace app for that device.  I don't recommend doing your "grab the
other device" hack in the driver, as it's not not a very nice thing to
do, and will probably break in the future.

> Another solution would be to modify the kernel API somehow to let me
> suppress hotplug ADD/REMOVE on the secondary device.

Well, as your driver isn't even loaded at that point in time, it's a bit
hard for it to control that :)

thanks,

greg k-h
