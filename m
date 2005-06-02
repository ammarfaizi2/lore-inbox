Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261570AbVFBBwF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261570AbVFBBwF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 21:52:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261566AbVFBBwF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 21:52:05 -0400
Received: from gate.crashing.org ([63.228.1.57]:43463 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261564AbVFBBts (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 21:49:48 -0400
Subject: Re: Freezer Patches.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: ncunningham@cyclades.com
Cc: Pavel Machek <pavel@ucw.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1117676819.10888.109.camel@localhost>
References: <1117629212.10328.26.camel@localhost>
	 <20050601130205.GA1940@openzaurus.ucw.cz>
	 <1117663709.13830.34.camel@localhost> <20050601223101.GD11163@elf.ucw.cz>
	 <1117665934.19020.94.camel@gaston>  <20050601230235.GF11163@elf.ucw.cz>
	 <1117672513.19020.103.camel@gaston>  <1117676819.10888.109.camel@localhost>
Content-Type: text/plain
Date: Thu, 02 Jun 2005 11:49:20 +1000
Message-Id: <1117676961.31082.4.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-06-02 at 11:46 +1000, Nigel Cunningham wrote:
> Hi.
> 
> On Thu, 2005-06-02 at 10:35, Benjamin Herrenschmidt wrote:
> > > I agree that sync() is nice to have, but I'm not going to slow down
> > > fork/exit for it. And besides, sys_sync() just before suspend works
> > > just fine.
> > 
> > Yes, that's why I put it in my pre-freeze :)
> > 
> > I'll see about making my pre/post freeze stuff (APM emu + sync basically
> > now) generic to avoid the callbacks.
> 
> Ummm. Don't do it if kthreads are already frozen. You'll deadlock against kjournald.

Which is why I do it pre-freeze.

With a 2 stage freezing though, it would make sense to first freeze
userland, then sync, then freeze kthreads. That would make the sync
faster (as it won't be "blocked" by pending userland IOs as I experience
regulary here) and more reliable.

Ben.


