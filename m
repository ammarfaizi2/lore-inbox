Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315389AbSEBTe0>; Thu, 2 May 2002 15:34:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315390AbSEBTeZ>; Thu, 2 May 2002 15:34:25 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:24504 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S315389AbSEBTeY>;
	Thu, 2 May 2002 15:34:24 -0400
Date: Thu, 2 May 2002 15:34:23 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Andrew Morton <akpm@zip.com.au>
cc: Daniel Pittman <daniel@rimspace.net>, linux-kernel@vger.kernel.org
Subject: Re: 2.5.12 severe ext3 filesystem corruption warning!
In-Reply-To: <3CD191C5.AC09B1F4@zip.com.au>
Message-ID: <Pine.GSO.4.21.0205021530010.16530-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 2 May 2002, Andrew Morton wrote:
> A few things..
> 
[snip]

Andrew, judging by the filenames he'd mentioned, I suspect that he runs
innd.  I.e. one of the very few programs heavily using truncate().  And
no, it doesn't promise anything good - last time we had crap in truncate/mmap
interaction it was a hell to fix.

I suspect that you had screwed the truncate exclusion warranties up.  If
_any_ IO happens in the area currently manipulated by ->truncate() - you
are screwed and results would look pretty much like the things mentioned
in bug report.

