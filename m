Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129622AbQKETsb>; Sun, 5 Nov 2000 14:48:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129742AbQKETsU>; Sun, 5 Nov 2000 14:48:20 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:22485 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S129622AbQKETsG>;
	Sun, 5 Nov 2000 14:48:06 -0500
Date: Sun, 5 Nov 2000 14:48:03 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Dave Zarzycki <dave@thor.sbay.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: taskfs and kernfs
In-Reply-To: <Pine.LNX.4.21.0011050934080.1045-100000@vaio.thor.sbay.org>
Message-ID: <Pine.GSO.4.21.0011051441240.25503-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 5 Nov 2000, Dave Zarzycki wrote:

> On Sun, 5 Nov 2000, Alexander Viro wrote:
> 
> > However, kernfs is _not_ procfs \setminus procfs-proper. It's our current
> > /proc/sys.
> 
> Okay. I didn't realize that's what you had in mind when you wrote
> "kernfs." Mind if I ask why you didn't call it "sysctlfs" or "sysfs?"

Check *BSD.

> In you earlier e-mail, you suggested that sysctl(2) would use path_walk().
> Would that mean that your kernfs would have to be loaded into the kernel
> and mounted for sysctl(2) to work? Or am I missing something obvious?

Yes. No. Yes.

It doesn't have to be mounted anywhere - we need only dentry tree and some
struct vfsmount to use path_walk(). Said vfsmount doesn't have to be anywhere
near the mount tree.

As for the "loaded in the kernel" - at that point the source of fs-related
part is ~12Kb and sysctl.c is seriously trimmed (sysctl tree traversal is
gone). Moreover, it's going to shrink more when we go for pure dcache variant.
IOW, there is no point in making it modular - no more than doing modular
CONFIG_SYSCTL in the current setup.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
