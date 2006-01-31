Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750718AbWAaJHc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750718AbWAaJHc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Jan 2006 04:07:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750719AbWAaJHc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Jan 2006 04:07:32 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:37399 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1750718AbWAaJHb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Jan 2006 04:07:31 -0500
Date: Tue, 31 Jan 2006 10:09:45 +0100
From: Jens Axboe <axboe@suse.de>
To: Dave Jones <davej@redhat.com>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: more cfq spinlock badness
Message-ID: <20060131090944.GU4215@suse.de>
References: <20060131063938.GA1876@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060131063938.GA1876@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 31 2006, Dave Jones wrote:
> Not seen this break for a while, but I just hit it again in 2.6.16rc1-git4.
> 
> 		Dave
> 
> BUG: spinlock bad magic on CPU#0, pdflush/1128
>  lock: ffff81003a219000, .magic: 00000000, .owner: <none>/-1, .owner_cpu: 0
> 
> Call Trace: <ffffffff80206edc>{spin_bug+177} <ffffffff80207045>{_raw_spin_lock+25}
>        <ffffffff801fea4a>{cfq_exit_single_io_context+85} <ffffffff801ff9a6>{cfq_exit_io_context+24}
>        <ffffffff801f79b0>{exit_io_context+137} <ffffffff80135fbc>{do_exit+182}
>        <ffffffff8010ba49>{child_rip+15} <ffffffff80146087>{keventd_create_kthread+0}
>        <ffffffff8014629c>{kthread+0} <ffffffff8010ba3a>{child_rip+0}
> Kernel panic - not syncing: bad locking

Again, which devices have you used? Did it happen at shutdown, or? Did
the ub bug get fixed, if you are using that? The bug above has in the
past always been able to be explained by a driver destroying a structure
embedding the queue lock before the queue is dead.

-- 
Jens Axboe

