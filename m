Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932132AbWCIMEG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932132AbWCIMEG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 07:04:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932138AbWCIMEF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 07:04:05 -0500
Received: from main.gmane.org ([80.91.229.2]:46761 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932132AbWCIMEB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 07:04:01 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Sergei Organov <osv@javad.com>
Subject: Re: [PATCH] Document Linux's memory barriers [try #2]
Date: Thu, 09 Mar 2006 15:02:15 +0300
Message-ID: <dup5gf$t1t$1@sea.gmane.org>
References: <31492.1141753245@warthog.cambridge.redhat.com>
	<29826.1141828678@warthog.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 87.236.81.130
User-Agent: Gnus/5.110004 (No Gnus v0.4) XEmacs/21.4.18 (linux)
Cc: linuxppc64-dev@ozlabs.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

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

