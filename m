Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030732AbWF0H45@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030732AbWF0H45 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 03:56:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030735AbWF0H45
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 03:56:57 -0400
Received: from cantor2.suse.de ([195.135.220.15]:30125 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1030732AbWF0H44 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 03:56:56 -0400
Date: Tue, 27 Jun 2006 00:53:41 -0700
From: Greg KH <greg@kroah.com>
To: Nigel Cunningham <nigel@suspend2.net>
Cc: Jens Axboe <axboe@suse.de>, "Rafael J. Wysocki" <rjw@sisk.pl>,
       linux-kernel@vger.kernel.org
Subject: Re: [Suspend2][ 0/9] Extents support.
Message-ID: <20060627075341.GA16347@kroah.com>
References: <20060626165404.11065.91833.stgit@nigel.suspend2.net> <200606271539.29540.nigel@suspend2.net> <20060627070609.GA28730@kroah.com> <200606271727.39474.nigel@suspend2.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200606271727.39474.nigel@suspend2.net>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 27, 2006 at 05:27:30PM +1000, Nigel Cunningham wrote:
> Hi.
> 
> On Tuesday 27 June 2006 17:06, Greg KH wrote:
> > Oh, and as a meta-comment, why /proc?  You know that's not acceptable,
> > right?
> 
> Partly because when I did consider switching to /sys, I found it to be 
> incomprehensible (even with the LWN articles and Documentation/ files). 
> Jonathan's articles and LCA presentation did help me start to get a better 
> grip, but then it just didn't seem to be worth the effort. I have two simple 
> relatively simple routines that handle all my proc entries at the moment, so 
> that adding a new entry is just a matter of adding an element in an array of 
> structs (saying what variable is being read/written, what type, min/max 
> values and side effect routines, eg). It looked to me like changing to sysfs 
> was going to require me to have a separate routine for every sysfs entry, 
> even though they'd all have those some basic features. Maybe I'm just 
> ignorant. Please tell me I am and point me in the right direction.

Well, as your stuff does not have anything to do with "processes",
putting it in /proc is not acceptable.

sysfs is one value per file, and if that matches up to what you need,
then it should be fine to use.

You do need to have some kind of function for every sysfs entry, but you
can group common ones together (as the hwmon drivers do.)

As you will not have a backing "device" to attach your files to, you
will probably need to deal with "raw" kobjects, and the learning curve
for how to create files in sysfs with them is unfortunatly a bit steep.
But there is lots of working examples in the kernel that do this (block
devices, md, driver core, etc.), there's plenty of code to copy from to
get it to work.

And if that doesn't look like fun, you can always just use create a new
filesystem (only 200 lines of code), or use debugfs.

good luck,

greg k-h
