Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261561AbVFBBol@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261561AbVFBBol (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 21:44:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261560AbVFBBol
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 21:44:41 -0400
Received: from b3162.static.pacific.net.au ([203.143.238.98]:44205 "EHLO
	cunningham.myip.net.au") by vger.kernel.org with ESMTP
	id S261561AbVFBBof (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 21:44:35 -0400
Subject: Re: Freezer Patches.
From: Nigel Cunningham <ncunningham@cyclades.com>
Reply-To: ncunningham@cyclades.com
To: Pavel Machek <pavel@ucw.cz>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050601230235.GF11163@elf.ucw.cz>
References: <1117629212.10328.26.camel@localhost>
	 <20050601130205.GA1940@openzaurus.ucw.cz>
	 <1117663709.13830.34.camel@localhost> <20050601223101.GD11163@elf.ucw.cz>
	 <1117665934.19020.94.camel@gaston>  <20050601230235.GF11163@elf.ucw.cz>
Content-Type: text/plain; charset=iso-8859-2
Organization: Cycades
Message-Id: <1117676753.10888.105.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Thu, 02 Jun 2005 11:45:54 +1000
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Thu, 2005-06-02 at 09:02, Pavel Machek wrote:
> On Èt 02-06-05 08:45:33, Benjamin Herrenschmidt wrote:
> > On Thu, 2005-06-02 at 00:31 +0200, Pavel Machek wrote:
> > > Hi!
> > > 
> > > (Well, it is just after midnight here :-).
> > > 
> > > > > > Here are the freezer patches. They were prepared against rc3, but I
> > > > > > think they still apply fine against rc5. (Ben, these are the same ones I
> > > > > > sent you the other day).
> > > > > 
> > > > > 304 seems ugly and completely useless for mainline
> > > > 
> > > > That's because you don't understand what it's doing.
> > > > 
> > > > The new refrigerator implementation works like this:
> > > > 
> > > > Userspace processes that begin a sys_*sync gain the process flag
> > > > PF_SYNCTHREAD for the duration of their syscall.
> > > 
> > > swsusp1 should not need any special casing of sync, right? We can
> > > simply do sys_sync(), then freeze, or something like that. We could
> > > even remove sys_sync() completely; it is not needed for correctness.

Wrong. I guess you're only trying it on a machine that isn't actually
doing anything :). I've forgotten whether it was this freezer
implementation or the last, but we've been testing freezing processes
when the load average exceeds 100. If you have a thread that is syncing
and another that's submitting I/O continually (think dd, for example),
you want this.

> > It's still quite nice to have ... I put it in my pre-freeze callback in
> > fact for both STR and STD :) We really want it for STD but I think it
> > doesn't work properly after freeze.
> 
> I agree that sync() is nice to have, but I'm not going to slow down
> fork/exit for it. And besides, sys_sync() just before suspend works
> just fine.

Again, try it under load... and stop talking about fork and exit like
they're real hot paths. (Unless you regularly submit your machines to
fork bombs :)).

Regards,

Nigel

