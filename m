Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262672AbVDYPla@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262672AbVDYPla (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Apr 2005 11:41:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262665AbVDYPk3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Apr 2005 11:40:29 -0400
Received: from cantor2.suse.de ([195.135.220.15]:41901 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S262624AbVDYPdN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Apr 2005 11:33:13 -0400
Date: Mon, 25 Apr 2005 17:33:10 +0200
From: Andi Kleen <ak@suse.de>
To: Roland McGrath <roland@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86_64: handle iret faults better
Message-ID: <20050425153310.GB16828@wotan.suse.de>
References: <200504240050.j3O0obqR032684@magilla.sf.frob.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200504240050.j3O0obqR032684@magilla.sf.frob.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 23, 2005 at 05:50:37PM -0700, Roland McGrath wrote:
> This is the x86_64 variant of the i386 fix I just submitted.  I think
> iret can only produce these faults when returning to user mode in a
> 32-bit process.  The failure mode is even more mysterious on x86_64,
> because it exits with -9999&0x7f instead of 11 (SIGSEGV), so it says
> "Unknown signal 113 (core dumped)" when it exits without actually
> trying to dump a core file.

I agree that handling this better is a good idea.

But I really hate your is_iret hack in traps.c. Cant you just force the signal
after fixing up the stack? I dont want such a ugly complicated special case 
there that only handles this extremly exotic case.
If you cant do it in a cleaner way it would be better not to fix it.
But I suppose forcing a signal directly is doable.

-Andi
