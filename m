Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316619AbSEUVfM>; Tue, 21 May 2002 17:35:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316617AbSEUVfL>; Tue, 21 May 2002 17:35:11 -0400
Received: from ns.suse.de ([213.95.15.193]:52228 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S316619AbSEUVfK>;
	Tue, 21 May 2002 17:35:10 -0400
To: Dave McCracken <dmccr@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: [RFC] POSIX personality
In-Reply-To: <Pine.LNX.4.33.0205211349100.3073-100000@penguin.transmeta.com.suse.lists.linux.kernel> <72190000.1022014608@baldur.austin.ibm.com.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 21 May 2002 23:35:09 +0200
Message-ID: <p73d6vpxjzm.fsf@oldwotan.suse.de>
X-Mailer: Gnus v5.7/Emacs 20.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave McCracken <dmccr@us.ibm.com> writes:

> --On Tuesday, May 21, 2002 01:52:37 PM -0700 Linus Torvalds
> <torvalds@transmeta.com> wrote:
> 
> > I don't see any reason to start using some fixed-mode semantics without 
> > seeing some stronger arguments on exactly why that would be a good idea. 
> > We have used up 11 of 24 bits (and more can be made available) over the 
> > last five years, and there are no obvious inefficiencies that I can see.
> 
> Ok, sounds reasonable.  I'll add the bits as I go, then.

One reason for it would be that it would be more efficient. All the various
shared state needed for POSIX thread group emulation could be put into a 
single structure with a single reference count.

With clone flags you need one pointer in task_struct per flag and
handling of the reference count for each data structure and allocation/freeing
from various slabs for a real fork.
(basically lots of atomic operations at fork time + bloating of task_struct) 

-Andi

