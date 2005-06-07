Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261715AbVFGFHf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261715AbVFGFHf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Jun 2005 01:07:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261712AbVFGFHf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Jun 2005 01:07:35 -0400
Received: from peabody.ximian.com ([130.57.169.10]:39597 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S261715AbVFGFHS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Jun 2005 01:07:18 -0400
Subject: Re: [PATCH] fix tulip suspend/resume
From: Adam Belay <abelay@novell.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org, akpm@osdl.org,
       Karsten Keil <kkeil@suse.de>
In-Reply-To: <1118118559.6850.61.camel@gaston>
References: <20050606224645.GA23989@pingi3.kke.suse.de>
	 <1118110545.6850.31.camel@gaston> <20050607025710.GD3289@neo.rr.com>
	 <1118115123.6850.43.camel@gaston>
	 <1118115751.3245.31.camel@localhost.localdomain>
	 <1118118559.6850.61.camel@gaston>
Content-Type: text/plain
Date: Tue, 07 Jun 2005 01:03:18 -0400
Message-Id: <1118120598.3245.56.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-06-07 at 14:29 +1000, Benjamin Herrenschmidt wrote:
> > What PM toplevel core changes are you referring to?  I've look over the
> > changes to pm_ops and they seem to make sense.  Still I almost wonder if
> > we should make the entire thing arch specific code, and then have this
> > code call things like device_suspend().  If mac hardware required that
> > many new hooks, then other platforms might require even more.
> 
> That is exactly the debate. Patrick thinks the whole thing should be
> arch code and kernel/power/* just provices "library" routines to call
> (like the freezer, swsusp stuff, etc...), Pavel wants to share as much
> code as possible in a single place.
> 
> I have no real strong preference, I tend to be a bit more on Patrick's
> side here. I can do either way, but we need to decide. On one case, I
> would do a patch removing most of kernel/power/main.c and disk.c (they
> are mostly redundant anyway) and replacing with a simple mecanism where
> the arch provides a table of state names + function to call for sysfs.
> On the other case, just merge my patch adding all the new hooks.
> 
> Ben.

I'd tend to agree with Pat then.  The original pm_ops seem to be
designed around ACPI and after looking at the spec I don't think they're
correct. (e.g. it looks like _PTS and _GTS should be run after
device_suspend() instead of before, so *prepare may not be needed).  In
short, this tends to be tricky.  It's probably best to have platforms
handle it on their own with kernel/power as a library.

Thanks,
Adam


