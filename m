Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131690AbRCXPBT>; Sat, 24 Mar 2001 10:01:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131691AbRCXPBI>; Sat, 24 Mar 2001 10:01:08 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:31677 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S131690AbRCXPAx>;
	Sat, 24 Mar 2001 10:00:53 -0500
Date: Sat, 24 Mar 2001 10:00:10 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
cc: Andries.Brouwer@cwi.nl, alan@lxorguk.ukuu.org.uk, hpa@transmeta.com,
        torvalds@transmeta.com, tytso@MIT.EDU, linux-kernel@vger.kernel.org
Subject: Re: Larger dev_t
In-Reply-To: <3ABCB1D7.968452D6@mandrakesoft.com>
Message-ID: <Pine.GSO.4.21.0103240952320.11914-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 24 Mar 2001, Jeff Garzik wrote:

> Also for 2.5, kdev_t needs to go away, along with all those arrays based
> on major number, and be replaced with either "struct char_device" or
> "struct block_device" depending on the device.
> 
> I actually went through the kernel in 2.4.0-test days and did this. 
> Most kdev_t usages should really be changed to "struct block_device". 
> The only annoyance in the conversion was ROOT_DEV and similar things
> that are tied into the boot process.  I didn't want to change that and
> potentially break the boot protocol...

Jeff, check the namespace patch - it simplifies this area big way.
Since it's independent from the namespace code I can pull these
parts into separate patch.

Basic idea: _always_ use ramfs (initially empty) for absolute root.
"real" root is overmounted atop of it. The thing being, by the time
when we deal with initrd, unpacking, mounting real root, etc. we
have full-blown fs context. I.e. we can call sys_mknod(), sys_mount(),
etc. I've pulled the late stages of boot into init/do_mounts.c and
had rewritten them - essentially into sequence of syscalls. The thing
became seriosuly simpler (not to mention the fact that it's not scattered
anymore).

If anyone is interested in seeing it as a separate patch - tell and I'll
do it; it's pretty straightforward.
								Al

