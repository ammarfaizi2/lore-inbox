Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271090AbTHQUM2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Aug 2003 16:12:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271091AbTHQUM2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Aug 2003 16:12:28 -0400
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:39373
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S271090AbTHQUMV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Aug 2003 16:12:21 -0400
From: Rob Landley <rob@landley.net>
Reply-To: rob@landley.net
To: Coen Rosdorff <coen@rosdorff.dyndns.org>, Hugh Dickins <hugh@veritas.com>
Subject: Re: VM: killing process amavis
Date: Sun, 17 Aug 2003 05:48:16 -0400
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0308132119140.4138-100000@rosdorff.dyndns.org>
In-Reply-To: <Pine.LNX.4.44.0308132119140.4138-100000@rosdorff.dyndns.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308170548.16094.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 13 August 2003 15:40, Coen Rosdorff wrote:
> On Wed, 13 Aug 2003, Hugh Dickins wrote:
> > It really would be worth giving memtest86 a good long run.
> >
> > 02000000 looks very much like a single-bit memory error,
> > and swap_free is exactly where such errors often show up.
>
> I had the same problem before on the previous server. Running memtest for
> 19 days didn't showed any memory problems.
>
> After replacing the motherboard cpu and ram, now I have the same problem.

I had a system once that looked very much like it had bad ram, but it turned 
out to have a bad hard drive controller, which showed up paging stuff into 
memory from disk (ala exec, sometimes), and in bringing stuff back in from 
swap.  (The kernel almost never went bye-bye, because it never swapped out, 
you see...)

Caused the weirdest problems in Myth II, among other things...

> So the problem moved from 00000100 to 02000000
>
> The networkcards and the 3ware raid controler moved form the old to the
> new box. Could one of them be the problem?
>
> I am running out of options.

Check the raid controller.  Especially if you're swapping through the raid 
controller.  I found out what was wrong with the other system by copying big 
tarballs through the network and verifying them.

Try this:

1) Copy a tarball to the remote system and confirm that it came out OK just 
coming across the network.

  cat enormous.tgz | ssh othersystem "tar tvz"

2) Now copy the tarball to the remote machine's disk, and test that the copy 
on disk is good.

  cat enormous.tgz | ssh othersystem "cat > temp.tgz; tar tvzf temp.tgz"

Of course using a tarball that's bigger than your ram, so it actually does 
have to write it out to disk and read it back in again.  Using ssh provides a 
little bit of a CPU load, and of course the network is providing a competing 
source of interrupts.  (You could also run contest in the background or some 
such to really beat the system to death...)

Rob


