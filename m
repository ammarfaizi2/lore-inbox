Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932195AbWIYGJk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932195AbWIYGJk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Sep 2006 02:09:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751783AbWIYGJj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Sep 2006 02:09:39 -0400
Received: from smtp.ocgnet.org ([64.20.243.3]:48587 "EHLO smtp.ocgnet.org")
	by vger.kernel.org with ESMTP id S1751298AbWIYGJi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Sep 2006 02:09:38 -0400
Date: Mon, 25 Sep 2006 15:09:17 +0900
From: Paul Mundt <lethal@linux-sh.org>
To: Matthew Wilcox <matthew@wil.cx>
Cc: Hirokazu Takata <takata@linux-m32r.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH] m32r: Revise __raw_read_trylock()
Message-ID: <20060925060917.GA8422@localhost.na.rta>
References: <swfzmcse7mm.wl%takata@linux-m32r.org> <20060922074813.GA20921@localhost.Internal.Linux-SH.ORG> <20060922112708.GR2585@parisc-linux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060922112708.GR2585@parisc-linux.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 22, 2006 at 05:27:08AM -0600, Matthew Wilcox wrote:
> You're assuming:
> 
>  - a spinlock is an atomic_t.
>  - Said atomic_t uses RW_LOCK_BIAS to indicate locked/unlocked.
> 
> This is true for m32r, but not for sparc.

That makes sense, thanks for the clarification.

> SuperH looks completely broken -- I don't see how holding a read lock
> prevents someone else from getting a write lock.  The SH write_trylock
> uses RW_LOCK_BIAS, but write_lock doesn't.  Are there any SMP SH
> machines?

Yes, it's broken, most of the work for that has been happening out of
tree, and we'll have to sync it up again. The initial work was targetted
at a pair of microcontrollers, but there were too many other issues
there that the work was eventually abandoned. Recently it's started up
again on more reasonable CPUs, so we'll be fixing these things up in
order.
