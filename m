Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313461AbSDGUNv>; Sun, 7 Apr 2002 16:13:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313462AbSDGUNu>; Sun, 7 Apr 2002 16:13:50 -0400
Received: from RAVEL.CODA.CS.CMU.EDU ([128.2.222.215]:42380 "EHLO
	ravel.coda.cs.cmu.edu") by vger.kernel.org with ESMTP
	id <S313461AbSDGUNt>; Sun, 7 Apr 2002 16:13:49 -0400
Date: Sun, 7 Apr 2002 16:13:49 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: Two fixes for 2.4.19-pre5-ac3
Message-ID: <20020407201349.GB15051@ravel.coda.cs.cmu.edu>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <20020407194032.GA15051@ravel.coda.cs.cmu.edu> <E16uIrD-0006bm-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
From: Jan Harkes <jaharkes@cs.cmu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 07, 2002 at 09:01:47PM +0100, Alan Cox wrote:
> > Either add getpag/newpag natively (good for yearly flamefests in
> > linux-kernel), or the more generic task-ornaments so I can make a
> > trivial module that adds /dev/pag, semantics could be as simple as
> > reading returns the current pag, and writing adds a new pag as a
> > task-ornament.
> 
> Oh look, more dirt is falling out now we shook the tree a little. I have
> zero problems with the PAG. We also need an luid and some other related things
> in the future to do strict resource management on big systems (think of it
> in this case as an accounting charge code)

Correct, there is already a whole bunch of ID's and associated with a
task structure, and each has their own little niche.

    process id
    parent process id
    process group id
    session id
    thread group id
    session group leader
    user id (4 flavours)
    group id (also 4 flavours)
    groups (array)
    a 'user' struct
    various 'thread group tracking' identifiers
    journalling filesystem info (whose? ext3? reiserfs? XFS? what if I
				 use multiple journalling filesystems?)
    (and there is probably more)

And there is a continuing request to add even more things like,

    process authentication group id
    login user id
    etc. etc.

And all of these have different requirements and lifetimes. I believe
task-ornaments are a pretty clean way of allowing most this kind of data
to be added dynamically if it is needed or used. If the core kernel
doesn't need some 'task identifying field', it probably should not have
ended up in the task struct. But until recently there simply was no
other solution if one needed process related information that is shared
or inherited across a fork.

Jan

