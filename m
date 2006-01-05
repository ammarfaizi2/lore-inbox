Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750958AbWAEVfk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750958AbWAEVfk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 16:35:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751141AbWAEVfk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 16:35:40 -0500
Received: from saraswathi.solana.com ([198.99.130.12]:65448 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S1750958AbWAEVfj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 16:35:39 -0500
Date: Thu, 5 Jan 2006 17:27:37 -0500
From: Jeff Dike <jdike@addtoit.com>
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: + uml-sigwinch-handling-cleanup.patch added to -mm tree
Message-ID: <20060105222737.GA10369@ccure.user-mode-linux.org>
References: <200601042323.k04NNti4021942@shell0.pdx.osdl.net> <200601052054.37512.blaisorblade@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200601052054.37512.blaisorblade@yahoo.it>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 05, 2006 at 08:54:37PM +0100, Blaisorblade wrote:
> Meanwhile, the whole content of the new free_winch(), including some syscalls
> on the host, and various other stuff, is brought back under the 
> winch_handler_lock.

And?  There's no particular problem with host system calls being under
a lock.  And the various other stuff is a kfree and a free_irq, which
I don't think have a problem being called under a spinlock.

> I had carefully brought that stuff out keeping only the list access under the
> lock, probably while fixing some "scheduling while atomic" warnings - once 
> the element is out of the list it's unreachable thus (IMHO) safely 
> accessible.

Probably?  What in there is sensitive to being called under a lock?

> So, list_del should be brought out from free_winch, which would then become 
> callable without the spinlock held.

That would increase the amount of code, with no gain that I can see.
The list_del would be duplicated, and the loop in winch_cleanup would
have to drop and reacquire the lock around each call to free_winch.

				Jeff
