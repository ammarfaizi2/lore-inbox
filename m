Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266811AbUBRAFo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 19:05:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266721AbUBRAFn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 19:05:43 -0500
Received: from fed1mtao01.cox.net ([68.6.19.244]:61916 "EHLO
	fed1mtao01.cox.net") by vger.kernel.org with ESMTP id S266811AbUBRADR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 19:03:17 -0500
Date: Tue, 17 Feb 2004 17:03:15 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][1/6] A different KGDB stub
Message-ID: <20040218000315.GN16881@smtp.west.cox.net>
References: <20040217220249.GB16881@smtp.west.cox.net> <20040217155036.33e37c67.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040217155036.33e37c67.akpm@osdl.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 17, 2004 at 03:50:36PM -0800, Andrew Morton wrote:

> Tom Rini <trini@kernel.crashing.org> wrote:
> >
> > The following is the core bits to this KGDB stub.
> 
> This still contains the kern_do_schedule() gunk.  Andi raised this issue
> last week.  He identified several other significant issues as well, but
> there was no followup.  Could you please dig out his email and address the
> points which he raised?  (I can't find the email - perhaps Andi could
> re-review this patch?)

By my read of Andi's email, the kern_do_schedule() gunk is "I really
don't like this change. It is completely useless because you can get the
pt_regs as well from the stack.  Please don't add it. George's stub also
didn't need it."

But I don't see how it does.  But I'll look again tomorrow.

The next issue was about adding debuggerinfo to thread_struct.  By my
read of the code, it's because of the thread handling bits that Amit's
version does that George's does not.  So I'm not sure how it's not
needed (unless all of the relevant code goes.  If that's too heavy, I
can remove all of that).

Next was that KGDB should use the notify_die hooks that are there, and
I've done that.

Finally, the save_context_frame stuff can go (x86_64-specific stuffs)
but as I don't have x86_64 hw (I'll try and whip up a toolchain
tomorrow, but I leave for FOSDEM Thursday) so I didn't touch that, in
hopes that someone who could test it would.

-- 
Tom Rini
http://gate.crashing.org/~trini/
