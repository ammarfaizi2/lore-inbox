Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264294AbTH1TaQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Aug 2003 15:30:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264313AbTH1TaQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Aug 2003 15:30:16 -0400
Received: from holomorphy.com ([66.224.33.161]:32708 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S264294AbTH1TaM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Aug 2003 15:30:12 -0400
Date: Thu, 28 Aug 2003 12:31:23 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>
Cc: James Bottomley <James.Bottomley@SteelEye.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] make voyager work again after the cpumask_t changes
Message-ID: <20030828193123.GI4306@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@osdl.org>,
	James Bottomley <James.Bottomley@SteelEye.com>,
	linux-kernel@vger.kernel.org
References: <1062097375.1952.41.camel@mulgrave> <20030828121016.2c0e2716.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030828121016.2c0e2716.akpm@osdl.org>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Bottomley <James.Bottomley@SteelEye.com> wrote:
>> Most is just simple fixes; however, the needless change from atomic to
>> non-atomic operations in smp_invalidate_interrupt() caused me a lot of
>> pain to track down since it introduced some very subtle bugs.

On Thu, Aug 28, 2003 at 12:10:16PM -0700, Andrew Morton wrote:
> Yes, the generic code was like that too.  It was causing lockups.  Sorry, I
> did not realise that voyager had a private invalidatation implementation.
> Officially smp_invalidate_needed should be a cpumask_t and
> smp_invalidate_interrupt() should be using cpu_isset() rather than
> open-coded bitops.  For all those 64-way voyagers out there ;)
> (Actually it is legitimate: you may want to run a NR_CPUS=48 kernel on a
> 2-way voyager just for testing purposes).  I'll drop your patch in as-is,
> and maybe Bill can take a look at cpumaskifying it sometime?

I'm not convinced it's worth it; AIUI there are architectural limits to
Voyager that prevent it from ever supporting > 32x in hardware, though
it could be worth doing so in tandem with an across-the-board all-
subarch extension of generic i386 support.


-- wli
