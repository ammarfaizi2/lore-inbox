Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752553AbWKAX2W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752553AbWKAX2W (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 18:28:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752559AbWKAX2V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 18:28:21 -0500
Received: from smtp.osdl.org ([65.172.181.4]:42968 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1752553AbWKAX2V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 18:28:21 -0500
Date: Wed, 1 Nov 2006 15:27:15 -0800
From: Andrew Morton <akpm@osdl.org>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Andi Kleen <ak@muc.de>, Andi Kleen <ak@suse.de>,
       virtualization@lists.osdl.org, Chris Wright <chrisw@sous-sol.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/7] paravirtualization: Patch inline replacements for
 common paravirt operations.
Message-Id: <20061101152715.f1f94d5c.akpm@osdl.org>
In-Reply-To: <1162376894.23462.7.camel@localhost.localdomain>
References: <20061029024504.760769000@sous-sol.org>
	<20061029024607.401333000@sous-sol.org>
	<200610290831.21062.ak@suse.de>
	<1162178936.9802.34.camel@localhost.localdomain>
	<20061030231132.GA98768@muc.de>
	<1162376827.23462.5.camel@localhost.localdomain>
	<1162376894.23462.7.camel@localhost.localdomain>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 01 Nov 2006 21:28:13 +1100
Rusty Russell <rusty@rustcorp.com.au> wrote:

> +void apply_paravirt(struct paravirt_patch *start, struct paravirt_patch *end)
> +{
> +	struct paravirt_patch *p;
> +	int i;
> +
> +	for (p = start; p < end; p++) {
> +		unsigned int used;
> +
> +		used = paravirt_ops.patch(p->instrtype, p->clobbers, p->instr,
> +					  p->len);
> +#ifdef CONFIG_DEBUG_KERNEL
> +		/* Deliberately clobber regs using "not %reg" to find bugs. */

That would be considered to be abusive of CONFIG_DEBUG_KERNEL.  A
CONFIG_DEBUG_PARAVIRT which depends on CONFIG_DEBUG_KERNEL would be more
harmonious.
