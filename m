Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964897AbVHKKa7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964897AbVHKKa7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 06:30:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964900AbVHKKa6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 06:30:58 -0400
Received: from grendel.sisk.pl ([217.67.200.140]:63446 "HELO mail.sisk.pl")
	by vger.kernel.org with SMTP id S964897AbVHKKa6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 06:30:58 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: linux-kernel@vger.kernel.org, "Martin J. Bligh" <mbligh@mbligh.org>
Subject: Re: [RFC][patch 0/2] mm: remove PageReserved
Date: Thu, 11 Aug 2005 12:36:24 +0200
User-Agent: KMail/1.8.2
Cc: Pavel Machek <pavel@suse.cz>, Daniel Phillips <phillips@arcor.de>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linux Memory Management <linux-mm@kvack.org>,
       Hugh Dickins <hugh@veritas.com>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, Andrea Arcangeli <andrea@suse.de>
References: <42F57FCA.9040805@yahoo.com.au> <20050810215022.GA2465@elf.ucw.cz> <1256640000.1123711001@flay>
In-Reply-To: <1256640000.1123711001@flay>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508111236.25576.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wednesday, 10 of August 2005 23:56, Martin J. Bligh wrote:
> --On Wednesday, August 10, 2005 23:50:22 +0200 Pavel Machek <pavel@suse.cz> wrote:
> 
> > Hi!
> > 
> >> > Swsusp is the main "is valid ram" user I have in mind here. It
> >> > wants to know whether or not it should save and restore the
> >> > memory of a given `struct page`.
> >> 
> >> Why can't it follow the rmap chain?
> > 
> > It is walking physical memory, not memory managment chains. I need
> > something like:
> 
> Can you not use page_is_ram(pfn) ?

IMHO it would be inefficient.

There obviously are some non-RAM pages that should not be saved and there are
some that are not worthy of saving, although they are RAM (eg because they never
change), but this is very archtecture-dependent.  The arch code should mark them
as PageNosave for swsusp, and that's enough.

Greets,
Rafael


-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
