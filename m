Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965019AbWEaNvg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965019AbWEaNvg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 May 2006 09:51:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965020AbWEaNvg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 May 2006 09:51:36 -0400
Received: from wr-out-0506.google.com ([64.233.184.229]:20876 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S965019AbWEaNvg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 May 2006 09:51:36 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=DsTsbfblYkAXP3/IJfk9crPvQG6C8CLEm7ep6DIL4Oa8SLwd8njbrAKpetJA3f2/U997yYOSWxcVdaVGlbQodv3VVbfAbqfV/57J+mDXb8IXIvYUE/EV0MibybtNg092cRGl5v9hs2YixvRHt1RKui8+McouhmQKM/jxqwtL/qI=
Message-ID: <6bffcb0e0605310651u61b9756fpfce3515ab046bf42@mail.gmail.com>
Date: Wed, 31 May 2006 15:51:35 +0200
From: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
To: "Andrew Morton" <akpm@osdl.org>
Subject: Re: 2.6.17-rc5-mm1
Cc: "Ingo Molnar" <mingo@elte.hu>, "Arjan van de Ven" <arjan@linux.intel.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <6bffcb0e0605301155h3b472d79h65e8403e7fa0b214@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060530022925.8a67b613.akpm@osdl.org>
	 <6bffcb0e0605301155h3b472d79h65e8403e7fa0b214@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/05/06, Michal Piotrowski <michal.k.k.piotrowski@gmail.com> wrote:
> Hi,
>
> On 30/05/06, Andrew Morton <akpm@osdl.org> wrote:
> >
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.17-rc5/2.6.17-rc5-mm1/
> >
>
> SCSI or libata problem.
> ============================
> [ BUG: illegal lock usage! ]
> ----------------------------
> illegal {in-hardirq-W} -> {hardirq-on-W} usage.
> init/1 [HC0[0]:SC0[0]:HE1:SE1] takes:
>  (&base->lock#2){++..}, at: [<c0129a24>] lock_timer_base+0x29/0x55
> {in-hardirq-W} state was registered at:
>   [<c0139a56>] lockdep_acquire+0x69/0x82
>   [<c02f237c>] _spin_lock_irqsave+0x2a/0x3a
>   [<c0129a24>] lock_timer_base+0x29/0x55
>   [<c0129e48>] del_timer+0x19/0x4c
>   [<c02651e2>] scsi_delete_timer+0xe/0x1f
>   [<c0262964>] scsi_done+0xb/0x19
>   [<c0273ed3>] ata_scsi_qc_complete+0x73/0x7f
>   [<c027024a>] __ata_qc_complete+0x26c/0x274
>   [<c02704f0>] ata_qc_complete+0xd5/0xdc
>   [<c0270c42>] ata_hsm_qc_complete+0x201/0x210
>   [<c02713e7>] ata_hsm_move+0x796/0x7ac
>   [<c027314e>] ata_interrupt+0x173/0x1b4
>   [<c014c4f4>] handle_IRQ_event+0x20/0x50
>   [<c014d76e>] handle_level_irq+0xa1/0xeb
>   [<c010579c>] do_IRQ+0xa1/0xc9
> irq event stamp: 576924
> hardirqs last  enabled at (576923): [<c02f26c7>]
> _spin_unlock_irqrestore+0x36/0x69
> hardirqs last disabled at (576924): [<c02f2361>] _spin_lock_irqsave+0xf/0x3a
> softirqs last  enabled at (576878): [<c0125873>] __do_softirq+0xea/0xf0
> softirqs last disabled at (576869): [<c0105689>] do_softirq+0x59/0xcb
>
> other info that might help us debug this:
> 1 locks held by init/1:
>  #0:  (&base->lock#2){++..}, at: [<c0129a24>] lock_timer_base+0x29/0x55
>
> stack backtrace:
>  [<c0103e52>] show_trace_log_lvl+0x4b/0xf4
>  [<c01044b3>] show_trace+0xd/0x10
>  [<c010457b>] dump_stack+0x19/0x1b
>  [<c0137d63>] print_usage_bug+0x1a1/0x1ab
>  [<c0138458>] mark_lock+0x2d7/0x514
>  [<c01386dc>] mark_held_locks+0x47/0x65
>  [<c0139745>] trace_hardirqs_on+0x12b/0x16f
>  [<c02f2b61>] restore_nocheck+0x8/0xb
>
> Here is config
> http://www.stardust.webpages.pl/files/mm/2.6.17-rc5-mm1/mm-config2
>
> Here is dmesg
> http://www.stardust.webpages.pl/files/mm/2.6.17-rc5-mm1/mm-dmesg2

I can't reproduce this bug with current
http://redhat.com/~mingo/lockdep-patches/latency-tracing-lockdep.patch
and updated
http://redhat.com/~mingo/lockdep-patches/lockdep-combo-2.6.17-rc5-mm1.patch
but these two bugs looks similar (both were previously reported). Both
appears while starting avahi daemon.

http://www.stardust.webpages.pl/files/mm/2.6.17-rc5-mm1/dmesg_1
http://www.stardust.webpages.pl/files/mm/2.6.17-rc5-mm1/dmesg_2

http://www.stardust.webpages.pl/files/mm/2.6.17-rc5-mm1/latency_trace_1.bz2
http://www.stardust.webpages.pl/files/mm/2.6.17-rc5-mm1/latency_trace_2.bz2

Here is config
http://www.stardust.webpages.pl/files/mm/2.6.17-rc5-mm1/mm-config5

I haven't noticed these bugs with "maxcpus=1" boot param.

Regards,
Michal

-- 
Michal K. K. Piotrowski
LTG - Linux Testers Group
(http://www.stardust.webpages.pl/ltg/wiki/)
