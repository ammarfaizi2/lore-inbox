Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136211AbRDVQli>; Sun, 22 Apr 2001 12:41:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136212AbRDVQl2>; Sun, 22 Apr 2001 12:41:28 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:3236 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S136211AbRDVQlV>;
	Sun, 22 Apr 2001 12:41:21 -0400
Date: Sun, 22 Apr 2001 12:41:17 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: "David L. Parsley" <parsley@linuxjedi.org>
cc: linux-kernel@vger.kernel.org, ingo.oeser@informatik.tu-chemnitz.de
Subject: Re: hundreds of mount --bind mountpoints?
In-Reply-To: <3AE307AD.821AB47C@linuxjedi.org>
Message-ID: <Pine.GSO.4.21.0104221237320.28681-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 22 Apr 2001, David L. Parsley wrote:

> Hi,
> 
> I'm still working on a packaging system for diskless (quasi-embedded)
> devices.  The root filesystem is all tmpfs, and I attach packages inside
> it.  Since symlinks in a tmpfs filesystem cost 4k each (ouch!), I'm
> considering using mount --bind for everything.  This appears to use very
> little memory, but I'm wondering if I'll run into problems when I start
> having many hundreds of bind mountings.  Any feel for this?

Memory use is sizeof(struct vfsmount) per binding. In principle, you can get
in trouble when size of /proc/mount will get past 4Kb - you'll get only
first 4 (actually 3, IIRC) kilobytes, so stuff that relies on the contents
of said file may get unhappy. It's fixable, though.

