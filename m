Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269174AbRH0Vid>; Mon, 27 Aug 2001 17:38:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269206AbRH0ViY>; Mon, 27 Aug 2001 17:38:24 -0400
Received: from mailrelay1.lrz-muenchen.de ([129.187.254.101]:680 "EHLO
	mailrelay1.lrz-muenchen.de") by vger.kernel.org with ESMTP
	id <S269174AbRH0ViI>; Mon, 27 Aug 2001 17:38:08 -0400
Date: Mon, 27 Aug 2001 23:38:21 +0200 (MET DST)
From: <Oliver.Neukum@lrz.uni-muenchen.de>
X-X-Sender: <ui222bq@sun2.lrz-muenchen.de>
To: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
cc: Oliver Neukum <Oliver.Neukum@lrz.uni-muenchen.de>,
        Rik van Riel <riel@conectiva.com.br>,
        Daniel Phillips <phillips@bonn-fries.net>,
        Helge Hafting <helgehaf@idb.hist.no>, <linux-kernel@vger.kernel.org>
Subject: Re: [resent PATCH] Re: very slow parallel read performance
In-Reply-To: <519324650.998947144@[169.254.198.40]>
Message-Id: <Pine.SOL.4.33.0108272332230.1537-100000@sun2.lrz-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Aug 2001, Alex Bligh - linux-kernel wrote:

> Oliver,
>
> --On Monday, 27 August, 2001 10:03 PM +0200 Oliver Neukum
> <Oliver.Neukum@lrz.uni-muenchen.de> wrote:
>
> > what leads you to this conclusion ?
> > A task that needs little time to process data it reads in is hurt much
> > more  by added latency due to a disk read.
>
> I meant that dropping readahed pages from dd from a floppy (or
> slow network connection) is going to cost more to replace
> than dropping the same number of readahead pages from dd from
> a fast HD. By fast, I meant fast to read in from the file.

There you are perfectly right. I misunderstood. How do you measure cost of
replacement ?

> If the task is slow, because it's CPU bound (or bound by
> other I/O), and /that/ causes the stream to be slow to
> empty, then as you say, we have the opposite problem.
> On the other hand, it might only be a fast reading task
> compared to others as other tasks are blocking on stuff
> requiring memory, and all the memory is allocated to that
> stream's readahead buffer. So penalizing slow tasks and
> prioritizing fast ones may cause an avalanche effect.
>
> Complicated.

Do we need a maximum readahead based on reasonable latency of the device
in question ?
If on the other hand a task is very fast in processing its buffers the
readahead queue will _not_ be long. The task will however use a lot of IO
bandwidth. Strictly speaking this is a question of IO scheduling.

	Regards
		Oliver


