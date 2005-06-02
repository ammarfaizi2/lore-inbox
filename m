Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261593AbVFBHZR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261593AbVFBHZR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Jun 2005 03:25:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261595AbVFBHZR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Jun 2005 03:25:17 -0400
Received: from b3162.static.pacific.net.au ([203.143.238.98]:50346 "EHLO
	cunningham.myip.net.au") by vger.kernel.org with ESMTP
	id S261593AbVFBHZK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Jun 2005 03:25:10 -0400
Subject: Re: Freezer Patches.
From: Nigel Cunningham <ncunningham@cyclades.com>
Reply-To: ncunningham@cyclades.com
To: Pavel Machek <pavel@ucw.cz>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050602071431.GA1841@elf.ucw.cz>
References: <1117629212.10328.26.camel@localhost>
	 <20050601130205.GA1940@openzaurus.ucw.cz>
	 <1117663709.13830.34.camel@localhost> <20050601223101.GD11163@elf.ucw.cz>
	 <1117665934.19020.94.camel@gaston> <20050601230235.GF11163@elf.ucw.cz>
	 <1117676753.10888.105.camel@localhost>  <20050602071431.GA1841@elf.ucw.cz>
Content-Type: text/plain
Organization: Cycades
Message-Id: <1117697187.10888.138.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Thu, 02 Jun 2005 17:26:28 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Thu, 2005-06-02 at 17:14, Pavel Machek wrote:
> Hi!
> 
> > > > > swsusp1 should not need any special casing of sync, right? We can
> > > > > simply do sys_sync(), then freeze, or something like that. We could
> > > > > even remove sys_sync() completely; it is not needed for correctness.
> > 
> > Wrong. I guess you're only trying it on a machine that isn't actually
> > doing anything :). I've forgotten whether it was this freezer
> > implementation or the last, but we've been testing freezing processes
> > when the load average exceeds 100. If you have a thread that is syncing
> > and another that's submitting I/O continually (think dd, for example),
> > you want this.
> 
> If sys_sync() is not working, *fix sys_sync()*. [BTW I see that
> problem before and I think it is being worked on.] I'm *not* going to
> work around it in refrigerator.

I'm not saying sys_sync is broken. I _am_ saying that if you have
processes submitting I/O while you're trying to sync, syncing will take
longer and you may well still end up with dirty buffers at the end. On
top of this, you may think freezing has failed because processes don't
enter the refrigerator within your timelimit (assuming you have one).

The simple, logic solution is to stop threads that are submitting I/O
before you stop threads that are syncing I/O.

Regards,

Nigel

