Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317330AbSGTDIS>; Fri, 19 Jul 2002 23:08:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317331AbSGTDIS>; Fri, 19 Jul 2002 23:08:18 -0400
Received: from waste.org ([209.173.204.2]:59869 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S317330AbSGTDIR>;
	Fri, 19 Jul 2002 23:08:17 -0400
Date: Fri, 19 Jul 2002 22:10:46 -0500 (CDT)
From: Oliver Xymoron <oxymoron@waste.org>
To: Hans Reiser <reiser@namesys.com>
cc: Rik van Riel <riel@conectiva.com.br>,
       Andreas Dilger <adilger@clusterfs.com>,
       Michael Hohnbaum <hohnbaum@us.ibm.com>,
       "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
       Guillaume Boissiere <boissiere@adiglobal.com>,
       <linux-kernel@vger.kernel.org>,
       Reiserfs developers mail-list <Reiserfs-Dev@namesys.com>
Subject: Re: [2.6] Most likely to be merged by Halloween... THE LIST]
In-Reply-To: <3D38C31F.6030804@namesys.com>
Message-ID: <Pine.LNX.4.44.0207192153150.1120-100000@waste.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 20 Jul 2002, Hans Reiser wrote:

> Rik van Riel wrote:
>
> >So, what feature are you trying to smuggle into the kernel
> >but are afraid isn't ready on time and why do you think it
> >couldn't be backported into 2.6 later, when 2.6 is stable ?
> >
> Ouch.  He sees right though me.;)
>
> The core Reiser4 code should be in time.  Reiser4 will have its core
> code stable in a month I hope, and by core code I mean code that does
> what V3 does but on top of a plugin infrastructure and faster than V3 in
> at least some measures.
>
> What I am worried about schedule-wise are:
>
> * the API for exporting transactions to user space (the in kernel buffer
> management code to support it is completed but the API is not yet done).
>  Uses the new system call we are adding.

You'd better start hashing that API out on the list yesterday.

> * The traditional file API is designed for efficiency of repeated
> operations to the same file.  As part of our effort to make files able
> to do everything that extended attributes can do, but more flexibly, we
> are creating a new system call.  This new system call can perform
> multiple operations on files in one system call, and is very convenient
> for a bunch of small IOs to different files.

And this one.

> * file inheritance

And possibly this. Is this transparency of some form?.

> So, I am assuming a new system call must go in before feature freeze.
>  One can reasonably argue that because it only affects one experimental
> filesystem named reiser4 (until other FS authors see how nice it is and
> start to use it;-) ) and does not complicate VFS,  it is not core code,
> and should not be subject to the freeze.  I'll make that argument if we
> don't have it ready in time....;-)

It only doesn't complicate VFS because we haven't discussed generalizing
it yet. The desire to do transactional processing is not unique to Reiser
any more than journalling is. See recent thread about fsync and MTAs.

If you hide all your nifty features under a carpet (aka ioctl) where no
one but Viro notices them, then maybe you'll be able to push this stuff
late September and get them in. But FS-specific syscalls are a non-starter
- what happens to the second FS that decides it wants transactions or
multi-file I/O but doesn't quite fit your model?

-- 
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.."

