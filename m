Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265144AbUBEMRF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Feb 2004 07:17:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265149AbUBEMRE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Feb 2004 07:17:04 -0500
Received: from gprs154-93.eurotel.cz ([160.218.154.93]:29824 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S265144AbUBEMRB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Feb 2004 07:17:01 -0500
Date: Thu, 5 Feb 2004 13:16:48 +0100
From: Pavel Machek <pavel@suse.cz>
To: Andi Kleen <ak@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       amitkale@emsyssoft.com, "La Monte H.P. Yarroll" <piggy@timesys.com>,
       trini@kernel.crashing.org
Subject: Re: kgdb support in vanilla 2.6.2
Message-ID: <20040205121648.GE213@elf.ucw.cz>
References: <20040204230133.GA8702@elf.ucw.cz.suse.lists.linux.kernel> <20040204152137.500e8319.akpm@osdl.org.suse.lists.linux.kernel> <402182B8.7030900@timesys.com.suse.lists.linux.kernel> <20040204155452.49c1eba8.akpm@osdl.org.suse.lists.linux.kernel> <p73n07ykyop.fsf@verdi.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <p73n07ykyop.fsf@verdi.suse.de>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > need to take a look at such things and really convice ourselves that
> > they're worthwhile.  Personally, I'd only be interested in the basic stub.
> 
> What I found always extremly ugly in the i386 stub was that it uses
> magic globals to talk to the page fault handler. For the x86-64
> version I replaced that by just using __get/__put_user in the memory
> accesses, which is much cleaner. I would suggest doing that for i386
> too.
> 
> Also what's also ugly in i386 is that it uses ugly hooks in traps.c/fault.c.
> On x86-64 I instead added generic notifiers (see include/asm-x86_64/die.h
> and notify_die in arch/x86_64/kernel/traps.c) 
> where both kdb and kgdb and possibly dprobes and other debuggers can hook
> in without conflicting patches for the same files from everybody.
> I would strongly suggest to adopt such a generic framework for i386 too
> to clean up the core kernel <-> debugger interaction. As soon as this
> frame work is in just dropping the stub is is very clean.
> 
> The x86-64 version should be pretty simple to port to i386 if someone
> is interested ...

Hmm, this tells me that perhaps it is reasonable to get amd64 version
in first, since it received lot of cleaning already...
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
