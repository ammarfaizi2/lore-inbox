Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261318AbVDBKH3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261318AbVDBKH3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Apr 2005 05:07:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261354AbVDBKH3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Apr 2005 05:07:29 -0500
Received: from fire.osdl.org ([65.172.181.4]:36558 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261318AbVDBKHY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Apr 2005 05:07:24 -0500
Date: Sat, 2 Apr 2005 02:07:00 -0800
From: Andrew Morton <akpm@osdl.org>
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org, mingo@elte.hu,
       christoph@lameter.com, kenneth.w.chen@intel.com
Subject: Re: [RFC][PATCH] timers fixes/improvements
Message-Id: <20050402020700.16221f6f.akpm@osdl.org>
In-Reply-To: <424D373F.1BCBF2AC@tv-sign.ru>
References: <424D373F.1BCBF2AC@tv-sign.ru>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oleg Nesterov <oleg@tv-sign.ru> wrote:
>
> +void fastcall init_timer(struct timer_list *timer)
>  +{
>  +	timer->entry.next = NULL;
>  +	timer->_base = &per_cpu(tvec_bases,
>  +			__smp_processor_id()).t_base;
>  +	timer->magic = TIMER_MAGIC;
>  +}

__smp_processor_id() is not implemented on all architectures.  I'll switch
this to _smp_processor_id().

The smp_processor_id() stuff is all rather a twisty maze (looks at Ingo).

It's a rather odd thing which you're doing there.  Why does a
not-yet-scheduled timer need a ->_base?


