Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318215AbSHIJb2>; Fri, 9 Aug 2002 05:31:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318214AbSHIJb0>; Fri, 9 Aug 2002 05:31:26 -0400
Received: from wsip68-15-8-100.sd.sd.cox.net ([68.15.8.100]:12928 "EHLO
	gnuppy.monkey.org") by vger.kernel.org with ESMTP
	id <S318205AbSHIJbX>; Fri, 9 Aug 2002 05:31:23 -0400
Date: Fri, 9 Aug 2002 02:34:55 -0700
To: adilger@clusterfs.com
Cc: "Bill Huey (Hui)" <billh@gnuppy.monkey.org>, mingo@elte.hu,
       linux-kernel@vger.kernel.org
Subject: Re: ext3 journal/IDE problems ? (softirq + sched assert ?)
Message-ID: <20020809093455.GA1000@gnuppy.monkey.org>
References: <20020809040456.GA786@gnuppy.monkey.org> <20020809063725.GB12482@clusterfs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020809063725.GB12482@clusterfs.com>
User-Agent: Mutt/1.4i
From: Bill Huey (Hui) <billh@gnuppy.monkey.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 09, 2002 at 12:37:25AM -0600, Andreas Dilger wrote:
> On Aug 08, 2002  21:04 -0700, Bill Huey wrote:
> > What's going on with this ?
> > 
> > I get:
> > EXT3-fs error (device ide0(3,5)): ext3_free_blocks: bit already cleared for block 753210
> > :
> > :
> > EXT3-fs error (device ide0(3,5)): ext3_free_blocks: bit already cleared for block 753273
> > ext3_free_blocks: aborting transaction: Journal has aborted in __ext3_journal_get_undo_access<2>EXT3-fs error (device ide0(3,5)) in ext3_free_blocks: Journal has aborted
> 
> Looks like you got a block of zeros from disk when it should have been a
> block bitmap, or your filesystem is otherwise corrupted.  You need to do
> a full fsck on this filesystem.
> 
> As for cause, I have no idea.  IDE DMA, IDE cables, memory, kernel bug...

It's certainly a kernel bug. This machine has been reliable for years with
stable kernels and I started to run the 2.5 series over the last couple
of days just to test out the softirq stuff (+ preempt) and latency. I
applied Mingo's patch for a recent scheduler assertion bug and it looks
like some kind of race is possibly happening in the IDE layer.

And Mingo, yes, the patch you sent me did help, but it looks like there's
other problems.

Thanks

bill

