Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751254AbVHXRrJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751254AbVHXRrJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Aug 2005 13:47:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751326AbVHXRrJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Aug 2005 13:47:09 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:43698 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1751254AbVHXRrI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Aug 2005 13:47:08 -0400
Date: Wed, 24 Aug 2005 19:47:04 +0200
From: Jens Axboe <axboe@suse.de>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: CFQ + 2.6.13-rc4-RT-V0.7.52-02 = BUG: scheduling with irqs disabled
Message-ID: <20050824174702.GL28272@suse.de>
References: <1124899329.3855.12.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1124899329.3855.12.camel@mindpipe>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 24 2005, Lee Revell wrote:
> Just found this in dmesg.
> 
> BUG: scheduling with irqs disabled: libc6.postinst/0x20000000/13229
> caller is ___down_mutex+0xe9/0x1a0
>  [<c029c1f9>] schedule+0x59/0xf0 (8)
>  [<c029ced9>] ___down_mutex+0xe9/0x1a0 (28)
>  [<c0221832>] cfq_exit_single_io_context+0x22/0xa0 (84)
>  [<c02218ea>] cfq_exit_io_context+0x3a/0x50 (16)
>  [<c021db84>] exit_io_context+0x64/0x70 (16)
>  [<c011efda>] do_exit+0x5a/0x3e0 (20)
>  [<c011f3ca>] do_group_exit+0x2a/0xb0 (24)
>  [<c0103039>] syscall_call+0x7/0xb (20)

Hmm, Ingo I seem to remember you saying that the following construct:

        local_irq_save(flags);
        spin_lock(lock);

which is equivelant to spin_lock_irqsave() in mainline being illegal in
-RT, is that correct? This is what cfq uses right now for an exiting
task, as the above trace indicates.

-- 
Jens Axboe

