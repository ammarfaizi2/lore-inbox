Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264922AbUEVIwl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264922AbUEVIwl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 May 2004 04:52:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264923AbUEVIwl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 May 2004 04:52:41 -0400
Received: from holomorphy.com ([207.189.100.168]:25224 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S264922AbUEVIwk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 May 2004 04:52:40 -0400
Date: Sat, 22 May 2004 01:52:36 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: mpm@selenic.com, linux-kernel@vger.kernel.org
Subject: Re: slab redzoning
Message-ID: <20040522085236.GL2161@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Manfred Spraul <manfred@colorfullife.com>, mpm@selenic.com,
	linux-kernel@vger.kernel.org
References: <20040522034902.GB2161@holomorphy.com> <40AF0911.6020000@colorfullife.com> <20040522082602.GJ2161@holomorphy.com> <40AF12C3.80902@colorfullife.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40AF12C3.80902@colorfullife.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:
>> It returns a false positive when size + 3*BYTES_PER_WORD == 2**n, e.g.
>> size == 16373. Here, fls(size - 1) == 13, but fls(size - 1 + 12) == 13
>> while size - 1 + 12 == 16384, where we'd want the check to fail.

On Sat, May 22, 2004 at 10:43:47AM +0200, Manfred Spraul wrote:
> No, 16373 must fail: After adding 12 bytes the object size would be 
> 16385, which would mean an order==3 allocation.
> And 16372 must succeed: 16384 is still an order==2 allocation.
> The idea is that there shouldn't be an allocation order increase due to 
> redzoning, and afaics that doesn't happen, except between 4082 and 4095 
> bytes.

Yes. While you've corrected the one-offs in my post (arithmetic is boring,
we have machines to do that for us now), 16372 remains in question as
far as I can tell.


-- wli
