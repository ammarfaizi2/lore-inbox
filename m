Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261722AbVFGEbq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261722AbVFGEbq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Jun 2005 00:31:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261725AbVFGEbo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Jun 2005 00:31:44 -0400
Received: from gate.crashing.org ([63.228.1.57]:26512 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261722AbVFGEbb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Jun 2005 00:31:31 -0400
Subject: Re: [PATCH] fix tulip suspend/resume
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Adam Belay <abelay@novell.com>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org, akpm@osdl.org,
       Karsten Keil <kkeil@suse.de>
In-Reply-To: <1118115751.3245.31.camel@localhost.localdomain>
References: <20050606224645.GA23989@pingi3.kke.suse.de>
	 <1118110545.6850.31.camel@gaston>  <20050607025710.GD3289@neo.rr.com>
	 <1118115123.6850.43.camel@gaston>
	 <1118115751.3245.31.camel@localhost.localdomain>
Content-Type: text/plain
Date: Tue, 07 Jun 2005 14:29:19 +1000
Message-Id: <1118118559.6850.61.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> What PM toplevel core changes are you referring to?  I've look over the
> changes to pm_ops and they seem to make sense.  Still I almost wonder if
> we should make the entire thing arch specific code, and then have this
> code call things like device_suspend().  If mac hardware required that
> many new hooks, then other platforms might require even more.

That is exactly the debate. Patrick thinks the whole thing should be
arch code and kernel/power/* just provices "library" routines to call
(like the freezer, swsusp stuff, etc...), Pavel wants to share as much
code as possible in a single place.

I have no real strong preference, I tend to be a bit more on Patrick's
side here. I can do either way, but we need to decide. On one case, I
would do a patch removing most of kernel/power/main.c and disk.c (they
are mostly redundant anyway) and replacing with a simple mecanism where
the arch provides a table of state names + function to call for sysfs.
On the other case, just merge my patch adding all the new hooks.

Ben.


