Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261871AbSJEA1o>; Fri, 4 Oct 2002 20:27:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261872AbSJEA1n>; Fri, 4 Oct 2002 20:27:43 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:49144 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S261871AbSJEA1m>;
	Fri, 4 Oct 2002 20:27:42 -0400
Date: Fri, 4 Oct 2002 20:33:15 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: oops in bk pull (oct 03)
In-Reply-To: <anl2ti$9lc$1@penguin.transmeta.com>
Message-ID: <Pine.GSO.4.21.0210042030020.21250-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 4 Oct 2002, Linus Torvalds wrote:

> > [<c01c9e91>] pci_read_bases+0x161/0x340
> > [<c01ca2a6>] pci_setup_device+0x1b6/0x3d0
> > [<c0105109>] init+0x79/0x200
> > [<c0105090>] init+0x0/0x200
> > [<c01073e5>] kernel_thread_helper+0x5/0x10
> >Code: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 48 c3 8d b4
> 
> Something has corrupted your kernel image. Those 16 0x00 bytes are
> definitely not the right code, looks like an errant memset() through a
> wild pointer cleared it or something.
> 
> Is this repeatable? Does it happen with current BK?

It is repeatable, it does happen with current BK (well, as of couple
of hours ago) and reverting pci/probe.c change apparently cures it.

