Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932387AbWEXWFr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932387AbWEXWFr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 May 2006 18:05:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932450AbWEXWFr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 May 2006 18:05:47 -0400
Received: from smtp.osdl.org ([65.172.181.4]:60855 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932387AbWEXWFq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 May 2006 18:05:46 -0400
Date: Wed, 24 May 2006 15:08:30 -0700
From: Andrew Morton <akpm@osdl.org>
To: Martin Peschke <mp3@de.ibm.com>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [Patch 3/6] statistics infrastructure - prerequisite: timestamp
Message-Id: <20060524150830.3864ae90.akpm@osdl.org>
In-Reply-To: <1148473908.2934.14.camel@dyn-9-152-230-71.boeblingen.de.ibm.com>
References: <1148473908.2934.14.camel@dyn-9-152-230-71.boeblingen.de.ibm.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Peschke <mp3@de.ibm.com> wrote:
>
> +static inline int nsec_to_timestamp(char *s, unsigned long long t)
> +{
> +	unsigned long nsec_rem = do_div(t, NSEC_PER_SEC);
> +	return sprintf(s, "[%5lu.%06lu]", (unsigned long)t,
> +		       nsec_rem/NSEC_PER_USEC);
> +}

do_div() is actually defined in terms of u64, not unsigned long long. 
Although afaict this will all work OK and all the usual type promotions
will dtrt.

Which begs the question: how _does_ the kernel represent nanoseconds?  The
time-management code is a bit undecided (search for long long in
posix-cpu-timers.c, and for u64 in hrtimers.c).  All a bit confused.

Anwyay.  This function is too big and slow to be inlined..
