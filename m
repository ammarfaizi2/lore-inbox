Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262020AbUD1UZy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262020AbUD1UZy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 16:25:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262050AbUD1UYm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 16:24:42 -0400
Received: from smtp800.mail.sc5.yahoo.com ([66.163.168.179]:6075 "HELO
	smtp800.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262020AbUD1UJS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 16:09:18 -0400
Date: Wed, 28 Apr 2004 15:12:49 -0500 (CDT)
From: Brent Cook <busterbcook@yahoo.com>
X-X-Sender: busterb@ozma.hauschen
Reply-To: busterbcook@yahoo.com
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: pdflush eating a lot of CPU on heavy NFS I/O
In-Reply-To: <20040428124809.418e005d.akpm@osdl.org>
Message-ID: <Pine.LNX.4.58.0404281505440.2772@ozma.hauschen>
References: <Pine.LNX.4.58.0404280009300.28371@ozma.hauschen>
 <20040427230203.1e4693ac.akpm@osdl.org> <Pine.LNX.4.58.0404280826070.31093@ozma.hauschen>
 <20040428124809.418e005d.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Apr 2004, Andrew Morton wrote:

> Brent Cook <busterbcook@yahoo.com> wrote:
> >
> > On Tue, 27 Apr 2004, Andrew Morton wrote:
> >
> > > Brent Cook <busterbcook@yahoo.com> wrote:
>
> > > > the pdflush process starts using near 100% CPU indefinitely after
> > > >  a few minutes of initial NFS traffic, as far as I can tell.
> > >
> > > Please confirm that the problem is observed on the NFS client and not the
> > > NFS server?  I'll assume the client.
> >
> > Yes, both affected machines had the issue when connecting as a client to a
> > 2.4.25-based NFS server.
> >
> > > What other filesystems are in use on the client?
> >
> > One uses Reiser on /, the other uses ext3 on /. Here is the mount table
> > for one machine:
>
> Both machines are exhibiting the problem?

Yes. They both exhibit about 5-10 minutes after starting once I start
compiling from the NFS share. I'm going to also try a big compile from a
local directory to exercise the local FS to eliminate it as a possibility.

> > About 10 minutes into the process, pdflush starts taking over:
> >
> >   PID USER     PRI  NI  SIZE  RSS SHARE STAT %CPU %MEM   TIME CPU COMMAND
> >     7 root      25   0     0    0     0 RW   34.4  0.0   3:05   0 pdflush
> > 17856 busterb   25   0 69400  65M  5140 R    34.4 26.1   0:31   0 cc1plus
> > 19466 busterb   25   0 43732  39M  5140 R    26.3 15.5   0:03   0 cc1plus
> > ...
> > The network light will flash continually on each machine once pdflush
> > gets into this state, which makes me think NFS. Each machine has
> > 512-256 MB of ram and a single CPU.
>
> ok..  I spent a couple of hours yesterday trying to get this to happen.  No
> joy.  Can't make it happen with your .config either.  I'll set up a 2.4.25
> server later on.
>
> What version of gcc are you using?

3.3.3 previously. I just did a build with 3.4 with the same results; I'm
tracking Slackware-current, so my build environment reflects this.

> Could you please capture the contents of /proc/meminfo and /proc/vmstats
> when it's happening?

Will do. I can also provide a test account to you offline if it helps so
you can see it for yourself.

  - Brent
