Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280167AbRKEDhH>; Sun, 4 Nov 2001 22:37:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280164AbRKEDg5>; Sun, 4 Nov 2001 22:36:57 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:11278 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S280163AbRKEDgp>; Sun, 4 Nov 2001 22:36:45 -0500
Message-ID: <3BE60814.771CA196@zip.com.au>
Date: Sun, 04 Nov 2001 19:31:32 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.14-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Mohammad A. Haque" <mhaque@haque.net>
CC: lkml <linux-kernel@vger.kernel.org>, ext2-devel@lists.sourceforge.net
Subject: Re: disk throughput
In-Reply-To: <3BE5F5BF.7A249BDF@zip.com.au> <00C9ED52-D19C-11D5-8744-00306569F1C6@haque.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Mohammad A. Haque" wrote:
> 
> On Sunday, November 4, 2001, at 09:13 PM, Andrew Morton wrote:
> 
> > The time to create 100,000 4k files (10 per directory) has fallen
> > from 3:09 (3min 9second) down to 0:30.  A six-fold speedup.
> 
> Nice.
> 
> How long before you release a patch? I have a couple of tasks we execute
> at work I'd like to throw at it.
> 

Try the one-liner against ialloc.c.  You'll need to rebuild
each filesystem to remove the inter-file fragmentation which
ext2 put in there though.

Fortunately I made all the partitions on my laptop the same size,
and there is a spare one.  So I'm busily doing a `cp -a' of each
filesystem onto a newly created one, then mke2fs -j'ing the old one,
then moving on to the next one.  It's boring.

All the other changes make basically no difference once the ialloc.c
change is made.  With that workload.  It's all a matter of utilisation
of device-level readahead.
