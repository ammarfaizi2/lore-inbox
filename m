Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261541AbSJDJ0E>; Fri, 4 Oct 2002 05:26:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261542AbSJDJ0D>; Fri, 4 Oct 2002 05:26:03 -0400
Received: from mail.zedat.fu-berlin.de ([130.133.1.48]:47141 "EHLO
	Mail.ZEDAT.FU-Berlin.DE") by vger.kernel.org with ESMTP
	id <S261541AbSJDJZ6>; Fri, 4 Oct 2002 05:25:58 -0400
Message-Id: <m17xOnh-006hxUC@Mail.ZEDAT.FU-Berlin.DE>
Content-Type: text/plain; charset=US-ASCII
From: Oliver Neukum <oliver@neukum.name>
To: Greg KH <greg@kroah.com>
Subject: Re: [Evms-devel] Re: EVMS Submission for 2.5
Date: Fri, 4 Oct 2002 10:07:24 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Alexander Viro <viro@math.psu.edu>, Kevin Corry <corryk@us.ibm.com>,
       linux-kernel@vger.kernel.org, evms-devel@lists.sourceforge.net
References: <20021003161320.GA32588@kroah.com> <m17xENj-006iAZC@Mail.ZEDAT.FU-Berlin.DE> <20021003225635.GE2289@kroah.com>
In-Reply-To: <20021003225635.GE2289@kroah.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 04 October 2002 00:56, Greg KH wrote:
> On Thu, Oct 03, 2002 at 11:02:36PM +0200, Oliver Neukum wrote:
> > Perhaps this is a misunderstanding.
> > You need to report changes of the actual physical medium of eg. a zip
> > drive. How you want to do this from a class driver, I fail to see.
>
> When a "medium" goes away from the system, it is unregistered somehow,
> right?  So, in the disk class, that device would disappear, and cause
> the /sbin/hotplug event.

Well, sadly this is not the case. You can put a medium into a drive and
pull it out without the kernel ever noticing. Unless of course you try to use
the thing. But even in this case there's no hotplug event.
Yet user space and evms have to learn about it in the long term.
Changing a medium can mean that a new type of medium is inserted.
A modern zip drive goes from 100M(ro) to 250M(rw) and even 750M(rw)
We need to know and report.

> This is assuming that we can detect media changes, which is a whole
> different topic that I don't want to get involved with :)

Your wishes you are entiteled to ;-) Unfortunately this is not a viable 
position speaking long term.

> > Beside that you need of course to report things like iscsi which have
> > volumes, but not really devices.
>
> But iscsi registers these "volumes" with the scsi layer, right?  If so,
> everything is fine (take a look at the driverfs scsi tree right now,
> it's a bit messy, but you get the idea.).  If iscsi doesn't register
> these volumes with the scsi layer, how does the scsi layer know to talk
> to them?

I'll look at the source.

> In other words, if the kernel knows about a type of device, which I'm
> pretty sure it has to in order to talk to it, that device will generate
> /sbin/hotplug events when it shows up and is removed.
>
> As for implementation details, if you see a type of device right now
> that does not generate these kinds of events, please let me know.

Device management is all right, but volume management operates at the
medium level, or rather in between. What do you do if somebody adds drives
to a SCSI-RAID converter.
Evms currently polls on demand. I see no way to do it differently with
the present infrastructure.

	Regards
		Oliver
