Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263889AbTDIWL6 (for <rfc822;willy@w.ods.org>); Wed, 9 Apr 2003 18:11:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263897AbTDIWL6 (for <rfc822;linux-kernel-outgoing>); Wed, 9 Apr 2003 18:11:58 -0400
Received: from palrel13.hp.com ([156.153.255.238]:63439 "EHLO palrel13.hp.com")
	by vger.kernel.org with ESMTP id S263889AbTDIWLz (for <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Apr 2003 18:11:55 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16020.40294.606401.506996@napali.hpl.hp.com>
Date: Wed, 9 Apr 2003 15:23:34 -0700
To: Christoph Hellwig <hch@infradead.org>
Cc: davidm@hpl.hp.com, torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: bk pull
In-Reply-To: <20030409215650.A10311@infradead.org>
References: <200304091927.h39JRob0010157@napali.hpl.hp.com>
	<20030409203836.A9397@infradead.org>
	<16020.34678.824488.248372@napali.hpl.hp.com>
	<20030409215650.A10311@infradead.org>
X-Mailer: VM 7.07 under Emacs 21.2.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Wed, 9 Apr 2003 21:56:50 +0100, Christoph Hellwig <hch@infradead.org> said:

  Christoph> Hey, I didn't mean _always_ build out of the box :) I'm
  Christoph> much more looking forward to 2.6.x releases I'd like to
  Christoph> see just build for ia64.

That's a goal I share.  But I won't reach it without some help.

  >> I'm working on) and the virtual mem_map support.  The latter I
  >> haven't pushed at all so far, mostly because I just haven't had
  >> the time/energy/interest to do so.  Also, I'm always optimistic
  >> someone else comes along to help with the work... ;-)

  Christoph> Well, I could try to help pushing some stuff.  OTOH
  Christoph> pushing stuff I don't understand is a bad idea.

That's true.

  Christoph> Could you please explain e.g. the mm/bootmem.c and
  Christoph> mm/page_alloc.c changes?

The bootmem patch is a performance speed up and some minor indendation
fixups.  The problem was that the bootmem code was (a) hugely slow and
(b) had execution that grew quadratically with the size of the bootmap
bitmap.  This causes noticable slowdowns, especially on machines with
(relatively) large holes in the physical memory map.  Issue (b) is
addressed by maintaining the "last_success" cache, so that we start
the next search from the place where we last found some memory (this
part of the patch could stand additional reviewing/testing).  Issue
(a) is addressed by using find_next_zero_bit() instead of the slow
bit-by-bit testing.

The page_alloc.c changes are in support of virtual mem_map: it needs
an architecture-specific hook when initializing the mem_map.  The
patch should be safe for arches that don't use virtual mem_map.

	--david
