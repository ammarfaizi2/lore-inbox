Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262353AbVAUMos@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262353AbVAUMos (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 07:44:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262356AbVAUMoC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 07:44:02 -0500
Received: from grendel.digitalservice.pl ([217.67.200.140]:46043 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S262353AbVAUMnj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 07:43:39 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Pavel Machek <pavel@suse.cz>
Subject: Re: [PATCH][RFC] swsusp: speed up image restoring on x86-64
Date: Fri, 21 Jan 2005 13:43:40 +0100
User-Agent: KMail/1.7.1
Cc: Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>,
       hugang@soulinfo.com, LKML <linux-kernel@vger.kernel.org>
References: <200501202032.31481.rjw@sisk.pl> <200501210114.14859.rjw@sisk.pl> <20050121100603.GD18373@elf.ucw.cz>
In-Reply-To: <20050121100603.GD18373@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501211343.41190.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, 21 of January 2005 11:06, Pavel Machek wrote:
> Hi!
> 
> > > Well, I know that current code works. It was produced by C compiler,
> > > btw. Now, new code works for you, but it was not in kernel for 4
> > > releases, and... this code is pretty subtle.
> > 
> > Now, I'm confused. :-)  It's roughly this:
> > 
> > struct pbe *pbe = pagedir_nosave, *end;
> > unsigned n = nr_copy_pages;
> > if (n) {
> > 	end = pbe + n;
> > 	do {
> > 		memcpy((void *)pbe->orig_address, (void *)pbe->address, PAGE_SIZE);
> > 		pbe++;
> > 	} while (pbe < end);
> > }
> > 
> > where memcpy() is of course a hand-written inline that includes the cr3 manipulation,
> > and pbe, end, n are registers.
> 
> For example it may not use any variable in memory, and may not use
> stack, as memory changes under its hands.

Which is not a big problem on x86-64. :-)

> Plus assembly is always subtle ;-).

And that's what makes it interesting.

Greets,
RJW


-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
