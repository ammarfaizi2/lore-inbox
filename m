Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265655AbUGNUAU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265655AbUGNUAU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jul 2004 16:00:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265508AbUGNUAU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jul 2004 16:00:20 -0400
Received: from av3-2-sn3.vrr.skanova.net ([81.228.9.110]:48256 "EHLO
	av3-2-sn3.vrr.skanova.net") by vger.kernel.org with ESMTP
	id S265655AbUGNUAN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jul 2004 16:00:13 -0400
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: Can't make use of swap memory in 2.6.7-bk19
References: <m2brir9t6d.fsf@telia.com> <40ECADF8.7010207@yahoo.com.au>
	<m2fz82hq8c.fsf@telia.com> <20040708012005.6232a781.akpm@osdl.org>
	<40ED049B.2020406@yahoo.com.au>
	<Pine.LNX.4.58.0407081126360.3104@telia.com>
	<20040714052010.GE3411@holomorphy.com> <m2u0wayisp.fsf@telia.com>
	<20040714105713.GP3411@holomorphy.com> <m2hdsabvdu.fsf@telia.com>
	<20040714132256.GR3411@holomorphy.com>
From: Peter Osterlund <petero2@telia.com>
Date: 14 Jul 2004 22:00:03 +0200
In-Reply-To: <20040714132256.GR3411@holomorphy.com>
Message-ID: <m2acy2xsu4.fsf@telia.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III <wli@holomorphy.com> writes:

> The only difference laptop_mode should have is dirty memory handling,
> but you don't have any dirty memory. Maybe swapcache is fooling things.
> Most notably, add_to_swap() sets the page dirty...
> 
> Something is very wrong here... could you try this?
...
> Index: oom-2.6.8-rc1/mm/vmscan.c
> ===================================================================
> --- oom-2.6.8-rc1.orig/mm/vmscan.c	2004-07-14 06:17:13.876343912 -0700
> +++ oom-2.6.8-rc1/mm/vmscan.c	2004-07-14 06:22:15.986416200 -0700
> @@ -417,7 +417,8 @@
>  				goto keep_locked;
>  			if (!may_enter_fs)
>  				goto keep_locked;
> -			if (laptop_mode && !sc->may_writepage)
> +			if (laptop_mode && !sc->may_writepage &&
> +							!PageSwapCache(page))
>  				goto keep_locked;
>  
>  			/* Page is dirty, try to write it out here */

This patch fixes my problem. No more bogus OOMs in laptop mode, and
the test program runs approximately equally fast in laptop mode as it
does in "normal" mode.

Thanks.

-- 
Peter Osterlund - petero2@telia.com
http://w1.894.telia.com/~u89404340
