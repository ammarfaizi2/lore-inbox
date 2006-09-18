Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751842AbWIRQkm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751842AbWIRQkm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Sep 2006 12:40:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751844AbWIRQkl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Sep 2006 12:40:41 -0400
Received: from [81.2.110.250] ([81.2.110.250]:28316 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S1751842AbWIRQkk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Sep 2006 12:40:40 -0400
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
In-Reply-To: <20060918161511.GA21204@elte.hu>
References: <20060917143623.GB15534@elte.hu>
	 <20060917153633.GA29987@Krystal> <20060918000703.GA22752@elte.hu>
	 <450DF28E.3050101@opersys.com> <20060918011352.GB30835@elte.hu>
	 <20060918122527.GC3951@redhat.com> <20060918150231.GA8197@elte.hu>
	 <1158594491.6069.125.camel@localhost.localdomain>
	 <20060918152230.GA12631@elte.hu>
	 <1158596341.6069.130.camel@localhost.localdomain>
	 <20060918161511.GA21204@elte.hu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 18 Sep 2006 18:02:10 +0100
Message-Id: <1158598930.6069.143.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Llu, 2006-09-18 am 18:15 +0200, ysgrifennodd Ingo Molnar:
> Do you consider a single 5-byte NOP for a judiciously chosen 50 places 
> in the kernel unacceptable? Note that the argument has shifted from 

Its not neccessary. The question about acceptability doesn't come up.

> static tracers to dynamic tracers: this _is_ about SystemTap: it adds 
> points to the kernel where we can _guarantee_ that a dynamic probe can 
> be inserted. 

That already exists. You don't always know the address of the point.
Knowing where to stick the probe is out of line, shoving nops in the
code is an ugly unneccessary hack.

You can't really have it both ways - you argued that the performance
improvement for LTT static traces wasn't justification and pointed out
jprobes then optimised int3. Now if you want to do markup for awkward
tracepoints for kprobe use then the same rules seem to apply - jprobes
and the int3 optimisation mean you don't need to go shoving nops in code
paths that are used all the time.

Alan

