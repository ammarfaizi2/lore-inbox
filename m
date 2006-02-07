Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965103AbWBGPHu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965103AbWBGPHu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 10:07:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965123AbWBGPHu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 10:07:50 -0500
Received: from ogre.sisk.pl ([217.79.144.158]:692 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S965117AbWBGPHt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 10:07:49 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Nigel Cunningham <nigel@suspend2.net>
Subject: Re: Which is simpler? (Was Re: [Suspend2-devel] Re: [ 00/10] [Suspend2] Modules support.)
Date: Tue, 7 Feb 2006 16:09:04 +0100
User-Agent: KMail/1.9.1
Cc: Pavel Machek <pavel@ucw.cz>, Bojan Smojver <bojan@rexursive.com>,
       Lee Revell <rlrevell@joe-job.com>, linux-kernel@vger.kernel.org,
       suspend2-devel@lists.suspend2.net
References: <20060201113710.6320.68289.stgit@localhost.localdomain> <20060207004448.GC1575@elf.ucw.cz> <200602071105.45688.nigel@suspend2.net>
In-Reply-To: <200602071105.45688.nigel@suspend2.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602071609.05676.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tuesday 07 February 2006 02:05, Nigel Cunningham wrote:
> On Tuesday 07 February 2006 10:44, Pavel Machek wrote:
> > Are you Max Dubois, second incarnation or what?
> >
> > > Well, given that the kernel suspend is going to be kept for a while,
> > > wouldn't it be better if it was feature full? How would the users be
> > > at
> >
> >                                                
> > ~~~~~~~~~~~~~~~~~~~~~~~~~
> >
> > > a disadvantage if they had better kernel based suspend for a while,
> >
> > ~~~~~~~~~~~~~~~~
> >
> > > followed by u-beaut-cooks-cleans-and-washes uswsusp? That's the part I
> > > don't get...
> >
> > *Users* would not be at disadvantage, but, surprise, there's one thing
> > more important than users. Thats developers, and I can guarantee you
> > that merging 14K lines of code just to delete them half a year later
> > would drive them crazy.
> 
> It would more be an ever-changing interface that would drive them crazy. So 
> why don't we come up with an agreed method of starting a suspend and 
> starting a resume that they can use, without worrying about whether 
> they're getting swsusp, uswsusp or Suspend2? /sys/power/state seems the 
> obvious choice for this. An additional /sys entry could perhaps be used to 
> modify which implementation is used when you echo disk > /sys/power/state 
> - something like
> 
> # cat /sys/power/disk_method
> swsusp uswsusp suspend2
> # echo uswsusp > /sys/power/disk_method
> # echo > /sys/power/state
> 
> Is there a big problem with that, which I've missed?

Userland suspend is driven by the suspending application which only calls
the kernel to do things it cannot do itself, like freezing (the other)
processes, snapshotting the system etc.  We use the /dev/snapshot
device and the ioctl()s in there, so no sysfs files are needed for that.
It's independent and can coexist with the existing sysfs interface
just fine.

Greetings,
Rafael
