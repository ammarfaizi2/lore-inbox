Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285465AbRLSJIe>; Wed, 19 Dec 2001 04:08:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285466AbRLSJIO>; Wed, 19 Dec 2001 04:08:14 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:50763 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S285465AbRLSJIH>; Wed, 19 Dec 2001 04:08:07 -0500
To: Alexander Viro <viro@math.psu.edu>
Cc: "Grover, Andrew" <andrew.grover@intel.com>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        "'otto.wyss@bluewin.ch'" <otto.wyss@bluewin.ch>
Subject: Re: Booting a modular kernel through a multiple streams file
In-Reply-To: <Pine.GSO.4.21.0112190313080.9963-100000@weyl.math.psu.edu>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 19 Dec 2001 01:47:47 -0700
In-Reply-To: <Pine.GSO.4.21.0112190313080.9963-100000@weyl.math.psu.edu>
Message-ID: <m1ellrwq8c.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro <viro@math.psu.edu> writes:

> On 19 Dec 2001, Eric W. Biederman wrote:
> 
> > Alexander Viro <viro@math.psu.edu> writes:
> > 
> > > They are related to the fact that we enter userland too late.  Which can
> > > (and should) be fixed.
> > 
> > Agreed, we need to be careful with the userland we introduce as it can
> > easily get huge if we use standard components.
> 
> If by standard components you mean glibc - definitely.  It's not going
> to be there.

Actually any general purpose piece of software.  glibc is big and just
about everything else on a linux box is big for the same reasons, it
handles lots of cases.  glibc is extra big because it isn't
stripped. 

Just for credentials I have a static user space dhcp and tftp just
16KB (uncompressed).  If I knew what was involved in the nfs
mount code I'd contribute this and you would be feature complete.


> > Have you done the work to allow the cpio archive to be changed in
> > a binary kernel yet?
> 
> It can be left by the loader in the way we currently leave initrd.

O.k. but this isn't implemented currently correct?  The whole
bootloader leaving something, and having something included with
the kernel build is where I see unresolved technical details.

Probably the simplest solution is to allow files to come from both
locations with the additional bootloader files overwriting the
compiled in files.  And just dropping initrd support altogether.

Currently there is another issue of how to replace the compiled
in default files, but that can probably be resolved after we start
sucking in cpio archives.

The protocol details and the implementation issues are what really
fascinate me at this point.

> > > use for initrd images.  IOW, we are backwards compatible with old
> > > loaders.
> > 
> > Al what is the current status of your initramfs work?
> 
> nfsroot needs more work on it, other than that we can have it very
> soon - almost everything we need is already merged into the tree.

O.k. the kernel has all of your dependencies for this patch, cool.
  
> > So far I have concentrated a lot on the simple, and much less on full
> > featured boot loaders that load data off of filesystems etc.  I need
> > to look at dynamically composing and manipulating images.  Seeing the
> > direction you are taking with initramfs would be a great help there.
> 
> man cpio.

Here I am thinking protocol and logistics, and you think I'm asking
about data format.

> 
> > Portability across cpu architectures for a boot protocol is not a
> > silly goal.  If you stir in a linux booting linux patch plus a small
> > user space you get one bootloader across all of the linux platforms
> > with more potential than any bootloader currently out there.
> 
> You still need to get the original kernel in core...

Given that I haven't seen a bootloader without a stage1 I don't see
this a major problem, and since we run linux on the platform someone
has obviously figured out some way to boot it.   It is the all singing
all dancing all interacting bootloader that is worth standardizing.
Having an X App to select your boot image just might be worth it :)

The only real issue with using linux as a bootloader is there a
serious delay during kernel initialization.  Lately the 10 or 15
seconds of kernel time this takes has been 50% of my boot time.  The
other 45% going to stupid rc scripts.

Eric
