Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261887AbULUWkm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261887AbULUWkm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Dec 2004 17:40:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261888AbULUWkm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Dec 2004 17:40:42 -0500
Received: from cantor.suse.de ([195.135.220.2]:19178 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261887AbULUWkf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Dec 2004 17:40:35 -0500
To: Christoph Lameter <clameter@sgi.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Increase page fault rate by prezeroing V1 [1/3]: Introduce __GFP_ZERO
References: <B8E391BBE9FE384DAA4C5C003888BE6F02900FBD@scsmsx401.amr.corp.intel.com.suse.lists.linux.kernel>
	<41C20E3E.3070209@yahoo.com.au.suse.lists.linux.kernel>
	<Pine.LNX.4.58.0412211154100.1313@schroedinger.engr.sgi.com.suse.lists.linux.kernel>
	<Pine.LNX.4.58.0412211155340.1313@schroedinger.engr.sgi.com.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 21 Dec 2004 23:40:34 +0100
In-Reply-To: <Pine.LNX.4.58.0412211155340.1313@schroedinger.engr.sgi.com.suse.lists.linux.kernel>
Message-ID: <p73mzw7cm1p.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter <clameter@sgi.com> writes:
> @@ -0,0 +1,52 @@
> +/*
> + * Zero a page.
> + * rdi	page
> + */
> +	.globl zero_page
> +	.p2align 4
> +zero_page:
> +	xorl   %eax,%eax
> +	movl   $4096/64,%ecx
> +	shl	%ecx, %esi

Surely must be shl %esi,%ecx


> +zero_page_c:
> +	movl $4096/8,%ecx
> +	shl	%ecx, %esi

Same.

Haven't tested.

But for the one instruction it seems overkill to me to have a new
function. How about you just extend clear_page with the order argument?

BTW I think Andrea has been playing with prezeroing on x86 and
he found no benefit at all. So it's doubtful it makes any sense
on x86/x86-64.

-Andi
