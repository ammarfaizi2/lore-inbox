Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266598AbUAWQK6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jan 2004 11:10:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266599AbUAWQK6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jan 2004 11:10:58 -0500
Received: from gate.crashing.org ([63.228.1.57]:31963 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S266598AbUAWQK4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jan 2004 11:10:56 -0500
Subject: Re: swsusp vs  pgdir
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Patrick Mochel <mochel@digitalimplant.org>
Cc: Pavel Machek <pavel@ucw.cz>,
       Nigel Cunningham <ncunningham@users.sourceforge.net>,
       Patrick Mochel <mochel@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.50.0401230759180.11276-100000@monsoon.he.net>
References: <1074833921.975.197.camel@gaston>
	 <20040123073426.GA211@elf.ucw.cz> <1074843781.878.1.camel@gaston>
	 <20040123075451.GB211@elf.ucw.cz>
	 <Pine.LNX.4.50.0401230759180.11276-100000@monsoon.he.net>
Content-Type: text/plain
Message-Id: <1074874219.835.32.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sat, 24 Jan 2004 03:10:20 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-01-24 at 03:03, Patrick Mochel wrote:
> > > swapper_pgdir is left intact. This is the case ? (I also suppose you
> > > mean the entire linear mapping, not just the kernel, is mapped with
> > > 4M pages)
> >
> > Yes.
> 
> Not necessarily. Just kernel text and data. I don't have the code in front
> of me ATM, but there are simple checks you can do to determine the
> type/size of page.
> 
> We don't have to care about userspace, though, once all processes are
> frozen, so we don't have to deal with the 4k pages.
> 
> And the thing is, the only reason we require PSE and 4 MB pages is because
> it provides a 2-level page table instead of a 3-level, which by
> definition is easier to manage. :)

Wait... wait... If the whole linear mapping isn't mapped by this flat
pgdir, then we have a problem, since the MMU will have to go down the
kernel pagetables to actually access the pages data when copying them
around... but at this point, we are overriding the boot kernel page
tables with the loader ones, so ...

Ben.
 

