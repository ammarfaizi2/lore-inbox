Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272362AbTGaAQd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 20:16:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272368AbTGaAQd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 20:16:33 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:18635
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S272362AbTGaAQb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 20:16:31 -0400
Date: Thu, 31 Jul 2003 02:16:36 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linas@austin.ibm.com, mingo@elte.hu, linux-kernel@vger.kernel.org,
       olh@suse.de, olof@austin.bim.com
Subject: Re: PATCH: Race in 2.6.0-test2 timer code
Message-ID: <20030731001636.GE322@dualathlon.random>
References: <20030730082848.GC23835@dualathlon.random> <Pine.LNX.4.44.0307301223450.13299-100000@localhost.localdomain> <20030730184317.B23750@forte.austin.ibm.com> <20030730235607.GC322@dualathlon.random> <20030730165418.2f2db960.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030730165418.2f2db960.akpm@osdl.org>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 30, 2003 at 04:54:18PM -0700, Andrew Morton wrote:
> Andrea Arcangeli <andrea@suse.de> wrote:
> >
> > 2.6 will kernel crash like we did in 2.4 only if it calls
> > add_timer_on from timer context (of course with a cpuid != than the
> > smp_processor_id()), that would be fixed by the timer->lock everywhere
> > that we've in 2.4 right now.  (but there's no add_timer_on in 2.4
> > anyways)
> 
> add_timer_on() was added specifically for slab bringup.  If we need extra
> locking to cope with it then the best solution would probably be to rename
> it to add_timer_on_dont_use_this_for_anything_else().

yes. I wasn't actually suggesting to add locking everywhere just for
this. It sounds reasonable to leave it unsafe from timer context.

> But if we are going to rely on timer handlers only ever running on the
> adding CPU for locking purposes then can we please have a big comment
> somewhere describing what's going on?  It's very subtle...

agreed, it definitely deserves the big fat comment somewhere ;)

thanks,

Andrea
