Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272507AbRIKQF0>; Tue, 11 Sep 2001 12:05:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272508AbRIKQFR>; Tue, 11 Sep 2001 12:05:17 -0400
Received: from shed.alex.org.uk ([195.224.53.219]:11460 "HELO shed.alex.org.uk")
	by vger.kernel.org with SMTP id <S272507AbRIKQFI>;
	Tue, 11 Sep 2001 12:05:08 -0400
Date: Tue, 11 Sep 2001 17:05:27 +0100
From: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Reply-To: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
To: Linus Torvalds <torvalds@transmeta.com>,
        Daniel Phillips <phillips@bonn-fries.net>
Cc: Rik van Riel <riel@conectiva.com.br>,
        Andreas Dilger <adilger@turbolabs.com>,
        Andrea Arcangeli <andrea@suse.de>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Subject: Re: linux-2.4.10-pre5
Message-ID: <1033837619.1000227927@[10.132.112.53]>
In-Reply-To: <Pine.LNX.4.33.0109110843010.8078-100000@penguin.transmeta.com>
In-Reply-To: <Pine.LNX.4.33.0109110843010.8078-100000@penguin.transmeta.com>
X-Mailer: Mulberry/2.1.0 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--On Tuesday, September 11, 2001 8:48 AM -0700 Linus Torvalds 
<torvalds@transmeta.com> wrote:

> I actually think that the "start read-ahead for inode blocks when you do
> readdir" might be a bigger win, because that would be a _new_ kind of
> read-ahead that we haven't done before, and might improve performance for
> things like "ls -l" in the cold-cache situation..

This was exactly what I did in the example I gave Daniel, except
we went slightly further (ONLY if I/O was quiescent) and effectively
went through the readdir, if we found a directory, preloaded (effectively)
the blocks we'd need for a readdir() on that, and if we found a file,
preloaded the first few blocks (this will be harder if you've no
obvious logical map); before actually reading any of the stuff,
we'd get a list of the blocks to read, and sort it as per physical
layout. We also logically read ahead files as soon as they were
opened (we generally had the first few locks from the above
oepration). For directories with short files in, and/or recursive tree
operations, it was a big win. [It might be less of a win under Linux
as the peculiar environment this lived on had resource-fork-esque
stuff represented by directory like things.]

--
Alex Bligh
