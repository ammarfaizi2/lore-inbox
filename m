Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262795AbUAWQxQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jan 2004 11:53:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262960AbUAWQxQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jan 2004 11:53:16 -0500
Received: from gprs154-79.eurotel.cz ([160.218.154.79]:896 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262795AbUAWQxP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jan 2004 11:53:15 -0500
Date: Fri, 23 Jan 2004 17:53:04 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Patrick Mochel <mochel@digitalimplant.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Nigel Cunningham <ncunningham@users.sourceforge.net>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: swsusp vs  pgdir
Message-ID: <20040123165304.GA257@elf.ucw.cz>
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

Look again. relocate_pagedir() does not work with hardware page
directories. Instead, it deals with swsusp data structure telling it
what to copy where.

Okay, it could use some better name...
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
