Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268484AbUILGKQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268484AbUILGKQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Sep 2004 02:10:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268486AbUILGKQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Sep 2004 02:10:16 -0400
Received: from ozlabs.org ([203.10.76.45]:6537 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S268484AbUILGKM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Sep 2004 02:10:12 -0400
Date: Sun, 12 Sep 2004 16:09:04 +1000
From: Anton Blanchard <anton@samba.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Zwane Mwaikambo <zwane@linuxpower.ca>, Andrew Morton <akpm@osdl.org>,
       torvalds@osdl.org, paulus@samba.org, linux-kernel@vger.kernel.org,
       jun.nakajima@intel.com, ak@suse.de, mingo@elte.hu
Subject: Re: [PATCH] Yielding processor resources during lock contention
Message-ID: <20040912060904.GJ32755@krispykreme>
References: <Pine.LNX.4.58.0409090754270.5912@ppc970.osdl.org> <Pine.LNX.4.53.0409091107450.15087@montezuma.fsmlabs.com> <Pine.LNX.4.53.0409120009510.2297@montezuma.fsmlabs.com> <20040911220003.0e9061ad.akpm@osdl.org> <Pine.LNX.4.53.0409120108310.2297@montezuma.fsmlabs.com> <4143D16F.30500@yahoo.com.au> <Pine.LNX.4.53.0409120131000.2297@montezuma.fsmlabs.com> <4143D491.6070006@yahoo.com.au> <Pine.LNX.4.53.0409120146020.2297@montezuma.fsmlabs.com> <4143D855.9070005@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4143D855.9070005@yahoo.com.au>
User-Agent: Mutt/1.5.6+20040818i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> OK that sounds alight.
> 
> If it is a "I'm going to be spinning for ages, so schedule me off *now*"
> then I think it is wrong... but if it just allows you to keep the hypervisor
> preemption turned on, then fine.

The hypervisor can preempt us anywhere but we can give it clues so it
tends to preempt us at better times.

Within a few instructions the hypervisor should be able to answer the
big question: is the cpu Im waiting for currently scheduled on another
cpu. If it is then it might be best for the hypervisor to leave us
alone.

If it isnt then the spin time will most likely be dominated by how
long it takes to get that cpu scheduled again and the hypervisor should
make an effort to schedule it.

Anton
