Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261793AbUCWBOb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Mar 2004 20:14:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261807AbUCWBOb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Mar 2004 20:14:31 -0500
Received: from mtvcafw.SGI.COM ([192.48.171.6]:7460 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S261793AbUCWBO3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Mar 2004 20:14:29 -0500
Date: Mon, 22 Mar 2004 17:12:43 -0800
From: Paul Jackson <pj@sgi.com>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: colpatch@us.ibm.com, linux-kernel@vger.kernel.org, mbligh@aracnet.com,
       akpm@osdl.org, haveblue@us.ibm.com, hch@infradead.org
Subject: Re: [PATCH] Introduce nodemask_t ADT [0/7]
Message-Id: <20040322171243.070774e5.pj@sgi.com>
In-Reply-To: <20040320111340.GA2045@holomorphy.com>
References: <1079651064.8149.158.camel@arrakis>
	<20040318165957.592e49d3.pj@sgi.com>
	<1079659184.8149.355.camel@arrakis>
	<20040318175654.435b1639.pj@sgi.com>
	<1079737351.17841.51.camel@arrakis>
	<20040319165928.45107621.pj@sgi.com>
	<20040320031843.GY2045@holomorphy.com>
	<20040320000235.5e72040a.pj@sgi.com>
	<20040320111340.GA2045@holomorphy.com>
Organization: SGI
X-Mailer: Sylpheed version 0.9.8 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > The current nested and ifdef'd complexity of the cpumask macro
> > headers works against such efficient coding - it's non-trivial to see
> > just what macros are available. The youngins reading this may not
> > appreciate the value of reducing brain load; but the oldins might.
> 
> It was painful enough just to preserve semantics across such a far-
> ranging set of changes. Ideally, yes, I would have done this in the
> first place.

I'm not trying to get on your case, Bill, for not creating and applying
more various cpumask functions.  Rather I am looking for ways to make
that API easier for others to use and use well.  If the situations that
passed about temporary cpumasks can be collapsed into single calls that
are more efficient, then that is one way to make progress on this.

Taking masks to be a struct of an array of unsigned longs seems to come
pretty close.  The sparc64 arch would want to pass a pointer to this
apparently, rather than the struct itself - faster for them. Some other
smaller archs would _not_ want to pass a pointer, but rather the (one
word, for them) value - avoids a dereference for them.  In arch specific
code, each arch can choose which way works best for them.  I need to
identify any generic code where these preferences collide.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
