Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262569AbUAWRFH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jan 2004 12:05:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266601AbUAWRFH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jan 2004 12:05:07 -0500
Received: from gprs154-79.eurotel.cz ([160.218.154.79]:2432 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262569AbUAWRFB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jan 2004 12:05:01 -0500
Date: Fri, 23 Jan 2004 18:04:46 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Patrick Mochel <mochel@digitalimplant.org>,
       Rusty trivial patch monkey Russell 
	<trivial@rustcorp.com.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Nigel Cunningham <ncunningham@users.sourceforge.net>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: swsusp vs  pgdir
Message-ID: <20040123170446.GA726@elf.ucw.cz>
References: <1074833921.975.197.camel@gaston> <20040123073426.GA211@elf.ucw.cz> <1074843781.878.1.camel@gaston> <20040123075451.GB211@elf.ucw.cz> <Pine.LNX.4.50.0401230759180.11276-100000@monsoon.he.net> <1074874219.835.32.camel@gaston> <Pine.LNX.4.50.0401230839420.11276-100000@monsoon.he.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.50.0401230839420.11276-100000@monsoon.he.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Wait... wait... If the whole linear mapping isn't mapped by this flat
> > pgdir, then we have a problem, since the MMU will have to go down the
> > kernel pagetables to actually access the pages data when copying them
> > around... but at this point, we are overriding the boot kernel page
> > tables with the loader ones, so ...
> 
> A new pgdir is allocated on resume that does not overlap with any pages
> being restored. See relocate_pagedir() in the code..

Perhaps this should serve as a warning to people trying to understand
swsusp.c?

								Pavel

--- tmp/linux/kernel/power/swsusp.c	2004-01-23 17:59:36.000000000 +0100
+++ linux/kernel/power/swsusp.c	2004-01-23 17:58:58.000000000 +0100
@@ -107,6 +107,10 @@
    time of suspend, that must be freed. Second is "pagedir_nosave", 
    allocated at time of resume, that travels through memory not to
    collide with anything.
+
+   Warning: this is even more evil than it seems. Pagedirs this files
+   talks about are completely different from page directories used by
+   MMU hardware.
  */
 suspend_pagedir_t *pagedir_nosave __nosavedata = NULL;
 static suspend_pagedir_t *pagedir_save;

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
