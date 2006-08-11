Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932226AbWHKVUr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932226AbWHKVUr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Aug 2006 17:20:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932316AbWHKVUr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Aug 2006 17:20:47 -0400
Received: from adsl-69-232-92-238.dsl.sndg02.pacbell.net ([69.232.92.238]:2945
	"EHLO gnuppy.monkey.org") by vger.kernel.org with ESMTP
	id S932226AbWHKVUq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Aug 2006 17:20:46 -0400
Date: Fri, 11 Aug 2006 14:18:57 -0700
To: Robert Crocombe <rcrocomb@gmail.com>
Cc: Esben Nielsen <nielsen.esben@gogglemail.com>,
       Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
       Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>,
       Darren Hart <dvhltc@us.ibm.com>,
       "Bill Huey (hui)" <billh@gnuppy.monkey.org>
Subject: Re: [Patch] restore the RCU callback to defer put_task_struct() Re: Problems with 2.6.17-rt8
Message-ID: <20060811211857.GA32185@gnuppy.monkey.org>
References: <e6babb600608012237g60d9dfd7ga11b97512240fb7b@mail.gmail.com> <1154541079.25723.8.camel@localhost.localdomain> <e6babb600608030448y7bb0cd34i74f5f632e4caf1b1@mail.gmail.com> <1154615261.32264.6.camel@localhost.localdomain> <20060808025615.GA20364@gnuppy.monkey.org> <20060808030524.GA20530@gnuppy.monkey.org> <Pine.LNX.4.64.0608090050500.23474@frodo.shire> <20060810021835.GB12769@gnuppy.monkey.org> <20060811010646.GA24434@gnuppy.monkey.org> <e6babb600608110800g379ed2c3gd0dbed706d50622c@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e6babb600608110800g379ed2c3gd0dbed706d50622c@mail.gmail.com>
User-Agent: Mutt/1.5.11+cvs20060403
From: Bill Huey (hui) <billh@gnuppy.monkey.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 11, 2006 at 08:00:50AM -0700, Robert Crocombe wrote:
> On 8/10/06, hui Bill Huey <billh@gnuppy.monkey.org> wrote:
> >Patch included:
> 
> Just tried it.

Yeah, this bug is different from the one I've been fixing. Looks like
it's in the softirq system. Let me see.

I'll look through your config and see if anything is different with my
setup that's notable.

bill


> kjournald/1119[CPU#3]: BUG in debug_rt_mutex_unlock at
> kernel/rtmutex-debug.c:471
> 
> Call Trace:
>       <ffffffff80487593>{_raw_spin_lock_irqsave+34}
>       <ffffffff8022cd9f>{__WARN_ON+105}
>       <ffffffff8022cd5a>{__WARN_ON+36}
>       <ffffffff8024897b>{debug_rt_mutex_unlock+204}
>       <ffffffff80486761>{rt_lock_slowunlock+30}
>       <ffffffff804872d6>{__lock_text_start+14}
>       <ffffffff80279461>{kmem_cache_alloc+207}
>       <ffffffff8025b504>{mempool_alloc_slab+22}
>       <ffffffff8025b8f3>{mempool_alloc+80}
>       <ffffffff80209a6d>{mcount+45}
>       <ffffffff80283332>{bio_alloc_bioset+40}
>       <ffffffff80283452>{bio_alloc+21}
>       <ffffffff8027fa28>{submit_bh+142}
>       <ffffffff80280cd3>{ll_rw_block+166}
>       <ffffffff802d19cf>{journal_commit_transaction+1016}
>       <ffffffff80248fa5>{constant_test_bit+9}
>       <ffffffff80487aa0>{_raw_spin_unlock+51}
>       <ffffffff80486789>{rt_lock_slowunlock+70}
>       <ffffffff804872d6>{__lock_text_start+14}
>       <ffffffff80235974>{try_to_del_timer_sync+90}
>       <ffffffff802d5fb2>{kjournald+207}
>       <ffffffff80240107>{autoremove_wake_function+0}
>       <ffffffff802d5ee3>{kjournald+0}
>       <ffffffff8023fcc5>{keventd_create_kthread+0}
>       <ffffffff8023ffca>{kthread+224}
>       <ffffffff802273bf>{schedule_tail+198}
>       <ffffffff8020ae12>{child_rip+8}
>       <ffffffff8023fcc5>{keventd_create_kthread+0}
>       <ffffffff8023feea>{kthread+0}
>       <ffffffff8020ae0a>{child_rip+0}


