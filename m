Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750855AbWCMMdk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750855AbWCMMdk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 07:33:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750849AbWCMMdk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 07:33:40 -0500
Received: from javad.com ([216.122.176.236]:49424 "EHLO javad.com")
	by vger.kernel.org with ESMTP id S1750720AbWCMMdj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 07:33:39 -0500
From: Sergei Organov <osv@javad.com>
To: David Howells <dhowells@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Document Linux's memory barriers [try #4]
References: <16835.1141936162@warthog.cambridge.redhat.com>
Date: Mon, 13 Mar 2006 15:32:02 +0300
In-Reply-To: <16835.1141936162@warthog.cambridge.redhat.com> (David
 Howells's
	message of "Thu, 09 Mar 2006 20:29:22 +0000")
Message-ID: <878xrecypp.fsf@javad.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Howells <dhowells@redhat.com> writes:

> The attached patch documents the Linux kernel's memory barriers.
>
> I've updated it from the comments I've been given.

Did you miss the following comment (you've left corresponding text
intact), or do you think I'm wrong:

David Howells <dhowells@redhat.com> writes:
[...]
> +=======================================
> +LINUX KERNEL COMPILER BARRIER FUNCTIONS
> +=======================================
> +
> +The Linux kernel has an explicit compiler barrier function that prevents the
> +compiler from moving the memory accesses either side of it to the other side:
> +
> +	barrier();
> +
> +This has no direct effect on the CPU, which may then reorder things however it
> +wishes.
> +
> +In addition, accesses to "volatile" memory locations and volatile asm
> +statements act as implicit compiler barriers.

This last statement seems to contradict with what GCC manual says about
volatile asm statements:

"You can prevent an `asm' instruction from being deleted by writing the
keyword `volatile' after the `asm'. [...]
The `volatile' keyword indicates that the instruction has important
side-effects.  GCC will not delete a volatile `asm' if it is reachable.
(The instruction can still be deleted if GCC can prove that
control-flow will never reach the location of the instruction.)  *Note
that even a volatile `asm' instruction can be moved relative to other
code, including across jump instructions.*"

I think that volatile memory locations aren't compiler barriers either,
-- GCC only guarantees that it won't remove the access and that it won't
re-arrange the access w.r.t. other *volatile* accesses. On the other
hand, barrier() indeed prevents *any* memory access from being moved
across the barrier.

-- Sergei.



