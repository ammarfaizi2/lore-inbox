Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262240AbUCWDOZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Mar 2004 22:14:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262286AbUCWDOZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Mar 2004 22:14:25 -0500
Received: from holomorphy.com ([207.189.100.168]:61074 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S262240AbUCWDOW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Mar 2004 22:14:22 -0500
Date: Mon, 22 Mar 2004 19:13:45 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Paul Jackson <pj@sgi.com>
Cc: colpatch@us.ibm.com, linux-kernel@vger.kernel.org, mbligh@aracnet.com,
       akpm@osdl.org, haveblue@us.ibm.com, hch@infradead.org
Subject: Re: [PATCH] Introduce nodemask_t ADT [0/7]
Message-ID: <20040323031345.GY2045@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Paul Jackson <pj@sgi.com>, colpatch@us.ibm.com,
	linux-kernel@vger.kernel.org, mbligh@aracnet.com, akpm@osdl.org,
	haveblue@us.ibm.com, hch@infradead.org
References: <1079659184.8149.355.camel@arrakis> <20040318175654.435b1639.pj@sgi.com> <1079737351.17841.51.camel@arrakis> <20040319165928.45107621.pj@sgi.com> <20040320031843.GY2045@holomorphy.com> <20040320000235.5e72040a.pj@sgi.com> <20040320111340.GA2045@holomorphy.com> <20040322171243.070774e5.pj@sgi.com> <20040323020940.GV2045@holomorphy.com> <20040322183918.5e0f17c7.pj@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040322183918.5e0f17c7.pj@sgi.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 22, 2004 at 06:39:18PM -0800, Paul Jackson wrote:
> From this I conjecture that I can provide a single call:
>     cpumask_and(cpumask_t d, cpumask_t s1, cpumask_t s2);
> that works on both normal (1 to 32 cpu) systems and on big iron systems,
> with traditional 'C' pass by value semantics, all derived from a single
> mask type that works for both node and cpu masks.
> The one sticky point evident to me so far would be if some generic code
> were passing a cpumask_t across a function call boundary, and needed to
> be optimum for both small and sparc64 - one would want to pass by value,
> the other would want to pass a pointer to the cpumask.
> This is not your fathers 'C'.  The compile time inlining and
> optimization provided by gcc enables it to do a lot more than Dennis
> Ritchie's original C compiler that I learned on.

gcc flat out miscompiled such inlines last I checked (Zwane shipped the
bugreport IIRC). Either this kind of good behavior is not universally
observable or a miracle occurred and gcc's codegen went from incorrect
to 1980's (fscking patents).

Anyhow, this was also an observation of the code effectively made in
isolation; uninlining and other catastrophes do happen.

If people really thinks this works and/or don't care when it doesn't,
go for it. Last time I heard they did; who knows, the answer may be
different this time.


-- wli
