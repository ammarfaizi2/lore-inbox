Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318715AbSIFP2U>; Fri, 6 Sep 2002 11:28:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318716AbSIFP2U>; Fri, 6 Sep 2002 11:28:20 -0400
Received: from 2-210.ctame701-1.telepar.net.br ([200.193.160.210]:48056 "EHLO
	2-210.ctame701-1.telepar.net.br") by vger.kernel.org with ESMTP
	id <S318715AbSIFP2S>; Fri, 6 Sep 2002 11:28:18 -0400
Date: Fri, 6 Sep 2002 12:32:33 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: "Peter T. Breuer" <ptb@it.uc3m.es>
cc: Anton Altaparmakov <aia21@cantab.net>, Daniel Phillips <phillips@arcor.de>,
       Alexander Viro <viro@math.psu.edu>,
       Xavier Bestel <xavier.bestel@free.fr>, <david.lang@digitalinsight.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: (fwd) Re: [RFC] mount flag "direct"
In-Reply-To: <200209061353.g86Drcv06621@oboe.it.uc3m.es>
Message-ID: <Pine.LNX.4.44L.0209061227490.1857-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 Sep 2002, Peter T. Breuer wrote:

> > Chances are your 4-node system would have lower aggregate
> > throughput than a single node system.
>
> IF, and I say IF, it turned out to look that way, we would look for
> finer locking instead of abandoning the idea, because the raw arithmetic
> at the top of this post is so powerful.

Finer grained locking would mean doing IO in smaller chunks
and caching less data, which would further decrease the
transfer time vs. seek time ratio.

If you want an efficient clustered filesystem, I think you
should use a filesystem that's designed for clustering.

Adding an inefficient kludge on top of ext2 just isn't
going to cut it because of your inability to cache metadata
and the extremely high cost of disk seeks.

The bottleneck isn't bandwidth, it's the latency of a
disk seek.  A modern hard disk can transfer maybe 60
MB per second when doing linear streaming, but finding
one particular place on the disk still takes 10 ms.

So in order to get 50% bandwidth efficiency from your
disk, you'll need to do IO in chunks of 600 kB. Not
caching metadata and having to read directory, inode,
indirect block and double indirect block for each piece
of data you read is guaranteed to cut your performance
by a factor of 10, or more.

regards,

Rik
-- 
Bravely reimplemented by the knights who say "NIH".

http://www.surriel.com/		http://distro.conectiva.com/

Spamtraps of the month:  september@surriel.com trac@trac.org


