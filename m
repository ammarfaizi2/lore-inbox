Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932208AbVHROdv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932208AbVHROdv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Aug 2005 10:33:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932233AbVHROdv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Aug 2005 10:33:51 -0400
Received: from mx1.redhat.com ([66.187.233.31]:51386 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932208AbVHROdv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Aug 2005 10:33:51 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20050816135900.GA3326@elf.ucw.cz> 
References: <20050816135900.GA3326@elf.ucw.cz>  <200508121329.46533.phillips@istop.com> <200508110812.59986.phillips@arcor.de> <20050808145430.15394c3c.akpm@osdl.org> <26569.1123752390@warthog.cambridge.redhat.com> <5278.1123850479@warthog.cambridge.redhat.com> 
To: Pavel Machek <pavel@ucw.cz>
Cc: David Howells <dhowells@redhat.com>, Daniel Phillips <phillips@istop.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org, Hugh Dickins <hugh@veritas.com>
Subject: Re: [RFC][PATCH] Rename PageChecked as PageMiscFS 
X-Mailer: MH-E 7.82; nmh 1.0.4; GNU Emacs 22.0.50.4
Date: Thu, 18 Aug 2005 15:33:18 +0100
Message-ID: <7489.1124375598@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek <pavel@ucw.cz> wrote:

> > My patch has been around for quite a while, and no-one else has
> > complained, not even you before this point. Plus, you don't seem to be
> > complaining about PageSwapCache... nor even PageLocked.
> 
> PageFsMisc really *is* ugly and hard to read. PageLocked etc. look
> bad, too but ThIs iS rEaLlY WrOnG.

And PageMappedToDisk()?

I disagree. For the most part weird capsage is wrong, but this is readable.
Whilst it could make it page_fs_misc() instead, that'd be against the style of
the rest of the file, though maybe you want to go through and change all of
that too.

Maybe you'd prefer bPageFsMisc()? :-)

Actually, all these functions should really be called something like
IsPageXxxx() to note they're asking a question rather than giving a command.

> PageMisc would look less ugly

I disagree again. I don't think PageFsMisc() is particularly ugly or
unreadable; and it makes it a touch more likely that someone reading code that
uses it will notice that it's a miscellaneous flag specifically for filesystem
use (you can't rely on them going and looking in the header file for a
comment).

> , make note in a comment that it is for filesystems only.

There should be a comment as well, I suppose. I'll amend the patch for Andrew.

All this should also be documented in Documentation/ somewhere too, I suppose.

David
