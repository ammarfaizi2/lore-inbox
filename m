Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261733AbVG1RAL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261733AbVG1RAL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 13:00:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261717AbVG1Q6T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 12:58:19 -0400
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:41101 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S261739AbVG1Q5w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 12:57:52 -0400
Subject: Re: [PATCH] speed up on find_first_bit for i386 (let compiler do
	the work)
From: Steven Rostedt <rostedt@goodmis.org>
To: "Maciej W. Rozycki" <macro@linux-mips.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>, Daniel Walker <dwalker@mvista.com>
In-Reply-To: <Pine.LNX.4.61L.0507281725010.31805@blysk.ds.pg.gda.pl>
References: <1122473595.29823.60.camel@localhost.localdomain>
	 <1122512420.5014.6.camel@c-67-188-6-232.hsd1.ca.comcast.net>
	 <1122513928.29823.150.camel@localhost.localdomain>
	 <1122519999.29823.165.camel@localhost.localdomain>
	 <1122521538.29823.177.camel@localhost.localdomain>
	 <1122522328.29823.186.camel@localhost.localdomain>
	 <42E8564B.9070407@yahoo.com.au>
	 <1122551014.29823.205.camel@localhost.localdomain>
	 <Pine.LNX.4.58.0507280823210.3227@g5.osdl.org>
	 <1122565640.29823.242.camel@localhost.localdomain>
	 <Pine.LNX.4.61L.0507281725010.31805@blysk.ds.pg.gda.pl>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Thu, 28 Jul 2005 12:57:28 -0400
Message-Id: <1122569848.29823.248.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-07-28 at 17:34 +0100, Maciej W. Rozycki wrote:

>  Since you're considering GCC-generated code for ffs(), ffz() and friends, 
> how about trying __builtin_ffs(), __builtin_clz() and __builtin_ctz() as 
> apropriate?  Reasonably recent GCC may actually be good enough to use the 
> fastest code depending on the processor submodel selected.

I can change the find_first_bit to use __builtin_ffs, but how would you
implement the ffz?  The clz and ctz only count the number of leading or
trailing zeros respectively, it doesn't find the first zero. Of course a
__builtin_ctz(~x) would but this might take longer than what we already
have.  I'll go ahead and try it and see.  But I still don't have a
decent benchmark on this. I'll start looking into the kernel and see how
it's used, and see if I can find a proper benchmark.

-- Steve


