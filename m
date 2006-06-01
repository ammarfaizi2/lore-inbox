Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965312AbWFAVNT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965312AbWFAVNT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 17:13:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965313AbWFAVNT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 17:13:19 -0400
Received: from jurassic.park.msu.ru ([195.208.223.243]:22025 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id S965312AbWFAVNS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 17:13:18 -0400
Date: Fri, 2 Jun 2006 01:13:17 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Andrew Morton <akpm@osdl.org>
Cc: earny@net4u.de, list-lkml@net4u.de, linux-kernel@vger.kernel.org,
       rth@twiddle.net
Subject: Re: ALPHA 2.6.17-rc5 AIC7###: does not boot
Message-ID: <20060602011317.A1674@jurassic.park.msu.ru>
References: <200605301834.19795.list-lkml@net4u.de> <20060531154648.53539006.akpm@osdl.org> <20060601201619.A978@jurassic.park.msu.ru> <200606011911.36962.list-lkml@net4u.de> <20060601103346.3e3544ab.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20060601103346.3e3544ab.akpm@osdl.org>; from akpm@osdl.org on Thu, Jun 01, 2006 at 10:33:46AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 01, 2006 at 10:33:46AM -0700, Andrew Morton wrote:
> Ivan, should I scoot that patch into 2.6.17 as-is?

Hopefully yes. Here's a bit more informative description:

After removal of fixup_cpu_present_map() function Alpha ended up
with an empty cpu_present_map, so secondary CPUs on SMP systems are
not being started.
Worse, on some platforms we route interrupts to secondary CPUs using
cpu_possible_map which is still populated properly. As a result,
these interrupts go nowhere so the machines like DP264 aren't able
to boot even with a primary CPU.
Fixed basically by s/cpu_present_mask/cpu_present_map/.

Ivan.
