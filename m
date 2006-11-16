Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031126AbWKPI6n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031126AbWKPI6n (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Nov 2006 03:58:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031127AbWKPI6n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Nov 2006 03:58:43 -0500
Received: from smtp.osdl.org ([65.172.181.4]:48787 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1031126AbWKPI6m (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Nov 2006 03:58:42 -0500
Date: Thu, 16 Nov 2006 00:58:33 -0800
From: Andrew Morton <akpm@osdl.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Andi Kleen <ak@suse.de>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch, -rc6] x86_64: UP build fixes
Message-Id: <20061116005833.b6d6daa5.akpm@osdl.org>
In-Reply-To: <20061116084855.GA8848@elte.hu>
References: <20061116084855.GA8848@elte.hu>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Nov 2006 09:48:55 +0100
Ingo Molnar <mingo@elte.hu> wrote:

> +static inline int
> +smp_call_function_single(int cpuid, void (*func) (void *info), void *info,
> +			 int retry, int wait)
> +{
> +	func(info);
> +
> +	return 0;
> +}
> +

Given that on SMP the function is called with local interrupts disabled,
I'd suggest that it should be called with local interrupts disabled on UP
as well.

on_each_cpu() does this and one caller (at least) relies upon it
(invalidate_bh_lrus(), iirc).
