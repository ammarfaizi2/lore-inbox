Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268648AbUILKyy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268648AbUILKyy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Sep 2004 06:54:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268652AbUILKyy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Sep 2004 06:54:54 -0400
Received: from holomorphy.com ([207.189.100.168]:50820 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S268648AbUILKyv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Sep 2004 06:54:51 -0400
Date: Sun, 12 Sep 2004 03:54:36 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Paul Jackson <pj@sgi.com>
Cc: Hans Reiser <reiser@namesys.com>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.9-rc1-mm4 sparc reiser4 build broken - undefined atomic_sub_and_test
Message-ID: <20040912105436.GP2660@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Paul Jackson <pj@sgi.com>, Hans Reiser <reiser@namesys.com>,
	linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
References: <20040912031235.48c738ae.pj@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040912031235.48c738ae.pj@sgi.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 12, 2004 at 03:12:35AM -0700, Paul Jackson wrote:
> The final link fails with:
>   fs/built-in.o(.text+0x58618): In function `end_io_handler':
>   : undefined reference to `atomic_sub_and_test'
>   make[1]: *** [arch/sparc/boot/image] Error 1
> The macro 'atomic_sub_and_test' is defined for more or less every other
> arch, in various include/asm-*/atomic.h files, but not defined for
> sparc.
> This macro is used in:
> 	fs/reiser4/flush_queue.c:
>                if (atomic_sub_and_test(bio->bi_vcnt, &fq->nr_submitted))
> If I disable the config items:
>   CONFIG_REISER4_FS=y
>   CONFIG_REISER4_LARGE_KEY=y
> then it builds ok (with the bogus #else removed from cachefs.h, as
> already reported on lkml).

I'm loath to add this for the sake of reiser4; I rather favor the use of
portable constructs.


-- wli
