Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264726AbUGZAuT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264726AbUGZAuT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jul 2004 20:50:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264734AbUGZAuT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jul 2004 20:50:19 -0400
Received: from fw.osdl.org ([65.172.181.6]:42376 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264726AbUGZAuN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jul 2004 20:50:13 -0400
Date: Sun, 25 Jul 2004 17:48:49 -0700
From: Andrew Morton <akpm@osdl.org>
To: Con Kolivas <kernel@kolivas.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Autotune swappiness01
Message-Id: <20040725174849.75f2ecf6.akpm@osdl.org>
In-Reply-To: <cone.1090802581.972906.20693.502@pc.kolivas.org>
References: <cone.1090801520.852584.20693.502@pc.kolivas.org>
	<20040725173652.274dcac6.akpm@osdl.org>
	<cone.1090802581.972906.20693.502@pc.kolivas.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas <kernel@kolivas.org> wrote:
>
> >> It has the effect 
> >> of being fairly aggressive at avoiding loss of applications to swap under 
> >> conditions of heavy or sustained file stress while allowing applications to 
> >> swap out under what would be considered "application" memory stresses on a 
> >> desktop.
> > 
> > But decreasing /proc/sys/vm/swappiness does that too?
> 
> Low memory boxes and ones that are heavily laden with applications find that 
> ends up making things slow down trying to keep all applications in physical 
> ram.

Doesn't that mean that swappiness was decreased by too much?

> > 
> >> It has no measurable effect on any known benchmarks.
> > 
> > So how are we to evaluate the desirability of the patch???
> 
> Get desktop users to report back their experiences which is what I have 
> currently. Sorry we're in the realm of subjectivity again.

Seriously, we've seen placebo effects before...

> > Shouldn't mapped_bias be local to refill_inactive_zone()?
> 
> That is so a followup patch can use it elsewhere...

erk.  I guess it's OK because the thing is derived from global state which
changes slowly over time.

> > Why is `swappiness' getting squared?  AFAICT this will simply make the
> > swappiness control behave nonlinearly, which seems undesirable?
> 
> To parallel the nonlinear nature of the mapped bias effect. 

That doesn't really answer my question?  What goes wrong if swappiness is
not squared?
