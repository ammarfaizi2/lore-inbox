Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318853AbSHETo6>; Mon, 5 Aug 2002 15:44:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318854AbSHETo6>; Mon, 5 Aug 2002 15:44:58 -0400
Received: from axp01.e18.physik.tu-muenchen.de ([129.187.154.129]:59148 "EHLO
	axp01.e18.physik.tu-muenchen.de") by vger.kernel.org with ESMTP
	id <S318853AbSHETo5>; Mon, 5 Aug 2002 15:44:57 -0400
Date: Mon, 5 Aug 2002 21:48:31 +0200 (CEST)
From: Roland Kuhn <rkuhn@e18.physik.tu-muenchen.de>
To: Chris Mason <mason@suse.com>
Cc: Oleg Drokin <green@namesys.com>, <linux-kernel@vger.kernel.org>
Subject: Re: reiserfs blocks long on getdents64() during concurrent write
In-Reply-To: <1028573698.1759.284.camel@tiny>
Message-ID: <Pine.LNX.4.44.0208052113150.31879-101000@pc40.e18.physik.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1149134438-420069091-1028576911=:1357"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---1149134438-420069091-1028576911=:1357
Content-Type: TEXT/PLAIN; charset=US-ASCII

Hi!

sorry, I read this mail after Oleg's, so disregard my previous post.

On 5 Aug 2002, Chris Mason wrote:

> On Mon, 2002-08-05 at 14:30, Oleg Drokin wrote:
> > Hello!
> > 
> > On Mon, Aug 05, 2002 at 08:19:05PM +0200, Roland Kuhn wrote:
> > > > > > ftp://ftp.suse.com/pub/people/mason/patches/data-logging/02-commit_super-8-relocation.diff.gz 
> > > >From there I get 'permission denied', but I got it somewhere else (google 
> > > is great).
> > > However, it does not apply cleanly to 2.4.19. It is already partly in, as 
> > > it seems, but there are some rejects that are not obvious to fix for me. 
> > > If this patch still makes sense, it would be great if someone with more 
> > > knowledge/experience than me could have a look...
> 
> The stack traces you sent earlier show a few procs stuck waiting for the
> transaction to begin, but they don't show which process is currently in
> a transaction (this is who they are waiting on).
> 
The ShowTasks output is attached (it's a RedHat patched klogd which
resolves symbols on the fly). To me it looks like kupdated is indeed
inside do_journal_end().

> Oleg is right, they are probably waiting on kupdated, since the FS might
> get marked dirty faster than it can clear it.
> 
> Another possibility is ctime/mtime updates during write.
> 
In our application there are always at least one writer and one reader 
active in one directory of the partition, both with data rates up to 
10MB/s. The reader uses a block size of 128kB, but I don't know about the 
writer.

> So, on ftp.suse.com/pub/people/mason/patches/data-logging
> 
> Apply:
> 01-relocation-4.diff
> 02-commit_super-8.diff # this is the one you want, but it depends on 01.
> 
Okay, will try.

> And try again.  If that doesn't do it, try 04-write_times.diff (which
> doesn't depend on anything).
> 
Is there a documentation about what this patch does as a whole?

Ciao,
					Roland

+---------------------------+-------------------------+
|    TU Muenchen            |                         |
|    Physik-Department E18  |  Raum    3558           |
|    James-Franck-Str.      |  Telefon 089/289-12592  |
|    85747 Garching         |                         |
+---------------------------+-------------------------+


---1149134438-420069091-1028576911=:1357
Content-Type: APPLICATION/x-gzip; name="tasks.gz"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.44.0208052148310.1357@pc40.e18.physik.tu-muenchen.de>
Content-Description: 
Content-Disposition: attachment; filename="tasks.gz"


---1149134438-420069091-1028576911=:1357--
