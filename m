Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263359AbRFXQSa>; Sun, 24 Jun 2001 12:18:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263344AbRFXQSU>; Sun, 24 Jun 2001 12:18:20 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:20499 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S263211AbRFXQSF>; Sun, 24 Jun 2001 12:18:05 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Rik van Riel <riel@conectiva.com.br>,
        Anuradha Ratnaweera <anuradha@gnu.org>
Subject: Re: [RFC] Early flush (was: spindown)
Date: Sun, 24 Jun 2001 18:21:15 +0200
X-Mailer: KMail [version 1.2]
Cc: "Tom Sightler <ttsig@tuxyturvy.com> Mike Galbraith" <mikeg@wen-online.de>,
        Pavel Machek <pavel@suse.cz>, John Stoffel <stoffel@casc.com>,
        Roger Larsson <roger.larsson@norran.net>, thunder7@xs4all.nl,
        Linux-Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.21.0106241205190.7419-100000@imladris.rielhome.conectiva>
In-Reply-To: <Pine.LNX.4.21.0106241205190.7419-100000@imladris.rielhome.conectiva>
MIME-Version: 1.0
Message-Id: <01062418211506.00430@starship>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 24 June 2001 17:06, Rik van Riel wrote:
> On Sun, 24 Jun 2001, Anuradha Ratnaweera wrote:
> > It is not uncommon to have a large number of tmp files on the disk(s)
> > (Rik also pointed this out somewhere early in the original thread) and
> > it is sensible to keep all of them in buffers if RAM is sufficient.
> > Transfering _very_ large files is not _that_ common so why shouldn't
> > that case be handled from the user space by calling sync(2)?
>
> Wait a moment.
>
> The only observed bad case I've heard about here is
> that of large files being written out.

But that's not the only advantage of doing the early update:

  - Early spindown for laptops
  - Improved latency under some conditions
  - Improved throughput for some loads
  - Improved filesystem safety

> It should be easy enough to just trigger writeout of
> pages of an inode once that inode has more than a
> certain amount of dirty pages in RAM ... say, something
> like freepages.high ?

The inode dirty page list is not sorted by "time dirtied" so you would be 
eroding the system's ability to ensure that dirty file buffers never get 
older than X.

--
Daniel
