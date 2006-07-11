Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750782AbWGKI74@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750782AbWGKI74 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 04:59:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750783AbWGKI74
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 04:59:56 -0400
Received: from smtp.osdl.org ([65.172.181.4]:46300 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750782AbWGKI74 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 04:59:56 -0400
Date: Tue, 11 Jul 2006 01:59:41 -0700
From: Andrew Morton <akpm@osdl.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: rjw@sisk.pl, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -mm 1/2] swsusp: clean up browsing of pfns
Message-Id: <20060711015941.d35f0b7d.akpm@osdl.org>
In-Reply-To: <20060711083415.GB1787@elf.ucw.cz>
References: <200607102240.45365.rjw@sisk.pl>
	<200607102251.40083.rjw@sisk.pl>
	<20060711083415.GB1787@elf.ucw.cz>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Jul 2006 10:34:15 +0200
Pavel Machek <pavel@ucw.cz> wrote:

> Hi!
> 
> > Clean up some loops over pfns for each zone in snapshot.c: reduce the number
> > of additions to perform, rework detection of saveable pages and make the code
> > a bit less difficult to understand, hopefully.
> 
> Also remove the BUG_ON() so that you can solve Andrew's monster
> machine problem.

I don't understand your comment.  I assume you're adding an explanation for
the removal of:

-	BUG_ON(PageReserved(page) && PageNosave(page));

from saveable_page().

But my emt64 test box is oopsing when touching a hole in the memory-map; it
isn't going BUG() (any more than usual ;))

