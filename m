Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129669AbRCCTOH>; Sat, 3 Mar 2001 14:14:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129674AbRCCTN5>; Sat, 3 Mar 2001 14:13:57 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:5071 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S129669AbRCCTNo>;
	Sat, 3 Mar 2001 14:13:44 -0500
Date: Sat, 3 Mar 2001 14:13:41 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Denis Perchine <dyp@perchine.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Q: How to get physical memory size from user space without proc
 fs
In-Reply-To: <Pine.LNX.4.10.10103031332480.11778-100000@mx.webmailstation.com>
Message-ID: <Pine.GSO.4.21.0103031400160.19484-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 3 Mar 2001, Denis Perchine wrote:

> Hello,
> 
> actually the question is in subj.
> Problem is that there is a program which needs to know physical memory
> size. This information is used to justify memory consumption as after some
> swapping performance is drops dramatically, and it is better to finish.
> 
> I know that this is not the best idea, but it is assumed that this program
> is the only one running on the machine.
> 
> I do not want to use proc as some people can just do not mount it.
> 
> Any comments, suggestions?

In initscripts create a directory with mode=700. Create a subdirectory there.
Mount procfs on it. Get the information. umount. rmdir. rmdir. Put that
information into /etc. Let your program use that as config file.

If attacker is able to traverse root-owned directory with rwx------ when
initscripts are run he won't gain anything new from accessing procfs, since
he already can do whatever he bloody wants.

Besides, that way it's easy to port to non-Linux boxen - all system
dependencies are in the way to have /etc/memsize set by the time when
your program is run. Which can be done by echo/ed/vi/whatever.
							Cheers,
								Al

