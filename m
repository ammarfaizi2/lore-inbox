Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266271AbRGLRIT>; Thu, 12 Jul 2001 13:08:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266399AbRGLRIJ>; Thu, 12 Jul 2001 13:08:09 -0400
Received: from inet-mail3.oracle.com ([148.87.2.203]:7089 "EHLO
	inet-mail3.oracle.com") by vger.kernel.org with ESMTP
	id <S266271AbRGLRHy>; Thu, 12 Jul 2001 13:07:54 -0400
Date: Thu, 12 Jul 2001 08:21:11 -0700 (PDT)
From: Lance Larsh <llarsh@oracle.com>
X-X-Sender: <llarsh@llarsh-pc2.us.oracle.com>
To: Brian Strand <bstrand@switchmanagement.com>
cc: Andrea Arcangeli <andrea@suse.de>, <linux-kernel@vger.kernel.org>
Subject: Re: 2x Oracle slowdown from 2.2.16 to 2.4.4
In-Reply-To: <3B4CE556.9000608@switchmanagement.com>
Message-ID: <Pine.LNX.4.31.0107120749520.21040-100000@llarsh-pc2.us.oracle.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 11 Jul 2001, Brian Strand wrote:

> Why did it get so much worse going from 2.2.16 to 2.4.4, with an
> otherwise-identical configuration?  We had reiserfs+lvm under 2.2.16 too.

Don't have an answer to that.  I never tried reiser on 2.2.

> How do ext2+lvm, rawio+lvm, ext2 w/o lvm, and rawio w/o lvm compare in
> terms of Oracle performance?  I am going to try a migration if 2.4.6
> doesn't make everything better; do you have any suggestions as to the
> relative performance of each strategy?

The best answer I can give at the moment is to use either ext2 or rawio,
and you might want to avoid lvm for now.

I never ran any of the lvm configurations myself.  What little I know
about lvm performance is conjecture based on comparing my reiser results
(5-6x slower than ext2) to the reiser+lvm results from one of our other
internal groups (10-15x slower than ext2).  So, although it looks like lvm
throws in a factor of 2-3x slowdown when using reiser, I don't think we
can assume lvm slows down ext2 by the same amount or else someone probably
would have noticed by now.  Perhaps there's something that sort of
resonates between reiser and lvm to cause the combination to be
particularly bad.  Just guessing...

And while we're talking about comparing configurations, I'll mention that
I'm currently trying to compare raw and ext2 (no lvm in either case).
Although raw should be faster than fs, we're seeing some strange results:
it looks like ext2 can be as much as 2x faster than raw for reads, though
I'm not confident that these results are accurate.  The fs might still be
getting a boost from the fs cache, even though we've tried to eliminate
that possibility by sizing things appropriately.

Has anyone else seen results like this, or can anyone think of a
possible explanation?

Thanks,
Lance

