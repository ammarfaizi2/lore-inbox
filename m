Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268835AbRH0UTK>; Mon, 27 Aug 2001 16:19:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268813AbRH0UTA>; Mon, 27 Aug 2001 16:19:00 -0400
Received: from shed.alex.org.uk ([195.224.53.219]:14993 "HELO shed.alex.org.uk")
	by vger.kernel.org with SMTP id <S268691AbRH0USv>;
	Mon, 27 Aug 2001 16:18:51 -0400
Date: Mon, 27 Aug 2001 21:19:04 +0100
From: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Reply-To: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
To: Oliver Neukum <Oliver.Neukum@lrz.uni-muenchen.de>,
        Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>,
        Rik van Riel <riel@conectiva.com.br>
Cc: Daniel Phillips <phillips@bonn-fries.net>,
        Helge Hafting <helgehaf@idb.hist.no>, linux-kernel@vger.kernel.org,
        Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Subject: Re: [resent PATCH] Re: very slow parallel read performance
Message-ID: <519324650.998947144@[169.254.198.40]>
In-Reply-To: <200108272013.WAA20853@ns.cablesurf.de>
In-Reply-To: <200108272013.WAA20853@ns.cablesurf.de>
X-Mailer: Mulberry/2.1.0b3 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oliver,

--On Monday, 27 August, 2001 10:03 PM +0200 Oliver Neukum 
<Oliver.Neukum@lrz.uni-muenchen.de> wrote:

> what leads you to this conclusion ?
> A task that needs little time to process data it reads in is hurt much
> more  by added latency due to a disk read.

I meant that dropping readahed pages from dd from a floppy (or
slow network connection) is going to cost more to replace
than dropping the same number of readahead pages from dd from
a fast HD. By fast, I meant fast to read in from the file.

If the task is slow, because it's CPU bound (or bound by
other I/O), and /that/ causes the stream to be slow to
empty, then as you say, we have the opposite problem.
On the other hand, it might only be a fast reading task
compared to others as other tasks are blocking on stuff
requiring memory, and all the memory is allocated to that
stream's readahead buffer. So penalizing slow tasks and
prioritizing fast ones may cause an avalanche effect.

Complicated.

--
Alex Bligh
