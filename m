Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261294AbSJLRIm>; Sat, 12 Oct 2002 13:08:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261295AbSJLRIm>; Sat, 12 Oct 2002 13:08:42 -0400
Received: from f87.pav2.hotmail.com ([64.4.37.87]:35849 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S261294AbSJLRIl>;
	Sat, 12 Oct 2002 13:08:41 -0400
X-Originating-IP: [66.68.32.168]
From: "Mark Peloquin" <markpeloquin@hotmail.com>
To: hch@infradead.org
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com,
       evms-devel@lists.sf.net
Subject: Re: Linux v2.5.42
Date: Sat, 12 Oct 2002 12:14:25 -0500
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <F87rkrlMjzmfv2NkkSD000144a9@hotmail.com>
X-OriginalArrivalTime: 12 Oct 2002 17:14:25.0524 (UTC) FILETIME=[D0A4E340:01C27212]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2002-10-12 13:32:33, Christoph Hellwig wrote:
> > On Fri, Oct 11, 2002 at 09:59:58PM -0700, Linus Torvalds wrote:
> > PS: NOTE - I'm not going to merge either EVMS or LVM2 right now > as 
>things
> > stand.  I'm not using any kind of volume management personally, so > > I 
>just
> > don't have the background or inclination to walk through the > patches 
>and
> > make that kind of decision. My non-scientific opinion is that it > looks 
> > like the EVMS code is going to be merged, but ..
> > > Alan, Jens, Christoph, others - this is going to be an area where > > 
>I need
> > input from people I know, and preferably also help merging. I've > been 
> > happy to see the EVMS patches being discussed on linux-kernel, and > > I 
>just > wanted to let people know that this needs outside help.

>I don't think the work to get EVMS in shape can be done in time > (feel
>free to preove me wrong..).

Should EVMS be included, the team will make it our top priority to resolve 
the disputed design issues. If the ruling should be that some of our design 
decisions must change, so be it, we will comply. Certainly some changes can 
not be done by the 20th or 31st, however I feel the team can handle most 
changes before 2.6 ships.

>The problem in my eyes is that large
>parts of what evms does should be in the higher layers, i.e. the
>block layer, but they implement their own new layer as the consumer > of
>those.  i.e. instead of using the generic block layer structures to
>present a volume/device they use their own,

More accurately, we do use generic block layers structures to present 
volumes that are visible to the user/system.

>private structures that
>need hacks to get the access right (pass-through ioctls) and need
>constant resyncing with the native structures in the case where we
>have both (the lowest layer).

The point of contention is that EVMS does not provide generic access (block 
layer operations) to the components that make up the volume, but only to the 
user/system accessible volumes themselves. EVMS consumes (primarily disk) 
devices and produces volumes. The intermediate points are abstracted by the 
volume manager.

>IMHO we should try to get a common
>userspace API in first, then implement the missing functionality for
>properly interaction of voulme managers at the block layer.  After
>that EVMS would just be a set of coulme mangment drivers + a library
>of common functionality.

>Doing that higher level work will take some time to get right, and the
>current EVMS API seems unsuitable for me, it contains lots of very#
>strange APIs that need rework.  Merging EVMS now for 2.6 means that
>we'll have to keep those strange APIs around, and have to maintain
>backwards-compatiblity.

I guess it comes down to the point of whether the block layer should evolve 
to also handle volume management generically, or whether volume management 
is separate component that utilizes and works with the block layer.

Linus, if you feel that volume management and the block layer can and should 
be separate components that work together, then EVMS is ready today, and at 
least functionally, could be a pretty good starting point. As a separate 
component, only the EVMS tools would have to know or care of the new EVMS 
APIs. The volumes EVMS produces, being standard block devices, interface, 
interact, and operate as any other block device does today.

Mark

_________________________________________________________________
MSN Photos is the easiest way to share and print your photos: 
http://photos.msn.com/support/worldwide.aspx

