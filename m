Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752475AbWCQBf6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752475AbWCQBf6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 20:35:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752515AbWCQBf6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 20:35:58 -0500
Received: from smtp.osdl.org ([65.172.181.4]:58770 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1752475AbWCQBf6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 20:35:58 -0500
Date: Thu, 16 Mar 2006 17:38:08 -0800
From: Andrew Morton <akpm@osdl.org>
To: Hugh Dickins <hugh@veritas.com>
Cc: rlrevell@joe-job.com, mingo@elte.hu, nickpiggin@yahoo.com.au,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix free swap cache latency
Message-Id: <20060316173808.3be343b0.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.61.0603161853300.24463@goblin.wat.veritas.com>
References: <Pine.LNX.4.61.0603161853300.24463@goblin.wat.veritas.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hugh Dickins <hugh@veritas.com> wrote:
>
>  			(*zap_work)--;
>  			continue;
>  		}
> +
> +		(*zap_work) -= PAGE_SIZE;

Sometimes we subtract 1 from zap_work, sometimes PAGE_SIZE.  It's in units
of bytes, so PAGE_SIZE is correct.  Although it would make sense to
redefine it to be in units of PAGE_SIZE.  What's up with that?

Even better, define it in units of "approximate number of touched
cachelines".  After all, it is a sort-of-time-based thing.

