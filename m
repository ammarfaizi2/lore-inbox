Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261223AbVAGB6w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261223AbVAGB6w (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 20:58:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261158AbVAGB4n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 20:56:43 -0500
Received: from fw.osdl.org ([65.172.181.6]:26290 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261182AbVAGB4U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 20:56:20 -0500
Date: Thu, 6 Jan 2005 17:56:07 -0800
From: Andrew Morton <akpm@osdl.org>
To: Jesper Juhl <juhl-lkml@dif.dk>
Cc: juhl-lkml@dif.dk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][0/4] let's kill verify_area
Message-Id: <20050106175607.6b15b8e3.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.61.0501070246160.3430@dragon.hygekrogen.localhost>
References: <Pine.LNX.4.61.0501070212560.3430@dragon.hygekrogen.localhost>
	<20050106172624.7cc2a142.akpm@osdl.org>
	<Pine.LNX.4.61.0501070246160.3430@dragon.hygekrogen.localhost>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesper Juhl <juhl-lkml@dif.dk> wrote:
>
> On Thu, 6 Jan 2005, Andrew Morton wrote:
> 
> > Jesper Juhl <juhl-lkml@dif.dk> wrote:
> > >
> > > verify_area() if just a wrapper for access_ok() (or similar function or 
> > > dummy function) for all arch's.
> > 
> > This sounds more like "let's kill Andrew".  I count 489 instances in the
> > tree.  Please don't expect this activity to take top priority ;)
> > 
> Heh, right, there's an aspect I hadn't really considered.
> I'm not expecting top priority, not at all. This is nowhere near being 
> anything important, just something that should happen eventually - so I 
> thought, why not just deprecate it now and let it be cleaned up over time 
> (and I'll do my share, don't worry :)
> 
> Accept the patch if you think it makes sense, drop it if you think it does 
> not (or should wait). 

The way to do this is to fix up the callers first, in just ten or so
patches.  Then mark the function deprecated when most of the conversion is
done.

If we deprecate the functions first then 10000 people send small fixes via
various snaky routes and it's really hard to coordinate the overlapping
fixes.  The s/MODULE_PARM/module_param/ stuff did that, because we made it
warn first, then I held the big sweep patch off for 2.6.11.
