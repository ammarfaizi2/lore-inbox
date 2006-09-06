Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751251AbWIFHn3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751251AbWIFHn3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 03:43:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750974AbWIFHn3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 03:43:29 -0400
Received: from ns2.suse.de ([195.135.220.15]:19630 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750769AbWIFHn2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 03:43:28 -0400
From: Andi Kleen <ak@suse.de>
To: Keith Owens <kaos@ocs.com.au>
Subject: Re: Was: boot failure, "DWARF2 unwinder stuck at 0xc0100199"
Date: Wed, 6 Sep 2006 09:43:14 +0200
User-Agent: KMail/1.9.3
Cc: "Jan Beulich" <jbeulich@novell.com>,
       "Badari Pulavarty" <pbadari@gmail.com>,
       "J. Bruce Fields" <bfields@fieldses.org>, petkov@math.uni-muenster.de,
       akpm@osdl.org, "lkml" <linux-kernel@vger.kernel.org>
References: <13380.1157524272@ocs3.ocs.com.au>
In-Reply-To: <13380.1157524272@ocs3.ocs.com.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609060943.14663.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Lots of luck.  I logged a bug several years ago against gcc for ia64
> with noreturn calls.  When gcc sees a call to a function marked
> noreturn (like do_exit or panic), gcc has been known to discard all
> code past that point.  The unwind code has to assume that the return
> address is pointing into the previous function.  Where does the return
> address point after a noreturn call compiled with the gcc bug?  - at
> the start of the next function.  Goodbye unwind.
> 
> I asked that gcc always insert at least one instruction after a call to
> a noreturn function.  That would keep the return address inside the
> right function and the unwind code would work.  Ideally that
> instruction would cause an error if it was ever executed (break 0 on
> ia64, ud2 on i386/x86_64) but even a no-op would be good enough.  Most
> of the ia64 list thought it was a good idea, the gcc team disagreed.
> AFAIK the bug is still outstanding.


In the discussion Jan came up with a heuristic that will probably work.
It involved deciding in the unwinder by heuristic if it should subtract 
one from the program counter (like the gcc unwinder apparently does) or not.

He hasn't sent a patch implementing it yet though :)

-Andi
