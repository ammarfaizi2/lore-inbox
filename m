Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266175AbUGZXBe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266175AbUGZXBe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jul 2004 19:01:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266161AbUGZXAr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jul 2004 19:00:47 -0400
Received: from waste.org ([209.173.204.2]:36754 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S266158AbUGZXAd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jul 2004 19:00:33 -0400
Date: Mon, 26 Jul 2004 18:00:04 -0500
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.org>
Cc: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>, cw@f00f.org,
       rml@ximian.com, linux-kernel@vger.kernel.org
Subject: Re: [patch] kernel events layer
Message-ID: <20040726230003.GS5414@waste.org>
References: <F989B1573A3A644BAB3920FBECA4D25A6EBFB0@orsmsx407> <20040725230951.0e150dbe.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040725230951.0e150dbe.akpm@osdl.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 25, 2004 at 11:09:51PM -0700, Andrew Morton wrote:
> "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com> wrote:
> >
> > If you guys are up to it, I volunteer to write/port such a tool to scan 
> >  out the send_kevent{_atomic,}()s and make a catalog out of it.
> 
> I must say that my gut feeling here is that bolting an arbitrary new
> namespace into the kernel in this manner is not the way to proceed.

An uncontrolled namespace is no better than the existing printk info,
IMO. And I think it's next to impossible to control the kevent
namespace if it's scattered across the tree as strings, having tried
to do something analogous for another large project.
 
> I hope we'll hear more from Greg on this next week - see if we can come up
> with some way to use the kobject/sysfs namespace for this.

An API that looks like sysfs + dnotify to userspace is almost what you
want. While the sysfs namespace has some of the problems above, we're
already stuck with it.
 
> Although heaven knows how "tmpfs just ran out of space" would map onto
> kobject/sysfs.

Per mountpoint sysfs trees? I'm sure there are lifetime issues there.

Btw, we probably already have potential issues with kevents being
stale by the time userspace picks them up - eth0 up, eth0 down, eth1
renamed eth0, userspace notices eth0 up, tries to config downed eth1.

-- 
Mathematics is the supreme nostalgia of our time.
