Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964897AbWEJK1p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964897AbWEJK1p (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 06:27:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964896AbWEJK1o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 06:27:44 -0400
Received: from smtp.osdl.org ([65.172.181.4]:59109 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964897AbWEJK1n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 06:27:43 -0400
Date: Wed, 10 May 2006 03:24:49 -0700
From: Andrew Morton <akpm@osdl.org>
To: balbir@in.ibm.com
Cc: linux-kernel@vger.kernel.org, lse-tech@lists.sourceforge.net,
       jlan@engr.sgi.com, tglx@linutronix.de
Subject: Re: [PATCH][delayacct] Fix the timespec_sub() interface (was Re:
 [Patch 1/8] Setup)
Message-Id: <20060510032449.2872a8ba.akpm@osdl.org>
In-Reply-To: <20060510101622.GB29432@in.ibm.com>
References: <20060502061255.GL13962@in.ibm.com>
	<20060508141713.60c9d33e.akpm@osdl.org>
	<20060510101622.GB29432@in.ibm.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Balbir Singh <balbir@in.ibm.com> wrote:
>
> Please find the updated patch, which changes the interface of timespec_sub()
> as suggested in the review comments
> 
> ...
>
>  /*
> - * sub = end - start, in normalized form
> + * sub = lhs - rhs, in normalized form
>   */
> -static inline void timespec_sub(struct timespec *start, struct timespec *end,
> -				struct timespec *sub)
> +static inline struct timespec timespec_sub(struct timespec *lhs,
> +						struct timespec *rhs)
>  {

I'd have thought that it would be more consistent and a saner interface to
use pass-by-value:

static inline struct timespec timespec_sub(struct timespec lhs,
						struct timespec rhs)

It should generate the same code.

I mentioned this last time - did you choose to not do this for some reason,
or did it just slip past?

