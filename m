Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129032AbRBHBCh>; Wed, 7 Feb 2001 20:02:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130682AbRBHBC3>; Wed, 7 Feb 2001 20:02:29 -0500
Received: from rhinocomputing.com ([161.58.241.147]:9733 "EHLO
	rhinocomputing.com") by vger.kernel.org with ESMTP
	id <S129032AbRBHBCO>; Wed, 7 Feb 2001 20:02:14 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14977.61456.680691.926157@rhino.thrillseeker.net>
Date: Wed, 7 Feb 2001 20:02:08 -0500 (EST)
From: Billy Harvey <Billy.Harvey@thrillseeker.net>
To: linux-kernel@vger.kernel.org, linux-crypto@humbolt.nl.linux.org
Subject: Re: 2.4.1-ac5 - The loopback hang saga continues
In-Reply-To: <gandalf@winds.org> Wednesday, 7 February 2001 17:45:13 -0500
In-Reply-To: <Pine.LNX.4.21.0102071723090.7611-100000@winds.org>
X-Mailer: VM 6.75 under 21.1 (patch 14) "Cuyahoga Valley" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > It appears that the loopback-hang parasite is alive and well in 2.4.1-ac5.
 > I've done several tests and I thus provide the following information:
 > 
 > The bug is independent of UP or SMP configured.. it hung both ways, but the
 > box itself is UP.
 > 
 > It appears to hang when internal buffers get filled. The way I see it, copying
 > files from disk to the loopback device (which is a file on the same disk)
 > begins to read from the disk. When the internal read buffer is full, the
 > kernel's queued writes start activating and the data gets copied to the
 > loopback file. This process repeats over and over, as it should normally.
 > 
 > Sometimes however, during a read from the disk, it fills up its buffers and
 > then never makes the accompanying write. In fact, the entire device freezes on
 > the read.
 > 
 > I was able to lessen the frequency of hanging by using the -v flag and tapping
 > ^S and ^Q to temporarily 'pause' copying. This ensures that the read buffer
 > will never become full to the point where it could cause the hang, and appears
 > to work -- until it came across the libc.a file. There was no way to pause it
 > here because nothing is being outputted to the screen while it's copying
 > libc.a. Unfortunately, it fills the buffer too quick and hangs 100% every time.
 > The disk is totally nonresponsive at this point, and a hard reset is necessary.
 > 
 > I hope this helps anyone who is still tracking down the loopback problem.
 > 
 > Regards,
 >  Byron
 > 
 > -- 
 > Byron Stanoszek                         Ph: (330) 644-3059

I can confirm this.  The system totally locks when this occurs.  I let
it sit all night when it did this the last time, and it didn't
recover.

It requires a large file transfer to usually invoke it.

Billy
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
