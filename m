Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751025AbWBFKRQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751025AbWBFKRQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 05:17:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751031AbWBFKRQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 05:17:16 -0500
Received: from smtp.osdl.org ([65.172.181.4]:33441 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751025AbWBFKRO convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 05:17:14 -0500
Date: Mon, 6 Feb 2006 02:16:39 -0800
From: Andrew Morton <akpm@osdl.org>
To: Eric Dumazet <dada1@cosmosbay.com>
Cc: bcrl@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH, V2] i386: instead of poisoning .init zone, change
 protection bits to force a fault
Message-Id: <20060206021639.2e9d9157.akpm@osdl.org>
In-Reply-To: <43E71FEC.6020506@cosmosbay.com>
References: <m1r76rft2t.fsf@ebiederm.dsl.xmission.com>
	<m17j8jfs03.fsf@ebiederm.dsl.xmission.com>
	<20060128235113.697e3a2c.akpm@osdl.org>
	<200601291620.28291.ioe-lkml@rameria.de>
	<20060129113312.73f31485.akpm@osdl.org>
	<43DD1FDC.4080302@cosmosbay.com>
	<20060129200504.GD28400@kvack.org>
	<43DD2C15.1090800@cosmosbay.com>
	<20060204144111.7e33569f.akpm@osdl.org>
	<43E7108A.8030001@cosmosbay.com>
	<20060206012809.3045207c.akpm@osdl.org>
	<43E71FEC.6020506@cosmosbay.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric Dumazet <dada1@cosmosbay.com> wrote:
>
> Andrew Morton a écrit :
> 
> > But I'm inclined to drop the whole patch - I don't see how it can detect
> > any bugs which CONFIG_DEBUG_PAGEALLOC won't find.
> > 
> 
> If CONFIG_DEBUG_PAGEALLOC is selected, does a page freed by free_page(addr); 
> guaranted not being reused later ?

No.

So with your patch, any access to the freed page will oops.  With
CONFIG_DEBUG_PAGEALLOC it'll only oops if that page is presently free.

So if enough people run with CONFIG_DEBUG_PAGEALLOC for enough time, we'll
find the same bugs.

> Anyway, the CONFIG_DEBUG_INITDATA was a temporary patch in order to track the 
> accesses to non possible cpus percpu data. So if you feel all such accesses 
> were cleaned, we can drop the patch...

I think so..
