Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129524AbQKCAbZ>; Thu, 2 Nov 2000 19:31:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129544AbQKCAbP>; Thu, 2 Nov 2000 19:31:15 -0500
Received: from fw.SuSE.com ([202.58.118.35]:50169 "EHLO linux.local")
	by vger.kernel.org with ESMTP id <S129524AbQKCAbE>;
	Thu, 2 Nov 2000 19:31:04 -0500
Date: Thu, 2 Nov 2000 17:37:27 -0800
From: Jens Axboe <axboe@suse.de>
To: Val Henson <vhenson@esscom.com>
Cc: Mike Galbraith <mikeg@wen-online.de>, Rik van Riel <riel@conectiva.com.br>,
        linux-kernel@vger.kernel.org
Subject: Re: [BUG] /proc/<pid>/stat access stalls badly for swapping process, 2.4.0-test10
Message-ID: <20001102173727.C11439@suse.de>
In-Reply-To: <Pine.LNX.4.21.0011011643050.6740-100000@duckman.distro.conectiva> <Pine.Linu.4.10.10011020800010.1299-100000@mikeg.weiden.de> <20001102145912.B8472@esscom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20001102145912.B8472@esscom.com>; from vhenson@esscom.com on Thu, Nov 02, 2000 at 02:59:12PM -0700
X-OS: Linux 2.4.0-test10 i686
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 02 2000, Val Henson wrote:
> > > 3) combine this with the elevator starvation stuff (ask Jens
> > >    Axboe for blk-7 to alleviate this issue) and you have a
> > >    scenario where processes using /proc/<pid>/stat have the
> > >    possibility to block on multiple processes that are in the
> > >    process of handling a page fault (but are being starved)
> > 
> > I'm experimenting with blk.[67] in test10 right now.  The stalls
> > are not helped at all.  It doesn't seem to become request bound
> > (haven't instrumented that yet to be sure) but the stalls persist.
> > 
> > 	-Mike
> 
> This is not an elevator starvation problem.

True, but the blk-xx patches help work-around (what I believe) is
bad flushing behaviour by the vm.

> I also experienced these stalls with my IDE-only system.  Unless I'm
> badly mistaken, the elevator is only used on SCSI disks, therefore
> elevator starvation cannot be blamed for this problem.  These stalls
> are particularly annoying since I want to find the pid of the process
> hogging memory in order to kill it, but the read from /proc stalls for
> 45 seconds or more.

You are badly mistaken.

-- 
* Jens Axboe <axboe@suse.de>
* SuSE Labs
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
