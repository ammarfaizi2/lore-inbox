Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422901AbWJaHab@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422901AbWJaHab (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 02:30:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422905AbWJaHab
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 02:30:31 -0500
Received: from brick.kernel.dk ([62.242.22.158]:18757 "EHLO kernel.dk")
	by vger.kernel.org with ESMTP id S1422901AbWJaHaa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 02:30:30 -0500
Date: Tue, 31 Oct 2006 08:32:12 +0100
From: Jens Axboe <jens.axboe@oracle.com>
To: Eric Dumazet <dada1@cosmosbay.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH] splice : two smp_mb() can be omitted
Message-ID: <20061031073212.GW14055@kernel.dk>
References: <1162199005.24143.169.camel@taijtu> <20061030224802.f73842b8.akpm@osdl.org> <4546FA81.1020804@cosmosbay.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4546FA81.1020804@cosmosbay.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 31 2006, Eric Dumazet wrote:
> This patch deletes two calls to smp_mb() that were done after 
> mutex_unlock() that contains an implicit memory barrier.
> 
> The first one in splice_to_pipe(), where 'do_wakeup' is set to true only if 
> pipe->inode is set (and in this case the
> if (pipe->inode)
>    mutex_unlock(&pipe->inode->i_mutex);
> is done too)
> 
> The second one in link_pipe(), following inode_double_unlock() that 
> contains calls to mutex_unlock() too.

NAK on that patch, the smp_mb() follows the waitqueue_active(). If you
later change the code and move the locks or whatnot, you have lost that
connection.

If you change the patch to insert a comment, then it may be more
applicable.

-- 
Jens Axboe

