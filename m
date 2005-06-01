Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261351AbVFAXC5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261351AbVFAXC5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 19:02:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261355AbVFAXC5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 19:02:57 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:59357 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261351AbVFAXCz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 19:02:55 -0400
Date: Thu, 2 Jun 2005 01:02:35 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Nigel Cunningham <ncunningham@cyclades.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Freezer Patches.
Message-ID: <20050601230235.GF11163@elf.ucw.cz>
References: <1117629212.10328.26.camel@localhost> <20050601130205.GA1940@openzaurus.ucw.cz> <1117663709.13830.34.camel@localhost> <20050601223101.GD11163@elf.ucw.cz> <1117665934.19020.94.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1117665934.19020.94.camel@gaston>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Čt 02-06-05 08:45:33, Benjamin Herrenschmidt wrote:
> On Thu, 2005-06-02 at 00:31 +0200, Pavel Machek wrote:
> > Hi!
> > 
> > (Well, it is just after midnight here :-).
> > 
> > > > > Here are the freezer patches. They were prepared against rc3, but I
> > > > > think they still apply fine against rc5. (Ben, these are the same ones I
> > > > > sent you the other day).
> > > > 
> > > > 304 seems ugly and completely useless for mainline
> > > 
> > > That's because you don't understand what it's doing.
> > > 
> > > The new refrigerator implementation works like this:
> > > 
> > > Userspace processes that begin a sys_*sync gain the process flag
> > > PF_SYNCTHREAD for the duration of their syscall.
> > 
> > swsusp1 should not need any special casing of sync, right? We can
> > simply do sys_sync(), then freeze, or something like that. We could
> > even remove sys_sync() completely; it is not needed for correctness.
> 
> It's still quite nice to have ... I put it in my pre-freeze callback in
> fact for both STR and STD :) We really want it for STD but I think it
> doesn't work properly after freeze.

I agree that sync() is nice to have, but I'm not going to slow down
fork/exit for it. And besides, sys_sync() just before suspend works
just fine.

								Pavel
