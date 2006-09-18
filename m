Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750944AbWIRP4K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750944AbWIRP4K (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Sep 2006 11:56:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751798AbWIRP4J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Sep 2006 11:56:09 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:8682 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1750928AbWIRP4I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Sep 2006 11:56:08 -0400
Subject: Re: tracepoint maintainance models
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Ingo Molnar <mingo@elte.hu>
Cc: "Frank Ch. Eigler" <fche@redhat.com>, Paul Mundt <lethal@linux-sh.org>,
       Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       linux-kernel <linux-kernel@vger.kernel.org>, Jes Sorensen <jes@sgi.com>,
       Andrew Morton <akpm@osdl.org>, Tom Zanussi <zanussi@us.ibm.com>,
       Richard J Moore <richardj_moore@uk.ibm.com>,
       Michel Dagenais <michel.dagenais@polymtl.ca>,
       Christoph Hellwig <hch@infradead.org>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, William Cohen <wcohen@redhat.com>,
       "Martin J. Bligh" <mbligh@mbligh.org>
In-Reply-To: <20060918152230.GA12631@elte.hu>
References: <450D182B.9060300@opersys.com>
	 <20060917112128.GA3170@localhost.usen.ad.jp>
	 <20060917143623.GB15534@elte.hu> <20060917153633.GA29987@Krystal>
	 <20060918000703.GA22752@elte.hu> <450DF28E.3050101@opersys.com>
	 <20060918011352.GB30835@elte.hu> <20060918122527.GC3951@redhat.com>
	 <20060918150231.GA8197@elte.hu>
	 <1158594491.6069.125.camel@localhost.localdomain>
	 <20060918152230.GA12631@elte.hu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 18 Sep 2006 17:19:01 +0100
Message-Id: <1158596341.6069.130.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Llu, 2006-09-18 am 17:22 +0200, ysgrifennodd Ingo Molnar:
> yeah - but i think to make it easier for SystemTap to insert a 
> low-overhead probe there needs to be a 5-byte NOP inserted. There wont 
> be any function call or condition at that place. At most there will be 
> some minimal impact on the way gcc compiles the code in that function,

And more L1 misses. It seems that this problem should be solved by
jprobes and your int3 optimisation work.

> SystemTap. For example at the point of the probe gcc might already have 
> destroyed a register-passed function parameter. 

So its L1 misses more register reloads and the like. Sounds more and
more like wasted clock cycles for debug. Most of these watchpoints will
run billions of times a day on millions of machines none of whom are
using any debugging. You are optimising the corner case (in the extreme
in fact). Its one thing to dump trace helper data into the kernel, its
another when we all get to pay for it all the time when we don't need to
(or we compile it out at which point it offers nothing anyway).

Alan

