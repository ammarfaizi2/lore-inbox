Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266271AbUJIAX3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266271AbUJIAX3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Oct 2004 20:23:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266333AbUJIAX3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Oct 2004 20:23:29 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.103]:44470 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S266271AbUJIAX1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Oct 2004 20:23:27 -0400
Subject: Re: [PATCH] cpusets - big numa cpu and memory placement
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
To: Hubertus Franke <frankeh@watson.ibm.com>
Cc: Paul Jackson <pj@sgi.com>, Rick Lindsley <ricklind@us.ibm.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>, Simon.Derr@bull.net,
       pwil3058@bigpond.net.au, dipankar@in.ibm.com,
       Andrew Morton <akpm@osdl.org>, ckrm-tech@lists.sourceforge.net,
       efocht@hpce.nec.com, LSE Tech <lse-tech@lists.sourceforge.net>,
       hch@infradead.org, steiner@sgi.com, Jesse Barnes <jbarnes@sgi.com>,
       sylvain.jeaugey@bull.net, djh@sgi.com,
       LKML <linux-kernel@vger.kernel.org>, Andi Kleen <ak@suse.de>,
       sivanich@sgi.com
In-Reply-To: <4165A31E.4070905@watson.ibm.com>
References: <20041007015107.53d191d4.pj@sgi.com>
	 <200410071053.i97ArLnQ011548@owlet.beaverton.ibm.com>
	 <20041007072842.2bafc320.pj@sgi.com>  <4165A31E.4070905@watson.ibm.com>
Content-Type: text/plain
Organization: IBM LTC
Message-Id: <1097281329.6470.123.camel@arrakis>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Fri, 08 Oct 2004 17:22:10 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-10-07 at 13:12, Hubertus Franke wrote:
> The way this is heading is quite promising.
> - sched_domains seems the right answer wrt to partitioning the machine.
>    Given some boot option or dynamic means one can shift cpus from
>    on domain to the next domain.
> - If I understood correctly, there would be only one level of such
>    hard partitioning, speak exclusive cpu-set or sched_domain.
> - In each such domain/set we allow shared *use*.

I don't think that there needs to be a requirement that we have only one
level of hard partitioning.  The rest of your points are valid though,
Hubertus.

It'd be really nice if we could all get together with a wall of
whiteboards, some markers, and a few pots of coffee.  I think we'd all
get this pretty much hashed out in an hour or two.  This isn't directed
at you, Hubertus, but at the many communication breakdowns in this
thread.


> First, one needs to understand that sched_domains are nothing else
> but a set of cpus that are considered during load balancing times.
> By constricting the top_domain to the respective exclusive set one
> essentially has accomplished the desired feature of partitioning
> the machines into "isolated" sections (here from cpu perspective).
> So it is quite possible that an entire domain is empty based, while
> another exclusive domain would be totally overloaded.

I think that is very well stated, Hubertus.  By having a more or less
passive data structure that is only checked at load balance time, we can
ensure (in a very light-weight way) that no task ever moves *out* of
it's area nor moves *into* someone else's area.

-Matt

