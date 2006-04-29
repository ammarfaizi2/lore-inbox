Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751210AbWD2CtX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751210AbWD2CtX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Apr 2006 22:49:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751471AbWD2CtX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Apr 2006 22:49:23 -0400
Received: from [198.99.130.12] ([198.99.130.12]:22493 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S1751210AbWD2CtX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Apr 2006 22:49:23 -0400
Date: Fri, 28 Apr 2006 21:49:56 -0400
From: Jeff Dike <jdike@addtoit.com>
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       Heiko Carstens <heiko.carstens@de.ibm.com>,
       Bodo Stroesser <bstroesser@fujitsu-siemens.com>
Subject: Re: [uml-devel] [RFC] PATCH 3/4 - Time virtualization : PTRACE_SYSCALL_MASK
Message-ID: <20060429014956.GB9734@ccure.user-mode-linux.org>
References: <200604131720.k3DHKqdr004720@ccure.user-mode-linux.org> <200604261747.54660.blaisorblade@yahoo.it> <20060426154607.GA8628@ccure.user-mode-linux.org> <200604282228.46681.blaisorblade@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200604282228.46681.blaisorblade@yahoo.it>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 28, 2006 at 10:28:46PM +0200, Blaisorblade wrote:
> Ok, this gives us a definite proposal, which I finally like:
> 
> * to exclude sys_tee:
> 
> bitmask = 0;
> set_bit(__NR_tee, bitmask);
> ptrace(PTRACE_SET_NOTRACE, bitmask);
> 
> * to trace only sys_tee:
> 
> bitmask = 0;
> set_bit(__NR_tee, bitmask);
> ptrace(PTRACE_SET_TRACEONLY, bitmask);

Yup, I like this.

> the call fails if any of them is 1, and in the failure case E2BIG or 
> EOVERFLOW is returned

strerror(E2BIG) is "Arg list too long"

strerror(EOVERFLOW) is "Value too large for defined data type"

Neither of those seems right.  I'd just as soon stick with -EINVAL.

				Jeff


