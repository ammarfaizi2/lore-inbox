Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751015AbVIJCkX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751015AbVIJCkX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 22:40:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750842AbVIJCkW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 22:40:22 -0400
Received: from smtp.osdl.org ([65.172.181.4]:29832 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750838AbVIJCkW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 22:40:22 -0400
Date: Fri, 9 Sep 2005 19:36:21 -0700
From: Andrew Morton <akpm@osdl.org>
To: Nishanth Aravamudan <nacc@us.ibm.com>
Cc: dwmw2@infradead.org, bunk@stusta.de, johnstul@us.ibm.com,
       drepper@redhat.com, Franz.Fischer@goyellow.de,
       linux-kernel@vger.kernel.org
Subject: Re: [UPDATE PATCH][Bug 5132] fix sys_poll() large timeout handling
Message-Id: <20050909193621.5d578583.akpm@osdl.org>
In-Reply-To: <20050910022330.GD24225@us.ibm.com>
References: <20050831200109.GB3017@us.ibm.com>
	<20050906212514.GB3038@us.ibm.com>
	<20050910003525.GC24225@us.ibm.com>
	<20050909181658.221eb6f9.akpm@osdl.org>
	<20050910022330.GD24225@us.ibm.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nishanth Aravamudan <nacc@us.ibm.com> wrote:
>
> +	/*
>  +	 * We compare HZ with 1000 to work out which side of the
>  +	 * expression needs conversion.  Because we want to avoid
>  +	 * converting any value to a numerically higher value, which
>  +	 * could overflow.
>  +	 */
>  +#if HZ > 1000
>  +	overflow = timeout_msecs >= jiffies_to_msecs(MAX_SCHEDULE_TIMEOUT);
>  +#else
>  +	overflow = msecs_to_jiffies(timeout_msecs) >= MAX_SCHEDULE_TIMEOUT;
>  +#endif
>  +
>  +	/*
>  +	 * If we would overflow in the conversion or a negative timeout
>  +	 * is requested, sleep indefinitely.
>  +	 */
>  +	if (overflow || timeout_msecs < 0)
>  +		timeout_jiffies = MAX_SCHEDULE_TIMEOUT;

Do we need to test (timeout_msecs < 0) here?  If we make timeout_msecs
unsigned long then I think `overflow' will always be correct.

