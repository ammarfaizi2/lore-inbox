Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271616AbRHXXKT>; Fri, 24 Aug 2001 19:10:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272340AbRHXXKI>; Fri, 24 Aug 2001 19:10:08 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:6418 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S271616AbRHXXKC>; Fri, 24 Aug 2001 19:10:02 -0400
Date: Fri, 24 Aug 2001 20:10:06 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@duckman.distro.conectiva>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: Roger Larsson <roger.larsson@skelleftea.mail.telia.com>,
        "Marc A. Lehmann" <pcg@goof.com>, <linux-kernel@vger.kernel.org>,
        <oesi@plan9.de>
Subject: Re: [resent PATCH] Re: very slow parallel read performance
In-Reply-To: <20010824222226Z16116-32383+1242@humbolt.nl.linux.org>
Message-ID: <Pine.LNX.4.33L.0108242007570.31410-100000@duckman.distro.conectiva>
X-supervisor: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 25 Aug 2001, Daniel Phillips wrote:
> On August 24, 2001 09:02 pm, Rik van Riel wrote:

> > I guess in the long run we should have automatic collapse
> > of the readahead window when we find that readahead window
> > thrashing is going on,
>
> Yes, and the most effective way to detect that the readahead
> window is too high is by keeping a history of recently evicted
> pages.

I think it could be even easier. We simply count for each
file how many pages we read-ahead and how many pages we
read.

If the number of pages being read-ahead is really a lot
higher than the pages being read, we know pages get evicted
before we read them ==> we shrink the readahead window.

This simpler scheme should also be able to correctly set
the readahead window for slower data streams to smaller
than the readahead window size for faster reading data
streams (which _do_ get to use more of their data before
it is evicted again).

regards,

Rik
--
IA64: a worthy successor to the i860.

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com/

