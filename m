Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266528AbUBGC4k (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Feb 2004 21:56:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266529AbUBGC4k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Feb 2004 21:56:40 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:39054 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266528AbUBGC4j
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Feb 2004 21:56:39 -0500
Date: Sat, 7 Feb 2004 02:56:38 +0000
From: viro@parcelfarce.linux.theplanet.co.uk
To: Linus Torvalds <torvalds@osdl.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.3-rc1
Message-ID: <20040207025638.GW21151@parcelfarce.linux.theplanet.co.uk>
References: <Pine.LNX.4.58.0402061823040.30672@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0402061823040.30672@home.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 06, 2004 at 06:28:13PM -0800, Linus Torvalds wrote:
> 
> Ok, this is another big merge of a number of pending patches, although to 
> some degree the patches have now moved "outwards" from the core, and most 
> of them are in driver land.
> 
> There's a lot of network driver updates (have been in -mm and Jeff's 
> testing trees for a while), and Al Viro has been fixing up not just 
> network drivers, but also cursing over parport interfaces ;)
> 
> Andrew's patches are all over, from fixing warnings with new versions of
> gcc to merging things like the ppc updates he had in his tree, and 
> everything in between.
> 
> On and a big ALSA update, along with SCSI updates (big qla update, for
> example).
> 
> So let's calm down and make sure all the updates are ok.

One note: please, please, let's put a moratorium on sysfs-related patches
that didn't go through review.  We are just getting netdev situation in
the main tree under control.  It took nearly half a year (if not more).
And now we've got *exact* *copy* of the change that had started that mess -
this time in fbdev.  Sure, there's fewer fbdev drivers, so it shouldn't
take that long.  But then it's not 2.5 anymore...

If you are doing any sysfs integration - *fix* *lifetime* *rules* *first*.
You can do that in a way that will avoid breakage or need to revisit the
drivers when kobjects get embedded - just have your my_subsystem_release()
defined as kfree() and on the last step replace its body with kobject_put(),
moving the actual freeing into ->release().

Even if you are sure that you can fix all drivers in one go, there's no
need to turn the entire series into "must merge at once" monster - if nothing
else, reordering it that way will make testing easier.  Sigh...
