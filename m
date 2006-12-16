Return-Path: <linux-kernel-owner+w=401wt.eu-S1030510AbWLPA6b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030510AbWLPA6b (ORCPT <rfc822;w@1wt.eu>);
	Fri, 15 Dec 2006 19:58:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030508AbWLPA6a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Dec 2006 19:58:30 -0500
Received: from sbcs.cs.sunysb.edu ([130.245.1.15]:37081 "EHLO
	sbcs.cs.sunysb.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030504AbWLPA6a (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Dec 2006 19:58:30 -0500
Date: Fri, 15 Dec 2006 19:58:26 -0500 (EST)
From: Nikolai Joukov <kolya@cs.sunysb.edu>
X-X-Sender: kolya@compserv1
To: David Lang <dlang@digitalinsight.com>
cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] RAIF: Redundant Array of Independent Filesystems
In-Reply-To: <Pine.LNX.4.63.0612151556351.14988@qynat.qvtvafvgr.pbz>
Message-ID: <Pine.GSO.4.53.0612151932410.10315@compserv1>
References: <Pine.GSO.4.53.0612122217360.22195@compserv1>
 <Pine.LNX.4.63.0612151556351.14988@qynat.qvtvafvgr.pbz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > We have designed a new stackable file system that we called RAIF:
> > Redundant Array of Independent Filesystems.
> >
> > Similar to Unionfs, RAIF is a fan-out file system and can be mounted over
> > many different disk-based, memory, network, and distributed file systems.
> > RAIF can use the stable and maintained code of the other file systems and
> > thus stay simple itself.  Similar to standard RAID, RAIF can replicate the
> > data or store it with parity on any subset of the lower file systems.  RAIF
> > has three main advantages over traditional driver-level RAID systems:
>
> this sounds very interesting. did you see the paper on chunkfs?
> http://www.usenix.org/events/hotdep06/tech/prelim_papers/henson/henson_html/

I saw Val at OSDI right before this HotDep talk and sure, I have seen the
paper :-)

> this sounds as if it may be something that you would be able to make a
> functional equivalent to chunkfs with your raid0 mode.

I also have this feeling.  RAIF0 is similar to chunkfs and allows more
flexibility.  Not only RAIF can stripe the data on many small local file
systems (possibly located on multiple drives) but also can stripe the data
on remote file systems.  In addition, it can keep the parity, use
per-file-type storage policies etc.  However, such a configuration would
mean lots and lots of lower file systems ( = branches = chunks).  I am
afraid that in this case RAIF's performance would be not so great due to
VFS API restrictions for operations like lookup.

Nikolai.
---------------------
Nikolai Joukov, Ph.D.
Filesystems and Storage Laboratory
Stony Brook University
