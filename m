Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262902AbUAMBcK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jan 2004 20:32:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263015AbUAMBcJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jan 2004 20:32:09 -0500
Received: from mta4-svc.business.ntl.com ([62.253.164.44]:56299 "EHLO
	mta4-svc.business.ntl.com") by vger.kernel.org with ESMTP
	id S262902AbUAMBcC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jan 2004 20:32:02 -0500
Date: Tue, 13 Jan 2004 01:31:03 +0000 (GMT)
From: Bart Oldeman <bartoldeman@users.sourceforge.net>
X-X-Sender: enbeo@enm-bo-lt.enm.bris.ac.uk
To: Linus Torvalds <torvalds@osdl.org>
cc: linux-kernel@vger.kernel.org, <akpm@osdl.org>
Subject: Re: [PATCH] 2.6.1 (not 2.4.24!) mremap fixes broke shm alias mappings
In-Reply-To: <Pine.LNX.4.58.0401121632230.14305@evo.osdl.org>
Message-ID: <Pine.LNX.4.44.0401130119490.21515-100000@enm-bo-lt.enm.bris.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Jan 2004, Linus Torvalds wrote:

> On Sun, 11 Jan 2004, Bart Oldeman wrote:
> >
> > DOSEMU needs to alias memory, for instance to emulate the HMA. A long time
> > ago this was done using mmaps of /proc/self/mem. This was replaced by
> > mremap combined with IPC SHM during 2.1 development.
> >
> > According to DOSEMUs changelog you agreed to allow old_len==0:
> >             - using _one_ big IPC shm segment and mremap(addr, 0 ...)
> >               (Linus agreed on keeping shmat()+mremap(,0,..) functionality)
> > so you agreed on something you have removed after all now!
>
> Hey, I wouldn't remember all the special cases that aren't commented. But
> I agree that a zero "old_len" is not bad in itself, and if DOSEMU uses it,
> let's just continue to support it, and document it while we're at it.
>
> So if this makes DOSEMU happy again, let's do it..
>
> Pls confirm.

sure, it's fine this way. Thanks!

We've already been discussing and playing with a cleaner alternative to
mremap that works too (mmap'ing a file on tmpfs, perhaps via
shm_open()). It's just that it's difficult to explain to users why DOSEMU
worked on 2.6.0 and suddenly stopped working with the same configuration
on 2.6.1.

-- the consensus amongst DOSEMU developers seems to be that you should
feel free to disallow this funny old_len==0 case in 2.7 if you like.

Bart

