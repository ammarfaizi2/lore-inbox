Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284464AbRLRSXd>; Tue, 18 Dec 2001 13:23:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284467AbRLRSXN>; Tue, 18 Dec 2001 13:23:13 -0500
Received: from fmfdns01.fm.intel.com ([132.233.247.10]:6388 "EHLO
	calliope1.fm.intel.com") by vger.kernel.org with ESMTP
	id <S284464AbRLRSXE>; Tue, 18 Dec 2001 13:23:04 -0500
Message-ID: <59885C5E3098D511AD690002A5072D3C42D802@orsmsx111.jf.intel.com>
From: "Grover, Andrew" <andrew.grover@intel.com>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Cc: "'otto.wyss@bluewin.ch'" <otto.wyss@bluewin.ch>
Subject: RE: Booting a modular kernel through a multiple streams file
Date: Tue, 18 Dec 2001 09:43:28 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Alexander Viro [mailto:viro@math.psu.edu]
> On Mon, 17 Dec 2001, Grover, Andrew wrote:
> all they have to do is 
> get the modules in
> > memory and indicate via the multiboot struct where they are.
> 
> *shrug*  Your "all they have to do" is quite heavy.

GRUB 0.90 does this today. All other bootloaders could also do it quite
easily, since this is just an extension of what they have to do for the
kernel and initrd images.

> I've had a very dubious pleasure of dealing with our boot 
> sequence lately.
> Adding more cruft to it (including in-kernel linker, for fsck sake) is
> _not_ a good idea.

I see this as cruft elimination. By adding a kernel linker (which can be
discarded after init) it allows one to increase the modularity of the kernel
- without using an initrd. Heck, you could make the initrd code
modularizable ;-)

> Folks, whatever had happened with "if it can be done in 
> userland - don't
> put it into the kernel"?

Yes, but this isn't an absolute rule. IIRC that rule also has an "unless it
makes things a lot simpler" clause, too.

> That goes for a _lot_ of code.  Mounting root.  Detecting the type of
> initrd contents.  Loading ramdisk from floppies.  Asking to press
> key (you really ought to look what is done for _that_).  Speaking
> DHCP - we have a kernel DHCP client, of all things.  All that stuff
> can (and should) be done from userland process.  And there's much
> more of the same kind.

> There is a word for that and that word is "crap".

These examples are either a direct result of initrd complexities, or not
related.

Initrd exists to allow a two-phase startup. My point is that why have a 2
phase startup when you can have a 1 phase startup? Also, I'm not advocating
ditching the initrd capability, but wouldn't bootloading modules be
preferable for the majority of the systems currently using initrd out of
necessity?

Regards -- Andy
