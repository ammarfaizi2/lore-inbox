Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261969AbUCWCLc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Mar 2004 21:11:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262000AbUCWCKz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Mar 2004 21:10:55 -0500
Received: from holomorphy.com ([207.189.100.168]:44946 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S261969AbUCWCJu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Mar 2004 21:09:50 -0500
Date: Mon, 22 Mar 2004 18:09:40 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Paul Jackson <pj@sgi.com>
Cc: colpatch@us.ibm.com, linux-kernel@vger.kernel.org, mbligh@aracnet.com,
       akpm@osdl.org, haveblue@us.ibm.com, hch@infradead.org
Subject: Re: [PATCH] Introduce nodemask_t ADT [0/7]
Message-ID: <20040323020940.GV2045@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Paul Jackson <pj@sgi.com>, colpatch@us.ibm.com,
	linux-kernel@vger.kernel.org, mbligh@aracnet.com, akpm@osdl.org,
	haveblue@us.ibm.com, hch@infradead.org
References: <1079651064.8149.158.camel@arrakis> <20040318165957.592e49d3.pj@sgi.com> <1079659184.8149.355.camel@arrakis> <20040318175654.435b1639.pj@sgi.com> <1079737351.17841.51.camel@arrakis> <20040319165928.45107621.pj@sgi.com> <20040320031843.GY2045@holomorphy.com> <20040320000235.5e72040a.pj@sgi.com> <20040320111340.GA2045@holomorphy.com> <20040322171243.070774e5.pj@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040322171243.070774e5.pj@sgi.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 22, 2004 at 05:12:43PM -0800, Paul Jackson wrote:
> I'm not trying to get on your case, Bill, for not creating and applying
> more various cpumask functions.  Rather I am looking for ways to make
> that API easier for others to use and use well.  If the situations that
> passed about temporary cpumasks can be collapsed into single calls that
> are more efficient, then that is one way to make progress on this.
> Taking masks to be a struct of an array of unsigned longs seems to come
> pretty close.  The sparc64 arch would want to pass a pointer to this
> apparently, rather than the struct itself - faster for them. Some other
> smaller archs would _not_ want to pass a pointer, but rather the (one
> word, for them) value - avoids a dereference for them.  In arch specific
> code, each arch can choose which way works best for them.  I need to
> identify any generic code where these preferences collide.

I generally like the idea of the arches getting their choice here (heck,
even wrt. representation; e.g. some arch might want an array of cpuid
numbers and not a bitmap at all due to extremely sparse cpuid's or some
such nonsense). The asm-generic stuff was largely a question of
reducing diffsize, preemptive code consolidation, etc.

I don't believe normal C (i.e. sans typedef) will allow needed
ambiguities that make UP/small SMP/etc. compile things out nicely, but
if you can get the requirement of the stuff totally compiling out
dropped or do it in normal C somehow, go for it. I'd call it a cleanup.


-- wli
