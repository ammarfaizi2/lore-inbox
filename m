Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261430AbSJCWxz>; Thu, 3 Oct 2002 18:53:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261431AbSJCWxz>; Thu, 3 Oct 2002 18:53:55 -0400
Received: from 12-231-242-11.client.attbi.com ([12.231.242.11]:30221 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S261430AbSJCWxw>;
	Thu, 3 Oct 2002 18:53:52 -0400
Date: Thu, 3 Oct 2002 15:56:35 -0700
From: Greg KH <greg@kroah.com>
To: Oliver Neukum <oliver@neukum.name>
Cc: Alexander Viro <viro@math.psu.edu>, Kevin Corry <corryk@us.ibm.com>,
       linux-kernel@vger.kernel.org, evms-devel@lists.sourceforge.net
Subject: Re: [Evms-devel] Re: EVMS Submission for 2.5
Message-ID: <20021003225635.GE2289@kroah.com>
References: <20021003161320.GA32588@kroah.com> <m17xDXf-006hxpC@Mail.ZEDAT.FU-Berlin.DE> <20021003213736.GA1388@kroah.com> <m17xENj-006iAZC@Mail.ZEDAT.FU-Berlin.DE>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m17xENj-006iAZC@Mail.ZEDAT.FU-Berlin.DE>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 03, 2002 at 11:02:36PM +0200, Oliver Neukum wrote:
> Perhaps this is a misunderstanding.
> You need to report changes of the actual physical medium of eg. a zip drive.
> How you want to do this from a class driver, I fail to see.

When a "medium" goes away from the system, it is unregistered somehow,
right?  So, in the disk class, that device would disappear, and cause
the /sbin/hotplug event.

This is assuming that we can detect media changes, which is a whole
different topic that I don't want to get involved with :)

> Beside that you need of course to report things like iscsi which have
> volumes, but not really devices.

But iscsi registers these "volumes" with the scsi layer, right?  If so,
everything is fine (take a look at the driverfs scsi tree right now,
it's a bit messy, but you get the idea.).  If iscsi doesn't register
these volumes with the scsi layer, how does the scsi layer know to talk
to them?

In other words, if the kernel knows about a type of device, which I'm
pretty sure it has to in order to talk to it, that device will generate
/sbin/hotplug events when it shows up and is removed.

As for implementation details, if you see a type of device right now
that does not generate these kinds of events, please let me know.

thanks,

greg k-h
