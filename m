Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964836AbVL1PAb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964836AbVL1PAb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Dec 2005 10:00:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964837AbVL1PAb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Dec 2005 10:00:31 -0500
Received: from mx.pathscale.com ([64.160.42.68]:28846 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S964836AbVL1PAa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Dec 2005 10:00:30 -0500
Subject: Re: [RFC] [PATCH] Add memcpy32 function
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: Andi Kleen <ak@suse.de>
Cc: Matt Mackall <mpm@selenic.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <p73fyodmqn6.fsf@verdi.suse.de>
References: <1135301759.4212.76.camel@serpentine.pathscale.com>
	 <p73fyodmqn6.fsf@verdi.suse.de>
Content-Type: text/plain
Organization: PathScale, Inc.
Date: Wed, 28 Dec 2005 07:00:25 -0800
Message-Id: <1135782025.1527.104.camel@serpentine.pathscale.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-12-28 at 12:01 +0100, Andi Kleen wrote:

> What irritates me is that the original author said this copy
> would happen from user space in ipath.

I'm afraid there may have been some miscommunication there.

All of our uses of memcpy_toio32 (which uses memcpy32 on x86_64) copy
from kernel virtual addresses to MMIO space.  There's no direct copying
from userspace to MMIO space through the driver.

However, we do let userspace code directly access portions of our chip.
That code uses a routine that is exactly the same as memcpy32 to perform
MMIO writes.  That's where I think the confusion arose on the part of
whoever responded to you.

>  In that case you would need
> exception handling for all memory accesses to return EFAULT,
> otherwise everybody can crash the kernel.

Just to be clear: we use copy_{to,from}_user for all copies between
userspace and driver, and we return -EFAULT on short copies, so we're
already doing the right thing in that sort of case.

Sorry for the confusion.  I hope this clears that business up.

	<b

