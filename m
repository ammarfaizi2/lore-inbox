Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266571AbUAWQqA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jan 2004 11:46:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266580AbUAWQqA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jan 2004 11:46:00 -0500
Received: from monsoon.he.net ([64.62.221.2]:56221 "HELO monsoon.he.net")
	by vger.kernel.org with SMTP id S266571AbUAWQp7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jan 2004 11:45:59 -0500
Date: Fri, 23 Jan 2004 08:45:50 -0800 (PST)
From: Patrick Mochel <mochel@digitalimplant.org>
X-X-Sender: mochel@monsoon.he.net
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
cc: Pavel Machek <pavel@ucw.cz>,
       Nigel Cunningham <ncunningham@users.sourceforge.net>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: swsusp vs  pgdir
In-Reply-To: <1074874219.835.32.camel@gaston>
Message-ID: <Pine.LNX.4.50.0401230839420.11276-100000@monsoon.he.net>
References: <1074833921.975.197.camel@gaston>  <20040123073426.GA211@elf.ucw.cz>
 <1074843781.878.1.camel@gaston>  <20040123075451.GB211@elf.ucw.cz> 
 <Pine.LNX.4.50.0401230759180.11276-100000@monsoon.he.net> <1074874219.835.32.camel@gaston>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Wait... wait... If the whole linear mapping isn't mapped by this flat
> pgdir, then we have a problem, since the MMU will have to go down the
> kernel pagetables to actually access the pages data when copying them
> around... but at this point, we are overriding the boot kernel page
> tables with the loader ones, so ...

A new pgdir is allocated on resume that does not overlap with any pages
being restored. See relocate_pagedir() in the code..

We assume that the kernel version is the same, and therefore that the code
and static data are in same locations in memory. So, even if the kernel
page tables get overwritten, we can still access the pointer to the pgdir.


	Pat
