Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318290AbSGYAol>; Wed, 24 Jul 2002 20:44:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318287AbSGYAoj>; Wed, 24 Jul 2002 20:44:39 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:59142 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S318061AbSGYAoi>;
	Wed, 24 Jul 2002 20:44:38 -0400
Message-ID: <3D3F4A2F.B1A9F379@zip.com.au>
Date: Wed, 24 Jul 2002 17:45:35 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Robert Love <rml@tech9.net>
CC: torvalds@transmeta.com, riel@conectiva.com.br,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] updated low-latency zap_page_range
References: <1027556975.927.1641.camel@sinai>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Love wrote:
> 
> ...
> +static inline void cond_resched_lock(spinlock_t * lock)
> +{
> +       if (need_resched() && preempt_count() == 1) {
> +               _raw_spin_unlock(lock);
> +               preempt_enable_no_resched();
> +               __cond_resched();
> +               spin_lock(lock);
> +       }
> +}

Maybe I'm being thick.  How come a simple spin_unlock() in here
won't do the right thing?

And this won't _really_ compile to nothing with CONFIG_PREEMPT=n,
will it?  It just does nothing because preempt_count() is zero?


-
