Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262474AbVCJJKs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262474AbVCJJKs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 04:10:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262476AbVCJJKs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 04:10:48 -0500
Received: from fire.osdl.org ([65.172.181.4]:51150 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262474AbVCJJKc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 04:10:32 -0500
Date: Thu, 10 Mar 2005 01:09:55 -0800
From: Andrew Morton <akpm@osdl.org>
To: Andi Kleen <ak@muc.de>
Cc: greearb@candelatech.com, nickpiggin@yahoo.com.au,
       linux-kernel@vger.kernel.org
Subject: Re: BUG: Slowdown on 3000 socket-machines tracked down
Message-Id: <20050310010955.000ea843.akpm@osdl.org>
In-Reply-To: <m1is3zvprz.fsf@muc.de>
References: <4229E805.3050105@rapidforum.com>
	<422BAAC6.6040705@candelatech.com>
	<422BB548.1020906@rapidforum.com>
	<422BC303.9060907@candelatech.com>
	<422BE33D.5080904@yahoo.com.au>
	<422C1D57.9040708@candelatech.com>
	<422C1EC0.8050106@yahoo.com.au>
	<422D468C.7060900@candelatech.com>
	<422DD5A3.7060202@rapidforum.com>
	<422F8A8A.8010606@candelatech.com>
	<422F8C58.4000809@rapidforum.com>
	<422F9259.2010003@candelatech.com>
	<422F93CE.3060403@rapidforum.com>
	<20050309211730.24b4fc93.akpm@osdl.org>
	<m1is3zvprz.fsf@muc.de>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen <ak@muc.de> wrote:
>
> In general to solve it one has to increase /proc/sys/vm/freepages
>  a lot.

/proc/sys/vm/min_free_kbytes

>  It would be nice though if the VM tuned itself dynamically to a lot
>  of GFP_ATOMIC requests. And maybe if GFP_ATOMIC was a bit more aggressive
>  and did some simple minded reclaiming that would be helpful too.
>  e.g. there could be a "easy to free" list in the VM for clean pages
>  where freeing is simple enough that it could be made interrupt safe.

I spose we could autotune the free memory thresholds somehow, if there is
good reason and a testcase.

Or we could run page reclaim from hard IRQ context - that could be a bit
expensive in terms of CPU consumption and latency though.

