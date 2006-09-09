Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751390AbWIIVbW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751390AbWIIVbW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Sep 2006 17:31:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751391AbWIIVbW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Sep 2006 17:31:22 -0400
Received: from cantor2.suse.de ([195.135.220.15]:55684 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751390AbWIIVbV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Sep 2006 17:31:21 -0400
Date: Sat, 9 Sep 2006 14:30:54 -0700
From: Greg KH <greg@kroah.com>
To: Thomas Maier <balagi@justmail.de>
Cc: Phillip Susi <psusi@cfl.rr.com>, linux-kernel@vger.kernel.org,
       "petero2@telia.com" <petero2@telia.com>
Subject: Re: [PATCH] pktcdvd: added sysfs interface + bio write queue handling fix
Message-ID: <20060909213054.GC19188@kroah.com>
References: <op.tfkmp60biudtyh@master> <20060908210042.GA6877@kroah.com> <4501E33B.50204@cfl.rr.com> <20060908220129.GB20018@kroah.com> <op.tfmh56j9iudtyh@master>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <op.tfmh56j9iudtyh@master>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 09, 2006 at 08:11:56PM +0200, Thomas Maier wrote:
> Hello,
> 
> >> +    write_queue_size  (r)  Contains the size of the bio write
> >> +                           queue.
> ...
> >> +    mapped_to              Symbolic link to mapped block device
> >> +                           in the /sys/block tree.
> >
> > Shouldn't this whole thing be in /sys/class/ instead of /sys/block/ ?
> 
> Don't know. I thought, the pktcdvd is a block driver, so put
> the control files into /sys/block ..
> Is /sys/class better? If yes, where to put it?

Use /sys/class/pktcdvd/ and use struct device instead of struct
class_device, so I don't have to convert the code later :)

> > On Fri, Sep 08, 2006 at 05:40:11PM -0400, Phillip Susi wrote:
> >> Greg KH wrote:
> >> >On Fri, Sep 08, 2006 at 07:55:08PM +0200, Thomas Maier wrote:
> >> >>+/sys/block/pktcdvd/<pktdevname>/packet/
> >> >>+    statistic         (r)  Show device statistic. One line with
> >> >>+                           5 values in following order:
> >> >>+                              packets-started
> >> >>+                              packets-end
> >> >>+                              written in kB
> >> >>+                              read gather in kB
> >> >>+                              read in kB
> >> >
> >> >Please no.  One value per file is the sysfs rule.
> >> >
> >>
> >> Except in cases like this where you want to read the status of the
> >> device at a given point in time, and you can't do that unless you grab
> >> all the values at once.
> >
> > Then don't use sysfs for that.  And is something like this as critical
> > to get that kind of information all in one atomic chunk?  It seems
> > merely to be informational.
> 
> The "statistic" and "info" files are only for information purpose.

Then please split them up into individual files.

> Into /proc ? No. (i read somewhere /proc should only contain process
> information in future)

Exactly.

> In debugfs? Hmm, this files should be infos that users should be able
> to read, no debug output.

Ok, then multiple files please.

> Is it ok, if i split the "statistic" into 5 files, and put the "info"
> into debugfs ?

Yes, that would be fine.

thanks,

greg k-h
