Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932386AbVLVMbV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932386AbVLVMbV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 07:31:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932367AbVLVMbV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 07:31:21 -0500
Received: from adsl-69-232-92-238.dsl.sndg02.pacbell.net ([69.232.92.238]:15269
	"EHLO gnuppy.monkey.org") by vger.kernel.org with ESMTP
	id S932305AbVLVMbU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 07:31:20 -0500
Date: Thu, 22 Dec 2005 04:27:43 -0800
To: Matthew Wilcox <matthew@wil.cx>
Cc: Linus Torvalds <torvalds@osdl.org>, Steven Rostedt <rostedt@goodmis.org>,
       Joe Korty <joe.korty@ccur.com>, Thomas Gleixner <tglx@linutronix.de>,
       Geert Uytterhoeven <geert@linux-m68k.org>,
       Andrew Morton <akpm@osdl.org>, linux-arch@vger.kernel.org,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       arjan@infradead.org, Christoph Hellwig <hch@infradead.org>,
       mingo@elte.hu, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       nikita@clusterfs.com, pj@sgi.com, dhowells@redhat.com
Subject: Re: [PATCH 1/19] MUTEX: Introduce simple mutex implementation
Message-ID: <20051222122743.GA14633@gnuppy.monkey.org>
References: <Pine.LNX.4.64.0512161339140.3698@g5.osdl.org> <1134770778.2806.31.camel@tglx.tec.linutronix.de> <Pine.LNX.4.64.0512161414370.3698@g5.osdl.org> <1134772964.2806.50.camel@tglx.tec.linutronix.de> <Pine.LNX.4.64.0512161439330.3698@g5.osdl.org> <20051217002929.GA7151@tsunami.ccur.com> <Pine.LNX.4.64.0512161647570.3698@g5.osdl.org> <Pine.LNX.4.58.0512162211320.6498@gandalf.stny.rr.com> <Pine.LNX.4.64.0512162323140.3698@g5.osdl.org> <20051217234305.GH2361@parisc-linux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051217234305.GH2361@parisc-linux.org>
User-Agent: Mutt/1.5.11
From: Bill Huey (hui) <billh@gnuppy.monkey.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 17, 2005 at 04:43:05PM -0700, Matthew Wilcox wrote:
> I have a better example of something we currently get wrong that I
> haven't heard any RT person worry about yet.  If two tasks are sleeping
> on the same semaphore, the one to be woken up will be the first one to
> wait for it, not the highest-priority task.
> 
> Obviously, this was introduced by the wake-one semantics.  But how to
> fix it?  Should we scan the entire queue looking for the best task to
> wake?  Should we try to maintain the wait list in priority order?  Or
> should we just not care?  Should we document that we don't care?  ;-)

-rt deals with this using priority sorted wait queue and direct ownership
hand off to the woken thread. It's working fine for now, but things like
wake-all and company should probably be explored for various uses. A
strict general purpose and RT usage of the Linux kernel have different
performance characteristic and mutex selection at compile time should
address things precisely.

bill

