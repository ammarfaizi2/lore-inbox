Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263547AbTFGUUT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jun 2003 16:20:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263624AbTFGUUT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jun 2003 16:20:19 -0400
Received: from smtp-out1.iol.cz ([194.228.2.86]:38539 "EHLO smtp-out1.iol.cz")
	by vger.kernel.org with ESMTP id S263547AbTFGUUQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jun 2003 16:20:16 -0400
Date: Sat, 7 Jun 2003 22:33:11 +0200
From: Pavel Machek <pavel@suse.cz>
To: Patrick Mochel <mochel@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] New system device API
Message-ID: <20030607203304.GB667@elf.ucw.cz>
References: <Pine.LNX.4.44.0306061749200.11379-100000@cherise>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0306061749200.11379-100000@cherise>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> For things like CPUs, generic code will register the class, but other 
> architecture-specific or otherwise configurable drivers may register 
> auxillary drivers, that look like: 
> 
> struct sysdev_driver {
>         struct list_head        entry;
>         int     (*add)(struct sys_device *);
>         int     (*remove)(struct sys_device *);
>         int     (*shutdown)(struct sys_device *);
>         int     (*suspend)(struct sys_device *, u32 state);
>         int     (*resume)(struct sys_device *);
> };

System devices may be special, but they should not be so special not
to require u32 level.  All current system devices need to be
suspended last, but that's pure coincidence, I believe.

As mikpe noted, hierarchy is still needed between "system" devices:
nmi watchdog depends on lapic...
							Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
