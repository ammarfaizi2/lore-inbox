Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261669AbTILFEA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Sep 2003 01:04:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261676AbTILFEA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Sep 2003 01:04:00 -0400
Received: from [63.205.85.133] ([63.205.85.133]:51441 "EHLO gaz.sfgoth.com")
	by vger.kernel.org with ESMTP id S261669AbTILFD6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Sep 2003 01:03:58 -0400
Date: Thu, 11 Sep 2003 22:12:12 -0700
From: Mitchell Blank Jr <mitch@sfgoth.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] oops_in_progress is unlikely()
Message-ID: <20030912051212.GH41254@gaz.sfgoth.com>
References: <20030907064204.GA31968@sfgoth.com> <20030907221323.GC28927@redhat.com> <20030910142031.GB2589@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030910142031.GB2589@elf.ucw.cz>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I feel sorry that my trivial little patch has spawned such a large thread.

Pavel Machek wrote:
> > There comes a point where readability is lost, for no measurable gain.
> 
> Perhaps we should have macros ifu() and ifl(), that would be used as a
> plain if, just with likelyness-indication?

No, I think that would be a move in the wrong direction.

I've already described my personal opinion about unlikely() in a couple
private emails, but for the record:

When I see code like...

	if (unlikely(condition)) {
	}

...it reads to me like...

	if (condition) {	/* Unlikely error case */
	}

In other words it documents the code making it MORE readable than before
(obviously this can be done to excess).  If the compiler can also do
something useful with the information, so much the better.

Perhaps I'm the only one that feels that way, though.

Your ifu/ifl suggestion I think is pretty ugly.  First off, it would break
syntax-highlighting editors which would hurt readability a lot.  Also its
not obvious at all what "ifu (x == 0)" means - you can pretty much guess what
"if (unlikely(x == 0))" does the first time you see it.

-Mitch
