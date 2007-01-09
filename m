Return-Path: <linux-kernel-owner+w=401wt.eu-S932463AbXAIWik@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932463AbXAIWik (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 17:38:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932472AbXAIWik
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 17:38:40 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:34930 "EHLO amd.ucw.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932463AbXAIWij (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 17:38:39 -0500
Date: Tue, 9 Jan 2007 23:38:26 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@osdl.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Christoph Hellwig <hch@infradead.org>, ltt-dev@shafik.org,
       systemtap@sources.redhat.com, Douglas Niehaus <niehaus@eecs.ku.edu>,
       "Martin J. Bligh" <mbligh@mbligh.org>,
       Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] local_t : Documentation
Message-ID: <20070109223826.GA6555@elf.ucw.cz>
References: <20061221001545.GP28643@Krystal> <20061223093358.GF3960@ucw.cz> <20070109031446.GA29426@Krystal> <20070109130110.8934c29f.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070109130110.8934c29f.akpm@osdl.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2007-01-09 13:01:10, Andrew Morton wrote:
> On Mon, 8 Jan 2007 22:14:46 -0500
> Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca> wrote:
> 
> > +* How to use local atomic operations
> > +
> > +#include <linux/percpu.h>
> > +#include <asm/local.h>
> > +
> > +static DEFINE_PER_CPU(local_t, counters) = LOCAL_INIT(0);
> > +
> > +
> > +* Counting
> > +
> > +In preemptible context, use get_cpu_var() and put_cpu_var() around local atomic
> > +operations : it makes sure that preemption is disabled around write access to
> > +the per cpu variable. For instance :
> > +
> > +	local_inc(&get_cpu_var(counters));
> > +	put_cpu_var(counters);
> 
> Confused.  The whole point behind local_t is that we can do
> atomic-wrt-interrupts inc and dec on them.

Could we get this short of two line description into the Doc/ file? It
talks about how to implement them, mentions LOCK prefixes unlikely to
be present on non-i386, but does not tell me what they guarantee...
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
