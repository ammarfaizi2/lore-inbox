Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262119AbTLWTQi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Dec 2003 14:16:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262131AbTLWTQi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Dec 2003 14:16:38 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:48657 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S262119AbTLWTQg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Dec 2003 14:16:36 -0500
Date: Tue, 23 Dec 2003 19:16:34 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Greg KH <greg@kroah.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-hotplug-devel@lists.sourceforge.net
Subject: Re: [PATCH] add sysfs mem device support  [2/4]
Message-ID: <20031223191634.A8914@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Greg KH <greg@kroah.com>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org,
	linux-hotplug-devel@lists.sourceforge.net
References: <20031223002126.GA4805@kroah.com> <20031223002439.GB4805@kroah.com> <20031223002609.GC4805@kroah.com> <20031223131523.B6864@infradead.org> <20031223180127.GA14282@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20031223180127.GA14282@kroah.com>; from greg@kroah.com on Tue, Dec 23, 2003 at 10:01:27AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 23, 2003 at 10:01:27AM -0800, Greg KH wrote:
> In order for tools like udev to work, we must export all char devices
> that are registered with the kernel.  We can't do this at
> register_chrdev() time, as that only allocates a whole major.  And
> people haven't converted over to using register_chrdev_region only when
> they really have a device present yet.

Then add a random-junk-not-converted-yet devclass instead of duplicting
the adhoc code everywhere.  Still I'd vote for going to the proper interface
directly instead of adding bad hacks all over the places.  If that means
waiting for 2.7 to open, so what?

> With devices such as the misc devices, we only care about the devices we
> really have in the system at that time.  It also gives us the ability to
> show the linkage between the logical device, and the physical one (for
> misc devices.)

But why is it tied to the obsoltet misc mechanism (or the obsolete usb major
thing, etc..)

> Now yeah, I can see that some people might think it's a bit overkill to
> move the mem devices here, but why not?  They are logical devices in the
> system, and as stated above, it provides a place within sysfs to move
> user modifiable attributes of these devices out of /proc (as they do not
> pertain to anything related to processes.)

What user-modifiable attributes?

