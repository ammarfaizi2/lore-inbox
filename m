Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261437AbTEEWD3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 18:03:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261444AbTEEWD3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 18:03:29 -0400
Received: from vladimir.pegasys.ws ([64.220.160.58]:50956 "HELO
	vladimir.pegasys.ws") by vger.kernel.org with SMTP id S261437AbTEEWDR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 18:03:17 -0400
Date: Mon, 5 May 2003 15:12:38 -0700
From: jw schultz <jw@pegasys.ws>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: processes stuck in D state
Message-ID: <20030505221238.GD14677@pegasys.ws>
Mail-Followup-To: jw schultz <jw@pegasys.ws>,
	linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.33.0305051122190.20491-100000@bunny.augustahouse.net> <200305051826.01134.fsdeveloper@yahoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200305051826.01134.fsdeveloper@yahoo.de>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 05, 2003 at 06:25:48PM +0200, Michael Buesch wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> On Monday 05 May 2003 17:24, Mike Waychison wrote:
> > On Mon, 5 May 2003, Michael Buesch wrote:
> > > On Monday 05 May 2003 07:52, Zeev Fisher wrote:
> > > > Hi!
> > >
> > > Hi Zeev!
> > >
> > > > I got a continuos problem of unkillable processes stuck in D state (
> > > > uninterruptable sleep ) on my Linux servers.
> > > > It happens randomly every time on other server on another process ( all
> > > > the servers are configured the same with 2.4.18-10 kernel ). Here's an
> > > > example :
> > >
> > > [snip]
> > >
> > > > Has anyone noticed the same behavior ? Is this a well known problem ?
> > >
> > > I've had the same problem with some 2.4.21-preX twice (or maybe more
> > > times, don't remember) on one of my machines.
> > > IMHO it has something to do with NFS. (I'm using this box as a
> > > NFS-client). I wish, I could reproduce it one more time, to do some
> > > traces, etc on it. But I've not found a way to reproduce it, yet.
> >
> > This happens when you mount an NFS mount with the 'hard' option (default)
> > and a mount's handle expires incorrectly (eg: server crash).
> > Read the mount manpage for an explanation to the downsides of using
> > the 'soft' option.
> >
> >
> > Mike Waychison
> 
> my fstab-entry:
> 192.168.0.50:/mnt/nfs_1 /mnt/nfs_1      nfs             rw,hard,intr,user,nodev,nosuid,exec         0 0
> 
> from man mount:
> [snip] The process cannot be interrupted or killed unless you also specify intr. [/snip]
> 
> I can't interrupt any process that accessed the NFS-server
> while shutting down the server, although intr is specified.
> _That's_ my problem. :)

I had a similar problem with SuSE's 2.4.18.  Random processes
seemed to go into D state from whence intr is useless.

I rebuilt the kernel with NFSv3 disabled and that problem
went away.  The logs are full of
    May  5 14:54:15 duncan kernel: NFS: NFSv3 not supported.
    May  5 14:54:15 duncan kernel: nfs warning: mount version older than kernel
but that i can live with.  Processes hung and umount failing
i cannot abide.

If there is a better answer, i'm listening.


-- 
________________________________________________________________
	J.W. Schultz            Pegasystems Technologies
	email address:		jw@pegasys.ws

		Remember Cernan and Schmitt
