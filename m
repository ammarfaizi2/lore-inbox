Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288449AbSADCAR>; Thu, 3 Jan 2002 21:00:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288453AbSADCAI>; Thu, 3 Jan 2002 21:00:08 -0500
Received: from smtp-ham-2.netsurf.de ([194.195.64.98]:60102 "EHLO
	smtp-ham-2.netsurf.de") by vger.kernel.org with ESMTP
	id <S288449AbSADB75>; Thu, 3 Jan 2002 20:59:57 -0500
Date: Fri, 4 Jan 2002 02:49:38 +0100
From: Andreas Bombe <bombe@informatik.tu-muenchen.de>
To: Keith Owens <kaos@ocs.com.au>
Cc: Alexander Viro <viro@math.psu.edu>, linux-kernel@vger.kernel.org
Subject: Re: State of the new config & build system
Message-ID: <20020104014938.GA3474@storm.local>
Mail-Followup-To: Keith Owens <kaos@ocs.com.au>,
	Alexander Viro <viro@math.psu.edu>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.GSO.4.21.0201031623580.23693-100000@weyl.math.psu.edu> <21246.1010094652@ocs3.intra.ocs.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <21246.1010094652@ocs3.intra.ocs.com.au>
User-Agent: Mutt/1.3.24i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 04, 2002 at 08:50:52AM +1100, Keith Owens wrote:
> On Thu, 3 Jan 2002 16:30:55 -0500 (EST), 
> Alexander Viro <viro@math.psu.edu> wrote:
> ><shrug> kernel build doesn't have to use it - if I mount a writable layer
> >atop of the clean tree and build in the resulting tree, build system
> >doesn't need to have any idea of that fact.
> 
> I have one big problem with unionfs and make, it cannot handle this
> scenario.
> 
> * Mount COW layer over clean tree.
> * Edit a file, writing to the COW layer.
> * Build the kernel.
> * Decide that you don't want the change, delete the COW version,
>   exposing the original version of the file, timestamp goes backwards.
> * Build the kernel.
> * make sees source timestamp < object timestamp and does not rebuild,
>   the kernel source and object do not match.

Isn't that a thinko in there?  The build using the edited file would
happen in the same layer as that file or in another one on top.  If it's
the same, the build would be deleted with the change.

If it's in another one on top you'd be removing a layer in the middle.
I don't know if that should be possible without user intervention
(unmount build and change layers, delete change layer, mount build layer
over source).  There is something said about Unix and ropes, I remember.
Then again I don't know the unionfs idea in these details, so I may be
wrong.

Unionfs as I understand it would be great for editing/patching and
building.  Build a kernel in the pristine sources, mount a COW layer
over it where you patch/edit, build there.  In the ideal case the COW
layer would only build the changed file(s) and link vmlinux with all the
other objects from the pristine build.  This wouldn't affect the
pristine build itself at all, no make problems there when you remove the
COW build&change layer.

-- 
Andreas Bombe <bombe@informatik.tu-muenchen.de>    DSA key 0x04880A44
