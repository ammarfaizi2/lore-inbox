Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288511AbSA3Eyh>; Tue, 29 Jan 2002 23:54:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288512AbSA3Ey2>; Tue, 29 Jan 2002 23:54:28 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:46047 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S288511AbSA3EyT>;
	Tue, 29 Jan 2002 23:54:19 -0500
Date: Tue, 29 Jan 2002 23:54:14 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Robert Love <rml@tech9.net>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5: push BKL out of llseek
In-Reply-To: <Pine.LNX.4.33.0201291602510.1747-100000@penguin.transmeta.com>
Message-ID: <Pine.GSO.4.21.0201292349260.11157-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 29 Jan 2002, Linus Torvalds wrote:

> 
> On 29 Jan 2002, Robert Love wrote:
> >
> > This patch pushes the BKL out of llseek() and into the individual llseek
> > methods.  For generic_file_llseek, I replaced it with the inode
> > semaphore.
> 
> Thinking about that, that actally sounds like the _right_ thing to do even
> from a correctness standpoint - as llseek() looks at the inode size, so we
> should have that lock anyway.
> 
> So I'd suggest doing the inode semaphore globally, instead of using
> kernel_lock at all.
> 
> Al?

It's OK for regular files and directories, but I'm not sure about devices.

So I'd prefer to do it in two stages - shift BKL into ->llseek() and then
see where it can be dropped/replaced with ->i_sem.

