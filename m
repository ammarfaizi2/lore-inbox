Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263587AbUBCADX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Feb 2004 19:03:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261957AbUBCADW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Feb 2004 19:03:22 -0500
Received: from mail5.speakeasy.net ([216.254.0.205]:24726 "EHLO
	mail5.speakeasy.net") by vger.kernel.org with ESMTP id S263587AbUBCADV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Feb 2004 19:03:21 -0500
Date: Mon, 2 Feb 2004 16:03:19 -0800
Message-Id: <200402030003.i1303JQE016298@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
To: Linus Torvalds <torvalds@osdl.org>
X-Fcc: ~/Mail/linus
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] restore protections after forced fault in get_user_pages
In-Reply-To: Linus Torvalds's message of  Monday, 2 February 2004 15:55:51 -0800 <Pine.LNX.4.58.0402021551320.9720@home.osdl.org>
X-Fcc: ~/Mail/linus
X-Antipastobozoticataclysm: Bariumenemanilow
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> That should be sufficient, I think: since "handle_mm_fault()" marks the 
> page dirty (but not writable) and will have done all the work to do a COW, 
> we know that once we do the "follow_page()", we'll be getting a private 
> copy. Which is what we wanted.

The only potential hole I can see here is if there is an (exceedingly rare)
race where the page could be ejected after handle_mm_fault, then brought
back in but not marked dirty, before follow_page looks it up and returns a
page to be used for writing without marking it dirty.  Obviously this is a
ridiculously unlikely case.  But what I don't know is whether it is
strictly speaking impossible.  That is, that a page once dirty then later
not present, would ever again be present without also being dirty.


Thanks,
Roland
