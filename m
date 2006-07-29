Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932580AbWG2Hym@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932580AbWG2Hym (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jul 2006 03:54:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932612AbWG2Hym
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jul 2006 03:54:42 -0400
Received: from mx1.redhat.com ([66.187.233.31]:25498 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932580AbWG2Hyl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jul 2006 03:54:41 -0400
Date: Sat, 29 Jul 2006 03:54:14 -0400
From: Dave Jones <davej@redhat.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Andi Kleen <ak@suse.de>, Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] i386: Do backtrace fallback too
Message-ID: <20060729075414.GA16118@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Andi Kleen <ak@suse.de>, Linus Torvalds <torvalds@osdl.org>
References: <200607290300.k6T306Fc003168@hera.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200607290300.k6T306Fc003168@hera.kernel.org>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 29, 2006 at 03:00:06AM +0000, Linux Kernel wrote:
 > commit c97d20a6c51067a38f53680d9609b4cf2867d077
 > tree 59867ac01d1b752ba7e520e33f9f84cade6d024e
 > parent b783fd925cdd56d24d164e5bdcb072f2a67aedf4
 > author Andi Kleen <ak@suse.de> Fri, 28 Jul 2006 14:44:57 +0200
 > committer Linus Torvalds <torvalds@g5.osdl.org> Sat, 29 Jul 2006 09:28:00 -0700
 > 
 > [PATCH] i386: Do backtrace fallback too
 > 
 > Similar patch to earlier x86-64 patch. When the dwarf2 unwinder fails
 > dump the left over stack with the old unwinder.
 > 
 > Also some clarifications in the headers.
 > 
 > Signed-off-by: Andi Kleen <ak@suse.de>
 > Signed-off-by: Linus Torvalds <torvalds@osdl.org>
 > 
 >  arch/i386/kernel/traps.c |   17 ++++++++++++++---
 >  1 files changed, 14 insertions(+), 3 deletions(-)

Hmm, this breaks the build for me..

arch/i386/kernel/traps.c: In function 'show_trace_log_lvl':
arch/i386/kernel/traps.c:195: error: invalid type argument of '->'
arch/i386/kernel/traps.c:198: error: invalid type argument of '->'
arch/i386/kernel/traps.c:199: error: invalid type argument of '->'
make[1]: *** [arch/i386/kernel/traps.o] Error 1

(The line numbers are different to mainline due to some unrelated
patches, they point to the UNW_PC/UNW_SP usages),


Also, shouldn't this..

	print_symbol("DWARF2 unwinder stuck at %s\n",
		UNW_PC(info.regs));

be using %p ?

		Dave

-- 
http://www.codemonkey.org.uk
