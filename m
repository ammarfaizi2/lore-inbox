Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261370AbSJCQKg>; Thu, 3 Oct 2002 12:10:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261638AbSJCQKg>; Thu, 3 Oct 2002 12:10:36 -0400
Received: from 12-231-242-11.client.attbi.com ([12.231.242.11]:38668 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S261370AbSJCQKf>;
	Thu, 3 Oct 2002 12:10:35 -0400
Date: Thu, 3 Oct 2002 09:13:20 -0700
From: Greg KH <greg@kroah.com>
To: Kevin Corry <corryk@us.ibm.com>, linux-kernel@vger.kernel.org,
       evms-devel@lists.sourceforge.net
Cc: Alexander Viro <viro@math.psu.edu>, torvalds@transmeta.com
Subject: Re: EVMS Submission for 2.5
Message-ID: <20021003161320.GA32588@kroah.com>
References: <02100308045305.05904@boiler> <Pine.GSO.4.21.0210031042210.15787-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.21.0210031042210.15787-100000@weyl.math.psu.edu>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 03, 2002 at 10:51:39AM -0400, Alexander Viro wrote:
> 
> 
> On Thu, 3 Oct 2002, Kevin Corry wrote:
> 
> > > I might agree with something along the lines of
> > > 	* when evms is initialized, it's notified of all existing gendisks
> > > 	* whenever disk is added after evms initialization, we notify evms
> > > 	* whenever disk is removed, we notify evms
> > 
> > This sounds like it would be exactly what EVMS needs. The only thing we would 
> > want to add to this list is: "*whenever a disk is modified, notify evms". For 
> > example, with removable media drives (such as Zip and Jaz), when a cartidge 
> > is changed, the capacity of the drive might change, and we would like to be 
> > notified of that event.
> 
> Umm...  OK.  There were some plans to add a notifier chain for such events
> and EVMS looks like a possible user of that beast.  However, it's not
> obvious whether we need to do any of that in the kernel - we definitely
> can have userland up and running before _any_ block devices are initialized,
> so it might be a work for userland helper.

/sbin/hotplug already gets called for _every_ device that is added to
the system as of 2.5.40, so you should probably use that as your
userspace notifier event.  If there's anything that the /sbin/hotplug
call misses, that you need for evms, please let me know.

thanks,

greg k-h
