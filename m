Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263839AbTDNUUP (for <rfc822;willy@w.ods.org>); Mon, 14 Apr 2003 16:20:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263858AbTDNUUO (for <rfc822;linux-kernel-outgoing>);
	Mon, 14 Apr 2003 16:20:14 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.104]:60836 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263839AbTDNUUI (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Apr 2003 16:20:08 -0400
Date: Mon, 14 Apr 2003 13:33:28 -0700
From: Greg KH <greg@kroah.com>
To: oliver@neukum.name
Cc: linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [RFC] /sbin/hotplug multiplexor
Message-ID: <20030414203328.GA5191@kroah.com>
References: <20030414190032.GA4459@kroah.com> <200304142116.45303.oliver@neukum.org> <20030414195438.GA4952@kroah.com> <200304142209.56506.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200304142209.56506.oliver@neukum.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 14, 2003 at 10:09:56PM +0200, Oliver Neukum wrote:
> Am Montag, 14. April 2003 21:54 schrieb Greg KH:
> > On Mon, Apr 14, 2003 at 09:16:45PM +0200, Oliver Neukum wrote:
> > > > Any objections or comments?  If not, I'll make the changes in the
> > > > linux-hotplug project and release a new version based on this.
> > >
> > > Yes, consider what this does if you connect to a FibreChannel
> > > grid. You are pushing system load by at least an order of magnitude.
> >
> > When you add a FibreChannel grid, the devices are discovered in
> > sequential order, with SCSI IO happening between each device discovered.
> > In talking to the SCSI people, that should be about 30ms per device
> > found at the quickest.  So there's no /sbin/hotplug process storm :)
> >
> > And even if there is, we have to be able to handle such a load under
> > normal situations anyway :)
> 
> Well, plugging them in is one case. But what is plugged in, will
> eventually be unplugged as well. That will not require probing.
> 
> Now let's be conservative and assume 16KB unswappable memory
> per task. Now we take the famous 4000 disk case. 64MB. A lot
> but probably not deadly. But multiply this by 15 and the machine is
> absolutely dead.

Ok, then the "Enterprise Edition" of the distros that expect to handle
4000 disks will have to add the following patch to their version of the
hotplug package.

In the meantime, the other 99% of current Linux users will exist just
fine :)

greg k-h


--- hotplug.orig	2003-04-14 13:27:28.513429040 -0700
+++ hotplug	2003-04-14 13:27:40.862551688 -0700
@@ -2,7 +2,7 @@
 DIR="/etc/hotplug.d"
 
 for I in "${DIR}/"* ; do
-	$I $1 &
+	$I $1
 done
 
 exit 1
