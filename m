Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264808AbUFGQD0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264808AbUFGQD0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jun 2004 12:03:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264822AbUFGQD0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jun 2004 12:03:26 -0400
Received: from fw.osdl.org ([65.172.181.6]:42422 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264808AbUFGQDV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jun 2004 12:03:21 -0400
Date: Mon, 7 Jun 2004 09:03:07 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Thomas Gleixner <tglx@linutronix.de>
cc: Greg Weeks <greg.weeks@timesys.com>,
       linux-arm-kernel@lists.arm.linux.org.uk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.4] jffs2 aligment problems
In-Reply-To: <200406071736.53101.tglx@linutronix.de>
Message-ID: <Pine.LNX.4.58.0406070900010.6162@ppc970.osdl.org>
References: <40C484F9.20504@timesys.com> <200406071736.53101.tglx@linutronix.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 7 Jun 2004, Thomas Gleixner wrote:
>
> On Monday 07 June 2004 17:08, Greg Weeks wrote:
> > This fixed some jffs2 alignment problems we saw on an IXP425 based
> > XScale board. I just got pinged that I was supposed to post this patch
> > in case anyone else finds it usefull. This was against a modified 2.4.19
> > kernel.
> 
> Enable CONFIG_ALIGNMENT_TRAP instead of tweaking the code. 
> JFFS2 / MTD must be allowed to do unaligned access

Wrong.

Pleas fix jffs2 to use the proper "get_unaligned()"/"put_unaligned()"  
instead.

Emulating unaligned accesses with traps (even even the architecture
supports it, which isn't universally true) is _stupid_ when we have 
perfectly well-defined macros for them that do it faster and are 
_designed_ for this.

On architectures where it doesn't matter, the macros just do the access, 
so it's not like you're slowing anything down.

		Linus
