Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261992AbSJDXvh>; Fri, 4 Oct 2002 19:51:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262168AbSJDXvh>; Fri, 4 Oct 2002 19:51:37 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:34183 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S261992AbSJDXvg>;
	Fri, 4 Oct 2002 19:51:36 -0400
From: Badari Pulavarty <pbadari@us.ibm.com>
Message-Id: <200210042356.g94NujG24693@eng2.beaverton.ibm.com>
Subject: Re: [PATCH] direct-IO API change
To: torvalds@transmeta.com (Linus Torvalds)
Date: Fri, 4 Oct 2002 16:56:45 -0700 (PDT)
Cc: akpm@digeo.com (Andrew Morton), pbadari@us.ibm.com (Badari Pulavarty),
       janetmor@us.ibm.com (Janet Morgan), cel@citi.umich.edu (Chuck Lever),
       linux-kernel@vger.kernel.org (Linux Kernel Mailing List),
       nfs@lists.sourceforge.net (Linux NFS List)
In-Reply-To: <Pine.LNX.4.44.0210041644050.2526-100000@home.transmeta.com> from "Linus Torvalds" at Oct 04, 2002 03:44:46 PM PST
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> 
> On Fri, 4 Oct 2002, Andrew Morton wrote:
> > 
> > > Especially since I thought that O_DIRECT on the regular file (or block
> > > device) performed about as well as raw does anyway these days? Or is that
> > > just one of my LSD-induced flashbacks?
> > > 
> > 
> > Now we're not holding i_sem for O_DIRECT writes to blockdevs,
> > I don't think the raw driver offers any advantages at all.  It's
> > a compatibility thing to save people from having to add "|O_DIRECT" to
> > their source and then typing `ln -s /dev/hda1 /dev/raw/raw0'.
> 
> Maybe the raw driver could become a shell that just adds the O_DIRECT? 
> Unless it can do something more, of course..
> 
> 		Linus
> 
> 

Only issue would be the alignment restriction on blockdev versus raw device.

raw allows 512 byte alignment on userbuff, offset and length.

blockdevice might need  1024/2048 byte alignment.


If we get the alignment patch for DIO, this is not an issue.
(alignment patch - in case of defualt alignment problem,
go down to blkdev_hardsect_size() alignment.)

- Badari
