Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267273AbTA0Sfg>; Mon, 27 Jan 2003 13:35:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267274AbTA0Sfg>; Mon, 27 Jan 2003 13:35:36 -0500
Received: from [202.88.171.30] ([202.88.171.30]:19393 "EHLO dikhow.hathway.com")
	by vger.kernel.org with ESMTP id <S267273AbTA0Sff>;
	Mon, 27 Jan 2003 13:35:35 -0500
Date: Tue, 28 Jan 2003 00:18:26 +0530
From: Dipankar Sarma <dipankar@gamebox.net>
To: "Martin J. Bligh" <fletch@aracnet.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@zip.com.au>
Subject: Re: kernbench-16 on 2.5.59 vs 2.5.59-mm6
Message-ID: <20030128001826.A12113@dikhow>
Reply-To: dipankar@gamebox.net
References: <20030127174015$5cfa@gated-at.bofh.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030127174015$5cfa@gated-at.bofh.it>; from fletch@aracnet.com on Mon, Jan 27, 2003 at 06:40:15PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 27, 2003 at 06:40:15PM +0100, Martin J. Bligh wrote:
> Going from 59 to 59-mm6, I get:
> 
> Kernbench-16:
>                                    Elapsed        User      System         CPU
>                         2.5.59       47.45      568.02      143.17     1498.17
>                     2.5.59-mm6       47.18      567.15      138.62     1495.50
> 
> Summary: Scheduler stuff seems like a wash (schedule -> do_schedule). 
> Seems to be some sort of rearrangement of the dcache stuff which 
> appears to be mildly beneficial (what's going in there?). 
> 
> diffprofile (+ gets worse, - gets better).
> 
> 2023 do_schedule
> 485 dentry_open
> 289 .text.lock.file_table

Looks like you are getting hit by contention on files_lock. I have
been messing around with some code to split up the files_lock, but
I can't seem to get the locking in the tty layer right.

Hmm.. .text.lock.namei is probably dcache_lock. -mms no longer has
dcache_rcu, so not quite sure what helped you here.


Thanks
Dipankar
