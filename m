Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750870AbVI1Kcn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750870AbVI1Kcn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 06:32:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750874AbVI1Kcn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 06:32:43 -0400
Received: from sv1.valinux.co.jp ([210.128.90.2]:43704 "EHLO sv1.valinux.co.jp")
	by vger.kernel.org with ESMTP id S1750869AbVI1Kcn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 06:32:43 -0400
Date: Wed, 28 Sep 2005 19:32:40 +0900
From: KUROSAWA Takahiro <kurosawa@valinux.co.jp>
To: Hirokazu Takahashi <taka@valinux.co.jp>
Cc: nickpiggin@yahoo.com.au, pj@sgi.com, magnus.damm@gmail.com,
       dino@in.ibm.com, linux-kernel@vger.kernel.org,
       ckrm-tech@lists.sourceforge.net
Subject: Re: [PATCH 1/3] CPUMETER: add cpumeter framework to the CPUSETS
In-Reply-To: <20050928.190822.105167368.taka@valinux.co.jp>
References: <20050927013751.47cbac8b.pj@sgi.com>
	<1127812937.5174.6.camel@npiggin-nld.site>
	<20050928063501.89B5A70041@sv1.valinux.co.jp>
	<20050928.190822.105167368.taka@valinux.co.jp>
X-Mailer: Sylpheed version 2.1.2+svn (GTK+ 2.6.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20050928103240.A579770043@sv1.valinux.co.jp>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Sep 2005 19:08:22 +0900 (JST)
Hirokazu Takahashi <taka@valinux.co.jp> wrote:

> > - The controller only controls the time_slice value and doesn't
> >   care the balance of cpus (the controller leaves balancing to 
> >   the existing balancing code in the scheduler).  So far I don't
> >   have any good idea to solve this.
> Is there any problem to enhance load_balance()? Applying some weight
> to each process, it would be used for calculating load of each runqueue.

Probably we can solve this issue by applying some weight to each tasks
and calculating the load of runqueues based on that weight.
But I can not get to the implementation out of your idea so far.

> > - The controller holds a spinlock once per 1 second.  I don't
> >   know this is permissive or not, but the current scheduler
> >   doesn't hold any spinlocks normally, so...
> I think each runqueue has its own spinlock, which is held quite often.

Ah, thanks for pointing out my mistake.  Maybe I confused that with
something else.
Then it should be more permissive than I had thought, at least :)

-- 
KUROSAWA, Takahiro
