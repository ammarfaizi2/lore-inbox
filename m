Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261720AbSJCPc2>; Thu, 3 Oct 2002 11:32:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261721AbSJCPc2>; Thu, 3 Oct 2002 11:32:28 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:692 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S261720AbSJCPc0>;
	Thu, 3 Oct 2002 11:32:26 -0400
Date: Thu, 3 Oct 2002 11:37:33 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Kevin Corry <corryk@us.ibm.com>
cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org,
       evms-devel@lists.sourceforge.net
Subject: Re: EVMS Submission for 2.5
In-Reply-To: <02100309534906.05904@boiler>
Message-ID: <Pine.GSO.4.21.0210031130560.15787-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 3 Oct 2002, Kevin Corry wrote:

> On Thursday 03 October 2002 09:51, Alexander Viro wrote:
> > On Thu, 3 Oct 2002, Kevin Corry wrote:
> > > > IOW, the real question is what are you going to do with that list of
> > > > gendisks?
> > >
> > > EVMS will try to read volume metadata from each device and activate
> > > volumes if it finds any pertinent metadata.
> >
> > _Ouch_.  "Each" as in...?  E.g. do you want to do that for floppies? 
> > Cdroms? EVMS volumes themselves?  Things like /dev/loop? (and if yes, at
> > which point do you do that?)
> 
> EVMS can filter out devices that don't make sense to probe for volumes. 
> Currently it ignores such things as floppies and cd-roms, as well as EVMS 
> volumes. We have actually added the ability to probe loop devices, though, 
> since we had several requests for that functionality.

How does it recognize cdroms?  Explicit list of majors?  Doesn't work for
IDE and I'm fairly sure that it doesn't catch all exotic ones.  Basically,
I don't believe that any methods based on keeping a registry of bad device
numbers are viable - if that information belongs anywhere, it's in drivers.

IMO the right way is to have driver set properties of gendisk and stuff
like partition-related devfs/driverfs code, RAID, evms, etc. to check
that.  _If_ we handle that stuff in the kernel, that is.

The question being, what property are you looking for?  "I'm suitable for
EVMS" is not an answer, obviously...

As for the loop...  At which point do you want to notice it?  Notice that
it can be opened earlier than anything could be read from it.

