Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262208AbVATW66@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262208AbVATW66 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jan 2005 17:58:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262209AbVATW66
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jan 2005 17:58:58 -0500
Received: from grendel.digitalservice.pl ([217.67.200.140]:10440 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S262208AbVATW6u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jan 2005 17:58:50 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Pavel Machek <pavel@suse.cz>
Subject: Re: [PATCH][RFC] swsusp: speed up image restoring on x86-64
Date: Thu, 20 Jan 2005 23:58:53 +0100
User-Agent: KMail/1.7.1
Cc: Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>,
       hugang@soulinfo.com, LKML <linux-kernel@vger.kernel.org>
References: <200501202032.31481.rjw@sisk.pl> <200501202246.38506.rjw@sisk.pl> <20050120220630.GB22201@elf.ucw.cz>
In-Reply-To: <20050120220630.GB22201@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501202358.53918.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thursday, 20 of January 2005 23:06, Pavel Machek wrote:
> Hi!
> 
> > > > The following patch speeds up the restoring of swsusp images on x86-64
> > > > and makes the assembly code more readable (tested and works on AMD64).  It's
> > > > against 2.6.11-rc1-mm1, but applies to 2.6.11-rc1-mm2.  Please consifer for applying.
> > > 
> > > Can you really measure the speedup?
> > 
> > In terms of time?  Probably I can, but I prefer to measure it in terms of the numbers of
> > operations to be performed.
> > 
> > With this patch, at least 8 times less memory accesses are required to restore an image
> > than without it, and in the original code cr3 is reloaded after copying each _byte_,
> > let alone the SIB arithmetics.  I'd expect it to be 10 times faster
> > or so.
> 
> Well, 8 times less cr3 reloads may be significant... for the copy
> loop. Speeding up copy loop that takes  ... 100msec?... of whole
> resume (30 seconds) does not seem too important to me.
> 
> > The readability of code is also important, IMHO.
> 
> It did not seem too much better to me.

Well, the beauty is in the eye of the beholder. :-)

Still, it shrinks the code (22 lines vs 37 lines), it uses less GPRs (5 vs 7), it uses less
SIB arithmetics (0 vs 4 times), it uses a well known scheme for copying data pages.
As far as the result is concerned, it is equivalent to the existing code, but it's simpler
(and faster).  IMO, simpler code is always easier to understand.


> > > If you want cheap way to speed it up, kill cr3 manipulation.
> > 
> > Sure, but I think it's there for a reason.
> 
> Reason is "to crash it early if we have wrong pagetables".
> 
> > > Anyway, this is likely to clash with hugang's work; I'd prefer this not to be applied.
> > 
> > I am aware of that, but you are not going to merge the hugang's patches soon, are you?
> > If necessary, I can change the patch to work with his code (hugang, what do you think?).
> 
> I think it is just not worth the effort.

Why?  It won't take much time.  I've spent more time for writing the messages
in this thread ... ;-)

Greets,
RJW


-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
