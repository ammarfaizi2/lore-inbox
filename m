Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261718AbUCaEJG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 23:09:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261724AbUCaEJG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 23:09:06 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:8332
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S261718AbUCaEJA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 23:09:00 -0500
Date: Wed, 31 Mar 2004 06:08:59 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.5-rc3-aa1
Message-ID: <20040331040859.GB2143@dualathlon.random>
References: <20040331030921.GA2143@dualathlon.random> <20040330194149.4f1451bc.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040330194149.4f1451bc.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 30, 2004 at 07:41:49PM -0800, Andrew Morton wrote:
> Andrea Arcangeli <andrea@suse.de> wrote:
> >
> > In the meantime this is already mergeable in -mm if Andrew is
> >  interested.
> 
> It's a bit early for that, I feel.  I'd like to see thing settle down a
> little more at your end first, then see that Rajesh, Hugh and if possible

no problem in settling it down more on my end.

> Ingo have had a good go through everything.

the thing isn't changing much anymore, there are only a few lines
fixes across the last updates.

the mprotect merging won't be as small, but it should not be more than
an hundred lines rewrite and it's orthogonal with the rest of the
changes. I plan to complete it before the end of the week.

Keep in mind this whole thing is going in production in a matter of a
week, so please test and review now. I'm uncertain if to add the
mprotect merging to the production tree after I completed it, I don't
see it as a requirement, infact I believe mprotect has always been more
important for file mappings than anonymous memory (I know this is
certainly the case for some big app where merging file mappings in
mprotect actually would help a bit too). At this point in time unless I
get a complaint for a real app I'll probably avoid any further change to
avoid invalidating the current testing. So I may keep the mprotect
merging in a separate patch.

I'm _very_ confortable that whatever might go wrong with this new code
that I cannot imagine right now, it'll always be a lot better than the
stuff that we know goes wrong with rmap or/and 4:4.

> We have a way to go yet.  Once I've dumped a lot of the current pending
> stuff into 2.6.6-early we'll be in better shape.

I'd like to see the -mm writeback changes merged ASAP since they're the
most invasive from my point of view ;)

thanks.
