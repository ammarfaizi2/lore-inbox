Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268778AbRGaDwW>; Mon, 30 Jul 2001 23:52:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268779AbRGaDwM>; Mon, 30 Jul 2001 23:52:12 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:51470 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S268778AbRGaDwG>; Mon, 30 Jul 2001 23:52:06 -0400
Date: Tue, 31 Jul 2001 00:52:07 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@duckman.distro.conectiva>
To: Andrew Morton <akpm@zip.com.au>
Cc: <Tony.Lill@ajlc.waterloo.on.ca>, <linux-kernel@vger.kernel.org>
Subject: Re: laptops and journalling filesystems
In-Reply-To: <3B662642.4AB6E800@zip.com.au>
Message-ID: <Pine.LNX.4.33L.0107310046570.5582-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Tue, 31 Jul 2001, Andrew Morton wrote:
> Tony Lill wrote:
> >
> > Do any of the current batch of journalling filesystems NOT diddle the
> > disk every 5 seconds?

> Unfortunately ext3 defeats the trick of setting the kupdate
> interval to something huge.  On my list of things-to-do.
>
> Probably it's as simple as setting the commit timer to
> a large interval (grep for "HZ" in fs/jbd/journal.c).

How about using bdf_prm.b_un.interval as the commit
timer for ext3 ?

With the addition that normal writeouts to disk (those
go via the ext3 code, right?) also trigger a commit, if
the last commit was long enough ago to not impact system
efficiency.

This way you should, on laptops, have the ext3 commit
happening either at the same time as the kflushd write
(triggered by the write) or the next kflushd interval
away.

regards,

Rik
--
Executive summary of a recent Microsoft press release:
   "we are concerned about the GNU General Public License (GPL)"


		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com/

