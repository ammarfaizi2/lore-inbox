Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262224AbVD1Ssh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262224AbVD1Ssh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Apr 2005 14:48:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262222AbVD1Ssh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Apr 2005 14:48:37 -0400
Received: from stat16.steeleye.com ([209.192.50.48]:47555 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S262218AbVD1SsV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Apr 2005 14:48:21 -0400
Subject: Re: [RFC] unify semaphore implementations
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Benjamin LaHaise <bcrl@kvack.org>
Cc: linux-arch@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20050428182926.GC16545@kvack.org>
References: <20050428182926.GC16545@kvack.org>
Content-Type: text/plain
Date: Thu, 28 Apr 2005 11:48:09 -0700
Message-Id: <1114714089.5022.3.camel@mulgrave>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-04-28 at 14:29 -0400, Benjamin LaHaise wrote:
> Please review the following series of patches for unifying the 
> semaphore implementation across all architectures (not posted as 
> they're about 350K), as they have only been tested on x86-64.  The 
> code generated is functionally identical to the earlier i386 
> variant, but since gcc has no way of taking condition codes as 
> results, there are two additional instructions inserted from the 
> use of generic atomic operations.  All told the >6000 lines of code 
> deleted makes for a much easier job for subsequent patches changing 
> semaphore functionality.  Cheers,

It's all very well for platforms that have efficient atomic operations.
However, on parisc we have no such luxury (the processor has no atomic
operations, so we have to fiddle them in the kernel using locks), so it
looks like you're making our semaphore operations less efficient.

Could you come up with a less monolithic way to share this so that we
can still do a spinlock semaphore implementation instead of an atomic op
based one?

Thanks,

James


