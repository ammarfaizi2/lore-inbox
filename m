Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265736AbRFXLMO>; Sun, 24 Jun 2001 07:12:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265739AbRFXLME>; Sun, 24 Jun 2001 07:12:04 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:46094 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S265736AbRFXLLp>; Sun, 24 Jun 2001 07:11:45 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Anuradha Ratnaweera <anuradha@gnu.org>, Tom Sightler <ttsig@tuxyturvy.com>
Subject: Re: [RFC] Early flush (was: spindown)
Date: Sun, 24 Jun 2001 13:14:45 +0200
X-Mailer: KMail [version 1.2]
Cc: Mike Galbraith <mikeg@wen-online.de>, Rik van Riel <riel@conectiva.com.br>,
        Pavel Machek <pavel@suse.cz>, John Stoffel <stoffel@casc.com>,
        Roger Larsson <roger.larsson@norran.net>, thunder7@xs4all.nl,
        Linux-Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0106171156410.318-100000@mikeg.weiden.de> <993070731.3b310e8b4e51e@eargle.com> <20010624092038.A242@bee.lk>
In-Reply-To: <20010624092038.A242@bee.lk>
MIME-Version: 1.0
Message-Id: <01062413144504.00430@starship>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 24 June 2001 05:20, Anuradha Ratnaweera wrote:
> On Wed, Jun 20, 2001 at 04:58:51PM -0400, Tom Sightler wrote:
> > 1.  When running a compile, or anything else that produces lots of small
> > disk writes, you tend to get lots of little pauses for all the little
> > writes to disk. These seem to be unnoticable without the patch.
> >
> > 2.  Loading programs when writing activity is occuring (even light
> > activity like during the compile) is noticable slower, actually any
> > reading from disk is.
> >
> > I also ran my simple ftp test that produced the symptom I reported
> > earlier.  I transferred a 750MB file via FTP, and with your patch sure
> > enough disk writing started almost immediately, but it still didn't seem
> > to write enough data to disk to keep up with the transfer so at
> > approximately the 200MB mark the old behavior still kicked in as it went
> > into full flush mode, during the time network activity halted, just like
> > before.
>
> It is not uncommon to have a large number of tmp files on the disk(s) (Rik
> also pointed this out somewhere early in the original thread) and it is
> sensible to keep all of them in buffers if RAM is sufficient. Transfering
> _very_ large files is not _that_ common so why shouldn't that case be
> handled from the user space by calling sync(2)?

The patch you're discussing has been superceded - check my "[RFC] Early 
flush: new, improved" post from yesterday.  This addresses the problem of 
handling tmp files efficiently while still having the early flush.

The latest patch shows no degradation at all for compilation, which uses lots 
of temporary files.

--
Daniel 
