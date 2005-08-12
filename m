Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932094AbVHLVXw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932094AbVHLVXw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Aug 2005 17:23:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751282AbVHLVXw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Aug 2005 17:23:52 -0400
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:12242 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1751281AbVHLVXw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Aug 2005 17:23:52 -0400
Subject: Re: test_signal results AIX DU4 IRIX6 (was: [PATCH] Fix PPC signal
	handling of NODEFER, should not affect sa_mask)
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Jesper Juhl <jesper.juhl@gmail.com>, Robert Wilkens <robw@optonline.net>,
       Bodo Stroesser <bstroesser@fujitsu-siemens.com>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Chris Wright <chrisw@osdl.org>
In-Reply-To: <200508121316.55757.merritt@u.washington.edu>
References: <200508121316.55757.merritt@u.washington.edu>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Fri, 12 Aug 2005 17:23:33 -0400
Message-Id: <1123881813.5296.19.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I received this from someone. I'm BCCing him since he didn't email to
the LKML himself (for some reason, maybe he doesn't want spam), I'll
protect his identity. If he wants to take credit, he should CC everyone.


On Fri, 2005-08-12 at 13:16 -0700, Someone wrote:
> DU4
> ===
> [3] uname -a
> OSF1 hostname V4.0 878 alpha
> [4] ./test_signal 
> sa_mask blocks other signals
> SA_NODEFER does not block other signals

> SA_NODEFER does not affect sa_mask

The above here is what the patch does, and NOT what Linux currently
does.

> SA_NODEFER and sa_mask blocks sig

Same goes for the above here.

> !SA_NODEFER blocks sig
> SA_NODEFER does not block sig
> sa_mask blocks sig
> 
> AIX
> ===
> [36] uname -a
> AIX hostname 2 5 000A1B9A4C00
> [37] ./test_signal 
> sa_mask blocks other signals
> SA_NODEFER does not block other signals

> SA_NODEFER does not affect sa_mask
> SA_NODEFER and sa_mask blocks sig

Strike two. looks good for the patch.

> !SA_NODEFER blocks sig
> SA_NODEFER does not block sig
> sa_mask blocks sig
> 
> Irix 6.5
> ========
> [9] uname -a
> IRIX hostname 6.5 07201607 IP22
> [10] ./test_signal 
> sa_mask blocks other signals
> SA_NODEFER does not block other signals

> SA_NODEFER does not affect sa_mask
> SA_NODEFER and sa_mask blocks sig

Strike three, your out!

> !SA_NODEFER blocks sig
> SA_NODEFER does not block sig
> sa_mask blocks sig
> 

So Linux is not compliant with other unices.  So I guess I'll get going
on sending in patches for each architecture.

Oh, just to show you what Linux shows without the patch:

$ uname -a
Linux bilbo 2.6.12 #2 SMP Wed Jul 20 20:07:59 EDT 2005 i686 GNU/Linux

$ ./test_signal
sa_mask blocks other other signals
SA_NODEFER does not block other signals
SA_NODEFER affects sa_mask
SA_NODEFER and sa_mask does not block sig
!SA_NODEFER blocks sig
SA_NODEFER does not block sig
sa_mask blocks sig


And with the patch:

$ uname -a
Linux goliath 2.6.13-rc3 #5 SMP Fri Aug 12 14:39:38 EDT 2005 i686
GNU/Linux

$ ./test_signal
sa_mask blocks other signals
SA_NODEFER does not block other signals
SA_NODEFER does not affect sa_mask
SA_NODEFER and sa_mask blocks sig
!SA_NODEFER blocks sig
SA_NODEFER does not block sig
sa_mask blocks sig


-- Steve


