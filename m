Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261410AbUK1IVT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261410AbUK1IVT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Nov 2004 03:21:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261411AbUK1IVT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Nov 2004 03:21:19 -0500
Received: from courier.cs.helsinki.fi ([128.214.9.1]:51419 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP id S261410AbUK1IVP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Nov 2004 03:21:15 -0500
Subject: Re: [PATCH] Document kfree and vfree NULL usage
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Tomas Carnecky <tom@dbservice.com>, Marcel Sebek <sebek64@post.cz>,
       akpm@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <41A9190D.5020108@yahoo.com.au>
References: <1101565560.9988.20.camel@localhost>
	 <20041127171357.GA5381@penguin.localdomain>
	 <41A9148E.6070501@dbservice.com>  <41A9190D.5020108@yahoo.com.au>
Date: Sun, 28 Nov 2004 10:20:20 +0200
Message-Id: <1101630020.9996.23.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution 2.0.2 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tomas Carnecky wrote:
> > Isn't 'if (x) { free(x); }' faster than the call to free() with a NULL
> > pointer?
> > What about a macro ?
> > #define fast_free(x) if (x) { free(x); }
> > Or even
> > #define kfree(x) if (x) { _kfree(x); }
> > Or maybe a inline function so it doesn't break existing code.
> > inline void kfree(x) { if (x) { _kfree(x); } }

On Sun, 2004-11-28 at 11:17 +1100, Nick Piggin wrote:
> Well if a NULL parameter is the exceptional case, then you don't want to
> litter the L1 cache with the extra code that will only save a function
> call in rare cases.
> 
> And I think it should be the exceptional case, because it shouldn't really
> be used for much other than streamline error handling or cleanup functions
> to cope with failed allocations without adding checks everywhere. If you're
> doing lots of kfree(NULL) as part of normal operation, then that may
> suggest you aren't tracking your memory very well.

Agreed. The drivers also use NULL for optional fields btw. Removing the
redundant checks reduce the size of source and object code so we get
more readable code and smaller memory footprint at the same time (yay!).
Furthermore, we get rid of the _confusion_ over the use of kfree() and
vfree().

		Pekka

