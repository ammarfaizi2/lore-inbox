Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751521AbWCNVsL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751521AbWCNVsL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 16:48:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751944AbWCNVsL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 16:48:11 -0500
Received: from ozlabs.org ([203.10.76.45]:60327 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1751521AbWCNVsJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 16:48:09 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17431.14867.211423.851470@cargo.ozlabs.ibm.com>
Date: Wed, 15 Mar 2006 08:48:03 +1100
From: Paul Mackerras <paulus@samba.org>
To: David Howells <dhowells@redhat.com>
Cc: ebiederm@xmission.com (Eric W. Biederman), akpm@osdl.org,
       linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
       torvalds@osdl.org, mingo@redhat.com, alan@redhat.com,
       linuxppc64-dev@ozlabs.org
Subject: Re: [PATCH] Document Linux's memory barriers [try #4] 
In-Reply-To: <32068.1142371612@warthog.cambridge.redhat.com>
References: <m1veujy47r.fsf@ebiederm.dsl.xmission.com>
	<16835.1141936162@warthog.cambridge.redhat.com>
	<32068.1142371612@warthog.cambridge.redhat.com>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Howells writes:

> +	CPU 1		CPU 2		COMMENT
> +	===============	===============	=======================================
> +					a == 0, b == 1 and p == &a, q == &a
> +	b = 2;
> +	smp_wmb();			Make sure b is changed before p
> +	p = &b;		q = p;
> +			d = *q;
> +
> +then old data values may be used in the address calculation for the second
> +value, potentially resulting in q == &b and d == 0 being seen, which is never
> +correct.  What is required is a data dependency memory barrier:

No, that's not the problem.  The problem is that you can get q == &b
and d == 1, believe it or not.  That is, you can see the new value of
the pointer but the old value of the thing pointed to.

Paul.
