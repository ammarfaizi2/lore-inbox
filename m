Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266237AbUHBDWo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266237AbUHBDWo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Aug 2004 23:22:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266240AbUHBDWo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Aug 2004 23:22:44 -0400
Received: from digitalimplant.org ([64.62.235.95]:46551 "HELO
	digitalimplant.org") by vger.kernel.org with SMTP id S266237AbUHBDWm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Aug 2004 23:22:42 -0400
Date: Sun, 1 Aug 2004 20:22:28 -0700 (PDT)
From: Patrick Mochel <mochel@digitalimplant.org>
X-X-Sender: mochel@monsoon.he.net
To: Pavel Machek <pavel@ucw.cz>
cc: linux-kernel@vger.kernel.org
Subject: Re: [6/25] Merge pmdisk and swsusp
In-Reply-To: <20040718221302.GC31958@atrey.karlin.mff.cuni.cz>
Message-ID: <Pine.LNX.4.50.0408012020200.30101-100000@monsoon.he.net>
References: <Pine.LNX.4.50.0407171528280.22290-100000@monsoon.he.net>
 <20040718221302.GC31958@atrey.karlin.mff.cuni.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 19 Jul 2004, Pavel Machek wrote:

> > +/**
> > + *	enough_free_mem - Make sure we enough free memory to snapshot.
> > + *
> > + *	Returns TRUE or FALSE after checking the number of available
> > + *	free pages.
> > + */
> > +
> > +static int enough_free_mem(void)
> > +{
> > +	if(nr_free_pages() < (nr_copy_pages + PAGES_FOR_IO)) {
> > +		pr_debug("pmdisk: Not enough free pages: Have %d\n",
> > +			 nr_free_pages());
> > +		return 0;
> > +	}
> > +	return 1;
> > +}

> Perhaps enough_free_* should return 0 / -ERROR to keep it consistent
> with rest of code, no need to explain TRUE/FALSE etc?

Well, then they wouldn't read like plain language..

Besides, they're superfluous and racy anyway - the amount of memory and
swap space free could change at any time, so we should just remove them
and make sure our error handlin is correct later down the line when
allocations fail..


	Pat
