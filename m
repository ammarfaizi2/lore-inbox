Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283697AbRLRCcQ>; Mon, 17 Dec 2001 21:32:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283714AbRLRCcH>; Mon, 17 Dec 2001 21:32:07 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:37513 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S283697AbRLRCb5>;
	Mon, 17 Dec 2001 21:31:57 -0500
Date: Mon, 17 Dec 2001 21:31:55 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: "Grover, Andrew" <andrew.grover@intel.com>
cc: "'otto.wyss@bluewin.ch'" <otto.wyss@bluewin.ch>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: Booting a modular kernel through a multiple streams file
In-Reply-To: <59885C5E3098D511AD690002A5072D3C42D7FE@orsmsx111.jf.intel.com>
Message-ID: <Pine.GSO.4.21.0112172059510.6100-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 17 Dec 2001, Grover, Andrew wrote:

> 
> OK so (correct me if I'm wrong) there are two parts to loading modules -
> getting them in memory, and then resolving references. My understanding of
> Christian's work is that the bootloader (e.g. GRUB) gets them in memory, but
> then it is up to the kernel linker to resolve refs. So yes, there would be
> an additional piece of code (marked __init), but it would not have to be
> duplicated for each bootloader -- all they have to do is get the modules in
> memory and indicate via the multiboot struct where they are.

*shrug*  Your "all they have to do" is quite heavy.
 
> I don't think this will obsolete any existing boot methods, but it seems
> like an additional genuinely useful capability for the Linux kernel to have.

I've had a very dubious pleasure of dealing with our boot sequence lately.
Adding more cruft to it (including in-kernel linker, for fsck sake) is
_not_ a good idea.

Folks, whatever had happened with "if it can be done in userland - don't
put it into the kernel"?

That goes for a _lot_ of code.  Mounting root.  Detecting the type of
initrd contents.  Loading ramdisk from floppies.  Asking to press
key (you really ought to look what is done for _that_).  Speaking
DHCP - we have a kernel DHCP client, of all things.  All that stuff
can (and should) be done from userland process.  And there's much
more of the same kind.

There is a word for that and that word is "crap".

Let loader leave an archive to be unpacked into rootfs?  Sure.  Let kernel
exec /init on rootfs and leave the rest to it?  Absolutely.  But let's
stop adding userland stuff into the kernel.  Loading modules _can_ be
done from userland - insmod does it just fine.  And that's where it should
be done.

