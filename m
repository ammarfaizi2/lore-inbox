Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264446AbTICUPV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 16:15:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264449AbTICUNj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 16:13:39 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:14863 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S264446AbTICUNS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 16:13:18 -0400
Date: Wed, 3 Sep 2003 16:03:15 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Patrick Mochel <mochel@osdl.org>
cc: Pavel Machek <pavel@suse.cz>, Linus Torvalds <torvalds@osdl.org>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Fix up power managment in 2.6
In-Reply-To: <Pine.LNX.4.44.0309020825280.5614-100000@cherise>
Message-ID: <Pine.LNX.3.96.1030903155520.9300B-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 Sep 2003, Patrick Mochel wrote:

> 
> > @@ -65,9 +65,7 @@
> > 
> >  #include "power.h"
> > 
> > -extern long sys_sync(void);
> > -
> > -unsigned char software_suspend_enabled = 0;
> > +unsigned char software_suspend_enabled = 1;
> > 
> >  #define __ADDRESS(x)  ((unsigned long) phys_to_virt(x))
> > 
> > ...by this you enable suspend even before system is booted. That's bad
> > idea. It could hurt in the past (when we had sysrq-D so swsusp), and
> > it may hurt again in future when battery goes low during boot.
> 
> Does it or does it not cause a problem? Look at the old software_suspend() 
> function - The handling of this flag was weird and non-standard. This is 
> cleaner. 

I don't want to get in the middle of this, but having a laptop decide
that it doesn't have enough battery to finish a boot is something which
happens now and again. If this change could cause data corruption where
the old code didn't, perhaps we could stand the overhead of moving the
enable to the end of the boot, or wherever would be safe.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

