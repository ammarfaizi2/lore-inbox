Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265276AbUAPFwk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jan 2004 00:52:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265278AbUAPFwk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jan 2004 00:52:40 -0500
Received: from holomorphy.com ([199.26.172.102]:44966 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S265276AbUAPFwi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jan 2004 00:52:38 -0500
Date: Thu, 15 Jan 2004 21:52:30 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Paul Jackson <pj@sgi.com>, joe.korty@ccur.com, paulus@samba.org,
       linux-kernel@vger.kernel.org
Subject: Re: seperator error in __mask_snprintf_len
Message-ID: <20040116055230.GA9645@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@osdl.org>, Paul Jackson <pj@sgi.com>,
	joe.korty@ccur.com, paulus@samba.org, linux-kernel@vger.kernel.org
References: <16381.57040.576175.977969@cargo.ozlabs.ibm.com> <20040108225929.GA24089@tsunami.ccur.com> <16381.61618.275775.487768@cargo.ozlabs.ibm.com> <20040114150331.02220d4d.pj@sgi.com> <20040115002703.GA20971@tsunami.ccur.com> <20040114204009.3dc4c225.pj@sgi.com> <20040115081533.63c61d7f.akpm@osdl.org> <20040115181525.GA31086@tsunami.ccur.com> <20040115211402.04c5c2c4.pj@sgi.com> <20040115212613.3e345518.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040115212613.3e345518.akpm@osdl.org>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Jackson <pj@sgi.com> wrote:
>>   Should any of the other inline routines in include/bitmap.h
>>    be moved to your new file lib/bitmap.c?

On Thu, Jan 15, 2004 at 09:26:13PM -0800, Andrew Morton wrote:
> Yup.   The below patch will be in 2.6.1-mm4:
> uninline bitmap functions
> - A couple of them are using alloca (via DECLARE_BITMAP) and this generates
>   a cannot-inline warning with -Winline.
> - These functions are too big to inline anwyay.

Uninlining is good (I originally wanted to avoid controversy by not
having them compiled in unless they were called), but it's also possible
to remove the stack allocations entirely with more sophisticated
implementations. These are actually quite dumb as implementations of the
bitmap operations, and meant to look simple as opposed to performing well
or being well-behaved with respect to stackspace.


-- wli
