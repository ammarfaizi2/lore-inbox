Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269152AbUIHPBd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269152AbUIHPBd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 11:01:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267683AbUIHOzR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 10:55:17 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:59318 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S267764AbUIHOye (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 10:54:34 -0400
Date: Wed, 8 Sep 2004 16:54:33 +0200
From: Pavel Machek <pavel@suse.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: Fw: 2.6.9-rc1-mm4: swsusp + AMD64 = LOCKUP on CPU0
Message-ID: <20040908145433.GC11663@atrey.karlin.mff.cuni.cz>
References: <20040908021637.57525d43.akpm@osdl.org.suse.lists.linux.kernel> <200409081451.55531.rjw@sisk.pl> <20040908130049.GA15444@wotan.suse.de> <200409081652.43463.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200409081652.43463.rjw@sisk.pl>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > > > > One for you guys on lkml ;)
> > > > > 
> > > > > It simply takes long to count pages (O(n^2) algorithm), so watchdog
> > > > > triggers. I have better algorithm locally, but would like merge to
> > > > > linus first. (I posted it to lkml some days ago, I can attach the
> > > > > bigdiff).
> > > > > 
> > > > > Just disable the watchdog. Suspend *is* going to take time with
> > > > > disabled interrupts.
> > > > 
> > > > 
> > > > As a short term workaround you could also add touch_nmi_watchdog()s
> > > > in that loop.
> > > 
> > > You mean like that:
> > 
> > I doubt this will help, because the number of zones is quite small.
> > 
> > Better check every N pages, e.g. N=100
> 
> I've done something like that:

...
> +					nmi_cnt = 0;
...

> and it works, but it seems to me that something similar is necessary for 
> resuming (I get an NMI watchdog report if it's not disabled).

Actually, it can not be solved like that. If some memory is actually
modified by nmi watchdog, you might get inconsistent snapshot; bad.

									Pavel
