Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030200AbWA3VlG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030200AbWA3VlG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 16:41:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030201AbWA3VlG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 16:41:06 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:54686
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S1030200AbWA3VlE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 16:41:04 -0500
Date: Mon, 30 Jan 2006 13:41:18 -0800
From: Greg KH <greg@kroah.com>
To: Aritz Bastida <aritzbastida@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Right way to configure a driver? (sysfs, ioctl, proc, configfs,....)
Message-ID: <20060130214118.GB26463@kroah.com>
References: <7d40d7190601261206wdb22ccck@mail.gmail.com> <20060127050109.GA23063@kroah.com> <7d40d7190601270230u850604av@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7d40d7190601270230u850604av@mail.gmail.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 27, 2006 at 11:30:26AM +0100, Aritz Bastida wrote:
> Hi!
> 
> > Hope this helps,
> >
> > greg k-h
> >
> 
> Yes, it helped me much. I'll move all the configuration/statistics to
> sysfs. I will read carefully the corresponding chapter in LDD3 :)
> But before that, I've got a few questions with what I know:
> 
> 1.- In what directory should I do all this configuration? I guess as,
> I'm writing a module it should be in /sys/module/<my_module>, right?
> Or would your recommend /sys/class/net or anything?

Your device directory is usually the best for device specific options.
In your driver directory (for the type of bus driver that your device
lives on) is for driver-wide options.

Not in the module directory, that's not easy to get to and not
recommended at all.  Only module paramaters go there.

> 2.- In my sysfs directory I would create two subdirectories: "config"
> and "stats". In the first I would place read/write files used for
> configuration. For example "config/flags" for the flags variable. In
> the second read-only files with the statistics. Is this approach
> correct?

The config stuff might be better off in configfs, not sysfs.

> 3.- Actually the most difficult config I must do is to pass three
> values from userspace to my module. Specifically two integers and a
> long (it's an offset to a memory zone I've previously defined)
> 
> struct meminfo {
>         unsigned int      id;         /* segment identifier */
>         unsigned int      size;     /* size of the memory area */
>         unsigned long   offset;   /* offset to the information */
> };
> 
> How would you pass this information in sysfs? Three values in the same
> file? Note that using three different files wouldn't be atomic, and I
> need atomicity.

Use configfs.

> 4.- Last, you suggested that I had three files for the rx_packets count:
>       rx_packets_cpu0
>       rx_packets_cpu1
>       rx_packets_total
> 
>      I have quite a few counters, and if that number of files is multiplied by
>      the number of cpus, the number of files could be very large (imagine a
>      8-cpu box), don't you think so? And after all reading a file with three
>      values could be done very easily with awk...

So, lots of files is not a problem, have you looked at the sysfs file
entries for the sensor/hwmon drivers in a while?  There are zillions of
them :)

thanks,

greg k-h
