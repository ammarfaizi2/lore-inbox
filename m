Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269588AbTGJVv7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 17:51:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269602AbTGJVv4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 17:51:56 -0400
Received: from are.twiddle.net ([64.81.246.98]:14521 "EHLO are.twiddle.net")
	by vger.kernel.org with ESMTP id S269588AbTGJVtj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 17:49:39 -0400
Date: Thu, 10 Jul 2003 15:04:04 -0700
From: Richard Henderson <rth@twiddle.net>
To: Bernardo Innocenti <bernie@develer.com>
Cc: Andrea Arcangeli <andrea@suse.de>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel@vger.kernel.org, Peter Chubb <peter@chubb.wattle.id.au>,
       Andrew Morton <akpm@digeo.com>, Ian Molton <spyro@f2s.com>,
       gcc@gcc.gnu.org
Subject: Re: [PATCH] Fix do_div() for all architectures
Message-ID: <20030710220404.GA20109@twiddle.net>
Mail-Followup-To: Bernardo Innocenti <bernie@develer.com>,
	Andrea Arcangeli <andrea@suse.de>,
	Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
	Peter Chubb <peter@chubb.wattle.id.au>,
	Andrew Morton <akpm@digeo.com>, Ian Molton <spyro@f2s.com>,
	gcc@gcc.gnu.org
References: <200307060133.15312.bernie@develer.com> <20030710161859.GP16313@dualathlon.random> <20030710163918.GB18697@twiddle.net> <200307102131.45474.bernie@develer.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200307102131.45474.bernie@develer.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 10, 2003 at 09:31:45PM +0200, Bernardo Innocenti wrote:
> Just to open some interesting speculation, do you think we'd
> get better code by just getting rid of __attribute__((pure))
> or by changing __do_div64() to do something like this?
> 
>  typedef struct { uint64_t quot, uint32_t rem } __quotrem64;
>  __quotrem64 __do_div64(uint64_t div, uint32_t base) __attribute__((const));

No.  Most targets require structures be returned in memory.

If people really care beyond the generic, they'll write
special assembly for it.


r~
