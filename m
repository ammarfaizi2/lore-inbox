Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310602AbSCLLqm>; Tue, 12 Mar 2002 06:46:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310652AbSCLLq0>; Tue, 12 Mar 2002 06:46:26 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:27422 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S310632AbSCLLqO>; Tue, 12 Mar 2002 06:46:14 -0500
Date: Tue, 12 Mar 2002 12:47:28 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Rik van Riel <riel@conectiva.com.br>
Cc: wli@parcelfarce.linux.theplanet.co.uk,
        "Richard B. Johnson" <root@chaos.analogic.com>,
        linux-kernel@vger.kernel.org, hch@infradead.org,
        phillips@bonn-fries.net
Subject: Re: 2.4.19pre2aa1
Message-ID: <20020312124728.L25226@dualathlon.random>
In-Reply-To: <20020312070645.X10413@dualathlon.random> <Pine.LNX.4.44L.0203120746000.2181-100000@imladris.surriel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L.0203120746000.2181-100000@imladris.surriel.com>
User-Agent: Mutt/1.3.22.1i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 12, 2002 at 07:46:51AM -0300, Rik van Riel wrote:
> On Tue, 12 Mar 2002, Andrea Arcangeli wrote:
> 
> > If you assume a pure random input, I don't see how can you distribute it
> > better with a simple mul assembler instruction. That's my whole point.
> 
> Since you've just given two examples of common non-random
> workloads yourself, I don't see how you can reasonably
> expect a pure random input.

It is not pure random of course, it can't be pure random there will be
always some influence for example from the I/O patterns, in particular
right after boot, but the randomness of the input is still excellent,
it's not an inode pointer that could have a very little change.  I made
the example to say in the so unlikely case it happens, that's great,
we'll have the guarantee that those two pages won't collide in the same
waitqueue.

Infact above I said "If you _assume_ pure random input". That's what I'm
interested about, if you _assume_ pure random input (in practice there
will always be some infuence).

Bill said that "randomness" is not the right word to use, I instead
think it's the key. If it's pure random mul will make no difference to
the distribution. And the closer we're to pure random like in the
wait_table hash, the less mul will help and the more important will be
to just get right the two contigous pages in the same cacheline and
nothing else.

For the pagecache hash the thing is different, as said with the
pagecache some patological workload can really generate lots of
collisions reproducibly, big patterns can happen there, for example if
the inode happens to be allocated in a row right after boot, and then
some massive I/O starts on similar patterns. While in the
developer-workloads with lots of small files and VM activity, the
pagecache hash should be just good.

Andrea
