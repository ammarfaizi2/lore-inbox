Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932655AbVJCXRl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932655AbVJCXRl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Oct 2005 19:17:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932695AbVJCXRl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Oct 2005 19:17:41 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:3483 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932655AbVJCXRl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Oct 2005 19:17:41 -0400
Date: Tue, 4 Oct 2005 01:17:15 +0200
From: Pavel Machek <pavel@ucw.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Andrew Morton <akpm@osdl.org>, kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [swsusp] separate snapshot functionality to separate file
Message-ID: <20051003231715.GA17458@elf.ucw.cz>
References: <20051002231332.GA2769@elf.ucw.cz> <200510032339.08217.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200510032339.08217.rjw@sisk.pl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Split swsusp.c into swsusp.c and snapshot.c. Snapshot only cares
> > provides system snapshot/restore functionality, while swsusp.c will
> > provide disk i/o. It should enable untangling of the code in future;
> > swsusp.c parts can mostly be done in userspace.
> > 
> > No code changes.
> 
> I think that the functions:
> 
> read_suspend_image()
> read_pagedir()
> swsusp_pagedir_relocate() (BTW, why there's "swsusp_"?)
> check_pagedir() (BTW, misleading name)
> data_read()
> eat_page()
> get_usable_page()
> free_eaten_memory()
> 
> should be moved to snapshot.c as well, because they are in fact
> symmetrical to what's there (they perform the reverse of creating
> the snapshot and use analogous data structures).  IMO the code
> change required would not be so drammatic and all of the functions
> that _operate_ on the snapshot would be in the same file.

No. read_suspend_image/read_pagedir/data_read is image reading. That
does not belong to snaphost. The rest is notthat clear, but I have it
working in userspace.

Image creation is still done in kernel space, but I think that kernel
<-> user interface is going to be cleaner that way, and I do not think
pushing it to user is so huge win.

Yes, names are not ideal, but that will be followup patch.
								Pavel
-- 
if you have sharp zaurus hardware you don't need... you know my address
