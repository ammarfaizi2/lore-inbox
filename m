Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266038AbUGOAqn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266038AbUGOAqn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jul 2004 20:46:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265229AbUGOAoo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jul 2004 20:44:44 -0400
Received: from holomorphy.com ([207.189.100.168]:1953 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S265201AbUGOAn7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jul 2004 20:43:59 -0400
Date: Wed, 14 Jul 2004 17:43:50 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Peter Zaitsev <peter@mysql.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: VM Problems in 2.6.7 (Too active OOM Killer)
Message-ID: <20040715004350.GD3411@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrea Arcangeli <andrea@suse.de>, Peter Zaitsev <peter@mysql.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <1089771823.15336.2461.camel@abyss.home> <20040714031701.GT974@dualathlon.random> <1089776640.15336.2557.camel@abyss.home> <20040713211721.05781fb7.akpm@osdl.org> <1089848823.15336.3895.camel@abyss.home> <20040715000438.GS974@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040715000438.GS974@dualathlon.random>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 15, 2004 at 02:04:38AM +0200, Andrea Arcangeli wrote:
> About the ZONE_NORMAL shortage without swap, rather than running
> cpu-cache-hungry memcopies from lowmemzone to highmem (or even worse to
> pass through swap like it happens in 2.6 mainline with swap enabled), I
> believe it's better to reserve some ram in the lowmem zone, 800M of ram
> on a 32G box should be a cheap price to pay compared to the cpu/IO cost
> involved in moving memory around during the bench.

I wouldn't be so quick to dismiss it. There are enough physical
placement issues already even without pinned userspace pages.
Empowering the kernel to remain largely oblivious to physical placement
of userspace pages would be very convenient and eliminate many problems.
Also, given that the alternatives are IO and allocation failure, I
wouldn't be so quick to dismiss it as slow, either. Unfortunately even
page relocation is only a half-measure while mapping->gfp_mask persists.


-- wli
