Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282916AbRLQWLG>; Mon, 17 Dec 2001 17:11:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282917AbRLQWK4>; Mon, 17 Dec 2001 17:10:56 -0500
Received: from fmfdns01.fm.intel.com ([132.233.247.10]:10946 "EHLO
	calliope1.fm.intel.com") by vger.kernel.org with ESMTP
	id <S282916AbRLQWKn>; Mon, 17 Dec 2001 17:10:43 -0500
Message-ID: <59885C5E3098D511AD690002A5072D3C42D7FE@orsmsx111.jf.intel.com>
From: "Grover, Andrew" <andrew.grover@intel.com>
To: "'Alexander Viro'" <viro@math.psu.edu>
Cc: "'otto.wyss@bluewin.ch'" <otto.wyss@bluewin.ch>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: Booting a modular kernel through a multiple streams file
Date: Mon, 17 Dec 2001 14:10:39 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Alexander Viro [mailto:viro@math.psu.edu]
> On Mon, 17 Dec 2001, Grover, Andrew wrote:
> > I don't think multiple streams is a good idea, but did you 
> all see the patch
> > by Christian Koenig to let the bootloader load modules? 
> That seems to solve
> > the problem nicely.
> 
> That puts an awful lot of smarts into bootloader and creates 
> code duplication
> for no good reason.
> 
> We _already_ have code for loading modules.  And it's going 
> to stay, no
> matter what happens on boot.  So why the hell duplicate that 
> in $BIGNUM
> unrelated pieces of software (LILO, SYSLINUX, MILO, SILO, etc.)?  Just
> to create extra fun with debugging?

OK so (correct me if I'm wrong) there are two parts to loading modules -
getting them in memory, and then resolving references. My understanding of
Christian's work is that the bootloader (e.g. GRUB) gets them in memory, but
then it is up to the kernel linker to resolve refs. So yes, there would be
an additional piece of code (marked __init), but it would not have to be
duplicated for each bootloader -- all they have to do is get the modules in
memory and indicate via the multiboot struct where they are.

I don't think this will obsolete any existing boot methods, but it seems
like an additional genuinely useful capability for the Linux kernel to have.

Regards -- Andy
