Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132949AbRDRCpK>; Tue, 17 Apr 2001 22:45:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132961AbRDRCot>; Tue, 17 Apr 2001 22:44:49 -0400
Received: from adsl-63-195-162-81.dsl.snfc21.pacbell.net ([63.195.162.81]:46601
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S132949AbRDRCoj>; Tue, 17 Apr 2001 22:44:39 -0400
Date: Tue, 17 Apr 2001 19:44:29 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Wilfried Weissmann <Wilfried.Weissmann@gmx.at>
cc: Arjan van de Ven <arjan@fenrus.demon.nl>,
        Paul Flinders <P.Flinders@ftel.co.uk>, linux-kernel@vger.kernel.org,
        Neil Brown <neilb@cse.unsw.edu.au>
Subject: Re: Help with Fasttrack/100 Raid on Linux
In-Reply-To: <3ADC33B4.E2ADF8AC@gmx.at>
Message-ID: <Pine.LNX.4.10.10104171921300.23608-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Apr 2001, Wilfried Weissmann wrote:

> Andre Hedrick wrote:
> > 
> > Wilfried,
> > 
> > Why a module?
> 
> The idea behind that was that, if it is a seperate module, then it would be easier to maintain for
> me. I am a guy that always needs the newest and greatest, so I expected that I would have to port my
> stuff to newer kernels frequently. (I started the HPT-RAID0 alone without much knowledge about the
> kernel.)
> 
> > Why not have the detection and flags that hook the md driver for linux and
> > use linux's software raid?
> 
> I could not use the disk striping, because of the raid0 code is not capable of processing a request
> what would span more than one disk. You also have to shift the offset of all but the first disk by
> 10 sectors. So I created an own personality...
> 
> I also guess it would be a bit complicated if we want to create a raid10. Is this done by putting a
> raid1 over raid0 devices? We would have to find a way to map the sectors according to the IDE-RAID
> spec of the controller over several raid levels.
> An ataraid personality would be easier and more flexible then.
> 
> regards,
> Wilfried

Hello Wilfried,

The really easy thing to do is to come up with the personality rules you
want to se and let me create the API.  I can make drives talk, listen,
dance, spin, flip, etc.....

Raid 0 and Raid 1 are cakewalks, if you have the right tools.
These will be around in 2.5.

All you need to do is tell me what you want the subsystem to do.
When you want it done and the observer's view of the operations.

I can do things like threaded-parallel PRD building for DMA with the tap
of a keystroke of two.  I can commit the purfect lie in storage and
destroke a drive to the view of the OS and then do switch-buffer PRD
building.  If you want it on 2,3,4,N drives I can do it with fast simple
legal trick code.

During INIT process I can protect the drive in ways you have never
considered.  I can access the whole drive even of the OS only knows only a
portion of the real capacity.  And I do not need silly and foolosh means
like "bread".  I tell it, "Hey dude, we are running under a lie.  Go sneak
off to the head or tail of the drive and get me that raid-voodoo-bios-os
communication transport layer, and do it ins DMA modes, NOW!"

I do not have the desire to do personality tables, but I can.

We will not need any new majors because there is plenty of space in the
ones we have, and 128 minors/channel is enough to do anything.

If you want to do your module cool, but I promise you it will break in 2.5
and you will not know for months what hit you.  I personally would like to
avoid this issue of wreckin work.  Second, if you think changes to the
driver made by you have a chance in hell to make the kernel, I am not
allowed to fixed the driver today to address the needs and correct current
issues and ones coming down the pipe.

With about 96% of all linux boxes in the world dependent on some form of
ATA/ATAPI, Linus and Alan are very sensitive to even the sligthest change.

Cheers,

Andre Hedrick
Linux ATA Development
ASL Kernel Development
-----------------------------------------------------------------------------
ASL, Inc.                                     Toll free: 1-877-ASL-3535
1757 Houret Court                             Fax: 1-408-941-2071
Milpitas, CA 95035                            Web: www.aslab.com

