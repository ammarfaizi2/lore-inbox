Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268402AbRGXRvm>; Tue, 24 Jul 2001 13:51:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268400AbRGXRvX>; Tue, 24 Jul 2001 13:51:23 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:1553 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S268399AbRGXRvV>; Tue, 24 Jul 2001 13:51:21 -0400
Date: Tue, 24 Jul 2001 14:51:03 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@duckman.distro.conectiva>
To: Stuart MacDonald <stuartm@connecttech.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Optimization for use-once pages
In-Reply-To: <014a01c11468$01151e00$294b82ce@connecttech.com>
Message-ID: <Pine.LNX.4.33L.0107241447440.20326-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Tue, 24 Jul 2001, Stuart MacDonald wrote:
> From: "Rik van Riel" <riel@conectiva.com.br>
> > Because they occur in a very short interval, an interval MUCH
> > shorter than the time scale in which the VM subsystem looks at
> > referenced bits, etc...
>
> So what you're sayng is that any number of accesses, as long
> as they all occur within the interval < VM subsystem scanning
> interval, are all counted as one?

Actually, the length of this interval could be even smaller
and is often a point of furious debating.

The 2Q algorithm seems to have solved this problem by not
using an interval, but a FIFO queue of small, fixed length.

> > This seems to be generally accepted theory and practice in the
> > field of page replacement.
>
> Okay, just seems odd to me, but IANAVMGuru.

Seems odd at first glance, true.

Let me give you an example:

- sequential access of a file
- script reads the file in 80-byte segments
  (parsing some arcane data structure)
- these segments are accessed in rapid succession
- each 80-byte segment is accessed ONCE

In this case, even though the data is accessed only
once, each page is touched PAGE_SIZE/80 times, with
one 80-byte read() each time.

I hope this example gives you some holding point to
make it easier and grasp this - somewhat counter
intuitive - concept.

regards,

Rik
--
Executive summary of a recent Microsoft press release:
   "we are concerned about the GNU General Public License (GPL)"


		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com/

