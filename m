Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751046AbWEHVUt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751046AbWEHVUt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 May 2006 17:20:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751088AbWEHVUt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 May 2006 17:20:49 -0400
Received: from smtp.osdl.org ([65.172.181.4]:27050 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751046AbWEHVUs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 May 2006 17:20:48 -0400
Date: Mon, 8 May 2006 14:23:22 -0700
From: Andrew Morton <akpm@osdl.org>
To: balbir@in.ibm.com
Cc: linux-kernel@vger.kernel.org, lse-tech@lists.sourceforge.net,
       jlan@engr.sgi.com
Subject: Re: [Patch 1/8] Setup
Message-Id: <20060508142322.71e88a54.akpm@osdl.org>
In-Reply-To: <20060502061255.GL13962@in.ibm.com>
References: <20060502061255.GL13962@in.ibm.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Balbir Singh <balbir@in.ibm.com> wrote:
>
> +static inline void delayacct_end(struct timespec *start, struct timespec *end,
> +				u64 *total, u32 *count)
> +{
> +	struct timespec ts = {0, 0};
> +	s64 ns;
> +
> +	do_posix_clock_monotonic_gettime(end);
> +	timespec_sub(&ts, start, end);
> +	ns = timespec_to_ns(&ts);
> +	if (ns < 0)
> +		return;
> +
> +	spin_lock(&current->delays->lock);
> +	*total += ns;
> +	(*count)++;
> +	spin_unlock(&current->delays->lock);
> +}

- too large to be inlined

- The initialisation of `ts' is unneeded (maybe it generated a bogus
  warning, but it won't do that if you switch timespec_sub to
  return-by-value)
