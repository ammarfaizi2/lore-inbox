Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314635AbSEFSD4>; Mon, 6 May 2002 14:03:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314645AbSEFSD4>; Mon, 6 May 2002 14:03:56 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:45424 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S314635AbSEFSDy>; Mon, 6 May 2002 14:03:54 -0400
To: Pavel Machek <pavel@suse.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.5.12] x86 Boot enhancements, boot params 1/11
In-Reply-To: <m11ycuzk4q.fsf@frodo.biederman.org>
	<20020427025642.E413@toy.ucw.cz> <m1u1pl1t4h.fsf@frodo.biederman.org>
	<20020506151939.GE12131@atrey.karlin.mff.cuni.cz>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 06 May 2002 11:55:51 -0600
Message-ID: <m1pu0917q0.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek <pavel@suse.cz> writes:

> Hi!
> 
> > > > #5  boot.heap
> > > > ============================================================
> > > > Modify video.S so that mode_list is also allocated from
> > > > the boot time heap.  This probably saves a little memory,
> > > > and makes a compiled in command line a sane thing to implement.
> > > 
> > > Do you see easy way to pass video mode used to kernel? S3 suspend support
> > > is going to need that..
> > 
> > Do you mean something other than the vga= command line option?
> > Which actually just sets a 16bit mode in the kernel parameter structure.
> 
> In case of vga=ask, it is kernel that gets number from the user,
> right?

Right.
 
> I'd need to know what mode was actually selected, so I can restore it
> after S3 resume.

I guess that works.  In this case it makes sense for the kernel to
store it in the same variable the video mode is specified in.  This
may require an extra store but it should be trivial to implement.

How are you handling the case of X and friends?  Are you making
certain to switch to kernel controlled vt?

My hunch is that this is a decent argument for real framebuffer drivers
in the kernel.  But that is a separate problem.

Eric
