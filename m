Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265182AbTFFIuw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jun 2003 04:50:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265204AbTFFIuw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jun 2003 04:50:52 -0400
Received: from mail.ithnet.com ([217.64.64.8]:20999 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id S265182AbTFFIuv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jun 2003 04:50:51 -0400
Date: Fri, 6 Jun 2003 11:04:08 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Oleg Drokin <green@namesys.com>
Cc: willy@w.ods.org, gibbs@scsiguy.com, marcelo@conectiva.com.br,
       linux-kernel@vger.kernel.org
Subject: Re: Undo aic7xxx changes (now rc7+aic20030603)
Message-Id: <20030606110408.1c8ef962.skraw@ithnet.com>
In-Reply-To: <20030606081712.GA27663@namesys.com>
References: <Pine.LNX.4.55L.0305071716050.17793@freak.distro.conectiva>
	<2804790000.1052441142@aslan.scsiguy.com>
	<20030509120648.1e0af0c8.skraw@ithnet.com>
	<20030509120659.GA15754@alpha.home.local>
	<20030509150207.3ff9cd64.skraw@ithnet.com>
	<20030606081712.GA27663@namesys.com>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.9.1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 Jun 2003 12:17:12 +0400
Oleg Drokin <green@namesys.com> wrote:

> Hello!
> 
> On Thu, Jun 05, 2003 at 08:14:23PM +0200, Willy Tarreau wrote:
> > > It took some days to produce output for my freezing problem. This one is
> > > rc7+aic20030603:
> > Good !
> > It seems that it crashed in the reiserfs code rather than in aic7xxx !
> > perhaps you hit 2 different bugs, or perhaps there's a race that only newer
> > code can trigger, or there's a leak somewhere. You may want to forward the
> > oops to the reiserfs team too.
> 
> No, it did crashed in allocation code (you skipped one trace line):
> Jun  5 16:53:55 admin kernel: Call Trace:    [__kmem_cache_alloc+107/304]
> [kmem_cache_grow+508/624]
> [__kmem_cache_alloc+125/304]+[get_mem_for_virtual_node+87/224]
> [fix_nodes+198/1008]
> 
> And the EIP is in kmem_cache_alloc_batch, sounds like it tripped on bad
> pointer or something like this. So something is corrupting slab lists it
> seems.
> 
> Bye,
>     Oleg

I agree with you. Only problem is: how can I find out what caused the problem.
The only thing I can tell is that the box never hangs when using only HDs on
the aic & 3ware controllers. As soon as I begin to use a SDLT drive on aic
things get fishy.

Regards,
Stephan
