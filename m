Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262019AbVATVqk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262019AbVATVqk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jan 2005 16:46:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262039AbVATVqj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jan 2005 16:46:39 -0500
Received: from grendel.digitalservice.pl ([217.67.200.140]:60356 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S262019AbVATVqh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jan 2005 16:46:37 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Pavel Machek <pavel@suse.cz>
Subject: Re: [PATCH][RFC] swsusp: speed up image restoring on x86-64
Date: Thu, 20 Jan 2005 22:46:37 +0100
User-Agent: KMail/1.7.1
Cc: Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>,
       hugang@soulinfo.com, LKML <linux-kernel@vger.kernel.org>
References: <200501202032.31481.rjw@sisk.pl> <20050120205950.GF468@openzaurus.ucw.cz>
In-Reply-To: <20050120205950.GF468@openzaurus.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501202246.38506.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, 20 of January 2005 21:59, Pavel Machek wrote:
> Hi!
> 
> > The following patch speeds up the restoring of swsusp images on x86-64
> > and makes the assembly code more readable (tested and works on AMD64).  It's
> > against 2.6.11-rc1-mm1, but applies to 2.6.11-rc1-mm2.  Please consifer for applying.
> 
> Can you really measure the speedup?

In terms of time?  Probably I can, but I prefer to measure it in terms of the numbers of
operations to be performed.

With this patch, at least 8 times less memory accesses are required to restore an image
than without it, and in the original code cr3 is reloaded after copying each _byte_,
let alone the SIB arithmetics.  I'd expect it to be 10 times faster or so.

The readability of code is also important, IMHO.

> If you want cheap way to speed it up, kill cr3 manipulation.

Sure, but I think it's there for a reason.

> Anyway, this is likely to clash with hugang's work; I'd prefer this not to be applied.

I am aware of that, but you are not going to merge the hugang's patches soon, are you?
If necessary, I can change the patch to work with his code (hugang, what do you think?).

Greets,
RJW


-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
