Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262110AbTLWSEU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Dec 2003 13:04:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262109AbTLWSCr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Dec 2003 13:02:47 -0500
Received: from mail.kroah.org ([65.200.24.183]:3758 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262078AbTLWSB7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Dec 2003 13:01:59 -0500
Date: Tue, 23 Dec 2003 10:01:27 -0800
From: Greg KH <greg@kroah.com>
To: Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux-hotplug-devel@lists.sourceforge.net
Subject: Re: [PATCH] add sysfs mem device support  [2/4]
Message-ID: <20031223180127.GA14282@kroah.com>
References: <20031223002126.GA4805@kroah.com> <20031223002439.GB4805@kroah.com> <20031223002609.GC4805@kroah.com> <20031223131523.B6864@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031223131523.B6864@infradead.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 23, 2003 at 01:15:23PM +0000, Christoph Hellwig wrote:
> On Mon, Dec 22, 2003 at 04:26:09PM -0800, Greg KH wrote:
> > This adds /sys/class/mem which enables all mem char devices to show up
> > properly in udev.
> > 
> > Has been posted to linux-kernel every so often since last July, and
> > acked by a number of other kernel developers.
> 
> This is pointless.  The original point of sysfs and co was to present the
> physical device tree, where these devices absolutely fit into.

No. The point of sysfs and co was to present the physical _and_ logical
device tree.  Mem devices are devices.  This patch also provides a place
to move the /proc/sys/kernel/random files out of proc and into sysfs.

In order for tools like udev to work, we must export all char devices
that are registered with the kernel.  We can't do this at
register_chrdev() time, as that only allocates a whole major.  And
people haven't converted over to using register_chrdev_region only when
they really have a device present yet.

With devices such as the misc devices, we only care about the devices we
really have in the system at that time.  It also gives us the ability to
show the linkage between the logical device, and the physical one (for
misc devices.)

Now yeah, I can see that some people might think it's a bit overkill to
move the mem devices here, but why not?  They are logical devices in the
system, and as stated above, it provides a place within sysfs to move
user modifiable attributes of these devices out of /proc (as they do not
pertain to anything related to processes.)

I do agree that the duplication of the code should be fixed, and I'll go
do that right now (I should have realized that after cut-and-pasting
that logic the third time, sorry about that.)  If that is done, the
overhead to support mem devices will drop to a very tiny ammount.

thanks,

greg k-h
