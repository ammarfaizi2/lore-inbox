Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264345AbRGIR5p>; Mon, 9 Jul 2001 13:57:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264397AbRGIR50>; Mon, 9 Jul 2001 13:57:26 -0400
Received: from bacchus.veritas.com ([204.177.156.37]:32749 "EHLO
	bacchus-int.veritas.com") by vger.kernel.org with ESMTP
	id <S264345AbRGIR5W>; Mon, 9 Jul 2001 13:57:22 -0400
Date: Mon, 9 Jul 2001 18:58:32 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Andrea Arcangeli <andrea@suse.de>, Andrew Morton <andrewm@uow.edu.au>,
        Abraham vd Merwe <abraham@2d3d.co.za>,
        Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: msync() bug
In-Reply-To: <Pine.LNX.4.33.0107091040440.14024-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.21.0107091852580.923-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 Jul 2001, Linus Torvalds wrote:
> On Mon, 9 Jul 2001, Hugh Dickins wrote:
> > >
> > > that cannot happen, remap_pte_range only maps invalid pages or reserved
> > > pages.
> >
> > Anyone know why mmap() of /dev/mem behaves in this way - solves the
> > problem Andrew raises, but surely that could be solved in a better way?
> > Seems strange that mmap() cannot give you what read() and write() can.
> 
> Simple: we MUST NOT muck around with the page counts of random pages.

Of course.

> And if the pages aren't marked Reserved, the page counts _would_ get
> corrupted by the VM page handling.

As it stands, yes.  But shouldn't there be some kind of VM_ASIFRESERVED
vma flag to treat all its pages as if they were reserved, for /dev/mem?

Hugh

