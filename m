Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262597AbSJLBVv>; Fri, 11 Oct 2002 21:21:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262610AbSJLBVv>; Fri, 11 Oct 2002 21:21:51 -0400
Received: from pc132.utati.net ([216.143.22.132]:21411 "HELO
	merlin.webofficenow.com") by vger.kernel.org with SMTP
	id <S262597AbSJLBVt>; Fri, 11 Oct 2002 21:21:49 -0400
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@trommello.org>
To: Hans Reiser <reiser@namesys.com>
Subject: Re: The reason to call it 3.0 is the desktop (was Re: [OT] 2.6 not 3.0 - (NUMA))
Date: Fri, 11 Oct 2002 16:26:54 -0400
X-Mailer: KMail [version 1.3.1]
Cc: "Martin J. Bligh" <mbligh@aracnet.com>, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0210041610220.2465-100000@home.transmeta.com> <200210060130.g961UjY2206214@pimout2-ext.prodigy.net> <3DA7647C.3060603@namesys.com>
In-Reply-To: <3DA7647C.3060603@namesys.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20021012012807.1BB5B635@merlin.webofficenow.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 11 October 2002 07:53 pm, Hans Reiser wrote:
> Rob Landley wrote:
> >The new uncharted territory for Linux, and the next major
> > order-of-magnitude jump in the installed base, is the desktop.  A kernel
> > that could make a credible stab at the desktop  would certainly be 3.0
> > material.  And the work that matters for the desktop  is LATENCY work. 
> > Not SMP, not throughput, not more memory.  Latency.  O(1), deadline I/O
> > scheduler, rmap, preempt, shorter clock ticks,
>
> I must confess to thinking that namespace work is the most strategic
> upcoming battle between Linux and Windows, but probably I am biased in
> this regard.;-)  MS seems to think it also, given the rumors that OFS is
> where they are shifting their focus away from the browser and over to
> for Longhorn....

If you're talking about driverfs (kfs, kernelfs, kernfs...  i think my vote 
really is for patfs here, actually :), it is indeed seriously cool, but most 
of it's potential coolness rather than active (kinetic?) coolness.  It's 
infrastructure for cool things to be built on top of.

For example,  handling removable media and transient network resources has 
always been a bit of a sore spot for unix derivatives.   "mount' doesn't 
combine well with ejecting a floppy, and hacks like mcopy would have to be 
built into the shell, or some kind of library to be sufficiently generic.  
(Your web browser can't right click->save as to "a:".)  And most cd-roms I've 
tried still won't eject when you hit the button unless you unmount the 
filesystem first.  there was talking about fixing this back in 2.3.  Can't 
say i've really thumped on it in 2.5, IDE hasn't been working long enough 
yet.  NFS has a "don't hang my entire OS" mount option, which I'm told is a 
kludge of biblical proportions, but I've mostly stayed away from NFS, so I 
really couldn't say.)

MS has been trying and failing to have a coherent naming policy for years.  
Two years ago, the active directory hype.  I still haven't seen a better 
naming system than the amiga (where you could dynamically create a ramdisk by 
just copying something to "ram:", that was cool.)

A little side project I'm working on now (in my copious free time) is mount 
point relocation support.  (You can mount the same filesystem a second time 
in another location (mount --bind makes this easy), and they share a 
superblock so open files should be happy, but you still can't detach the 
first mount point.  Not with a hacksaw, or explosives...)  It's more an 
excuse to learn the new VFS layer than anything else, but it's functionality 
I would in fact have a use for, strange enough...

I'm also looking for an "unmount --force" option that works on something 
other than NFS.  Close all active filehandles (the programs using it can just 
deal with EBADF or whatever), flush the buffers to disk, and unmount.  None 
of this "oh I can't do that, you have a zombie process with an open file...", 
I want  "guillotine this filesystem pronto, capice?" behavior.

Of course loopback mounts would be kind of upset about this, but to be 
honest: tough.  The loopback block device gives them an I/O error, and the 
filesystem should just cope.  Floppies do this all the time with dust and cat 
hair and stuff...

Of course I don't yet know 1/10 as much about the VFS as I need to, but I'm 
learning.  Slowly...

Rob
