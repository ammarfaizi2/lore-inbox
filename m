Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262005AbREPQ4p>; Wed, 16 May 2001 12:56:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262006AbREPQ4f>; Wed, 16 May 2001 12:56:35 -0400
Received: from [206.14.214.140] ([206.14.214.140]:60683 "EHLO
	www.transvirtual.com") by vger.kernel.org with ESMTP
	id <S262005AbREPQ40>; Wed, 16 May 2001 12:56:26 -0400
Date: Wed, 16 May 2001 09:55:59 -0700 (PDT)
From: James Simmons <jsimmons@transvirtual.com>
To: Miles Lane <miles@megapathdsl.net>
cc: Tim Jansen <tim@tjansen.de>, David Brownell <david-b@pacbell.net>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: LANANA: To Pending Device Number Registrants
In-Reply-To: <989973690.925.7.camel@agate>
Message-ID: <Pine.LNX.4.10.10105160936570.17255-100000@www.transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > At this point of the discussion I would like to point to the Device Registry 
> > patch (http://www.tjansen.de/devreg) that already solves these problems and 
> > offers stable device ids for the identification of devices and finding their 
> > /dev nodes.
> 
> Does your approach solve the problem of USB devices, like mice, that
> don't have device ID's of any sort, where topology is the only way to 
> distinguish them?  IIRC, the USB development team was planning to use
> topology to provide a limited ability to associate a mouse on a given
> port with a display, when XFree86 supports per-Xinerama-display input
> device associations.
> They new VT console work would benefit from this, too.

    I have been thinking about this. If you think about it multi-desktop
systems are very similar to clustering. The idea is something can only be
seen by certain things in the system. With clustering you might want
a shared memeory segment (/dev/shm) visble to certain NUMA nodes. With
multi-desktop systems you have several users using the same box. Now you
don't want to user 3 being able to draw something to users 2 screen. 
    So how do you handle this? Since we are treating the device as a
filesystem we can control the permissons on all the files in the
filesystem. This gives the extra bonus of the ability to make certain
device features global to certain groups. The best way I can see it is 
to setup workstation groups. This is pretty easy to do with most systems
since most have a group per user. So for desktop one you have it belong to
user joe. So when he want to some device on his machine he mounts the
filesystem and all the files and directories belong to joe. No one else
can use that device. Now what if you want several people to be able to use
the same desktop. The sys admin could create a desktop1 group and then
ensure the device is mounted with the desktop1 group. Then anyone
belonging to the desktop group can access this hardware. The extra bonus
is the ability to allow certain feature of a device to be exposed to same
someone in your group. This could be a really powerful feature.
Unfortunely I can't think of a example off the top of my head.

