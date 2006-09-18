Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751840AbWIRQjq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751840AbWIRQjq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Sep 2006 12:39:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751842AbWIRQjq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Sep 2006 12:39:46 -0400
Received: from [81.2.110.250] ([81.2.110.250]:27804 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S1751840AbWIRQjp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Sep 2006 12:39:45 -0400
Subject: Re: tracepoint maintainance models
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Frank Ch. Eigler" <fche@redhat.com>
Cc: Ingo Molnar <mingo@elte.hu>, Paul Mundt <lethal@linux-sh.org>,
       Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       linux-kernel <linux-kernel@vger.kernel.org>, Jes Sorensen <jes@sgi.com>,
       Andrew Morton <akpm@osdl.org>, Tom Zanussi <zanussi@us.ibm.com>,
       Richard J Moore <richardj_moore@uk.ibm.com>,
       Michel Dagenais <michel.dagenais@polymtl.ca>,
       Christoph Hellwig <hch@infradead.org>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, William Cohen <wcohen@redhat.com>,
       "Martin J. Bligh" <mbligh@mbligh.org>
In-Reply-To: <20060918161526.GL3951@redhat.com>
References: <20060917143623.GB15534@elte.hu>
	 <20060917153633.GA29987@Krystal> <20060918000703.GA22752@elte.hu>
	 <450DF28E.3050101@opersys.com> <20060918011352.GB30835@elte.hu>
	 <20060918122527.GC3951@redhat.com> <20060918150231.GA8197@elte.hu>
	 <1158594491.6069.125.camel@localhost.localdomain>
	 <20060918152230.GA12631@elte.hu>
	 <1158596341.6069.130.camel@localhost.localdomain>
	 <20060918161526.GL3951@redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 18 Sep 2006 18:02:07 +0100
Message-Id: <1158598927.6069.141.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Llu, 2006-09-18 am 12:15 -0400, ysgrifennodd Frank Ch. Eigler:
> > [...] So its L1 misses more register reloads and the like. Sounds
> > more and more like wasted clock cycles for debug. [...]
> 
> But it's not just "for debug"!  It is for system administrators,
> end-users, developers.

It is for debug. System administrators and developers also do debug,
they may just use different tools. The percentage of schedule() calls
executed across every Linux box on the planet where debug is enabled is
so close to nil its noise. Even with traces that won't change.

> Indeed, there will be some non-zero execution-time cost.  We must be
> willing to pay *something* in order to enable this functionality.

There is an implementation which requires no penalty is paid. Create a
new elf section which contains something like

	[address to whack with int3]
	[or info for jprobes to make better use]
	[name for debug tools to find]
	[line number in source to parse the gcc debug data]


