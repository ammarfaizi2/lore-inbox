Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315285AbSDWRl4>; Tue, 23 Apr 2002 13:41:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315287AbSDWRlz>; Tue, 23 Apr 2002 13:41:55 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:56536 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S315285AbSDWRlv>;
	Tue, 23 Apr 2002 13:41:51 -0400
Date: Tue, 23 Apr 2002 10:41:35 -0700
From: Mike Kravetz <kravetz@us.ibm.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Robert Love <rml@tech9.net>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][RFC] task cpu affinity syscalls for 2.4-O(1)
Message-ID: <20020423104135.B1904@w-mikek2.des.beaverton.ibm.com>
In-Reply-To: <20020423093634.A1904@w-mikek2.des.beaverton.ibm.com> <Pine.LNX.4.44.0204231635410.12991-100000@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 23, 2002 at 04:41:10PM +0200, Ingo Molnar wrote:
> 
> well, my goal was the following: the migration thread makes sure that the
> migrated thread will *not* run on that particular CPU. The only issue the
> migration thread is for is to 'push' the migrated thread from its current
> CPU.
> 
> so we first set the cpus_allowed mask, then we schedule the migration
> thread (which is a highest RT priority thread) if the thread is running on
> an invalid CPU.
> 
> load_balance() moving a process to another CPU is in fact makes this job
> easier, and causes no problems. It will pull a process only to allowed
> runqueues.
> 
> this way it can be guaranteed that after the set_cpus_allowed() call the
> thread is not running on an invalid CPU.
> 
> the affinity setting syscalls added by Robert's patch utilize this
> underlying mechanizm, but kernel threads call it directly as well. Eg. in
> the softirqd case it's of importance whether the thread is running on the
> right CPU or not, after calling set_cpus_allowed().
> 
> is there anything else unclear in this area?

Thanks,  I just needed to stare at the migration_thread code a bit 
more to convince myself that all the special cases were covered.

-- 
Mike
