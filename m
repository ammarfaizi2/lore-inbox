Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750915AbWFLAOy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750915AbWFLAOy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jun 2006 20:14:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750917AbWFLAOy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jun 2006 20:14:54 -0400
Received: from xenotime.net ([66.160.160.81]:22469 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1750859AbWFLAOy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jun 2006 20:14:54 -0400
Date: Sun, 11 Jun 2006 17:17:40 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Jeff Dike <jdike@addtoit.com>
Cc: sam@ravnborg.org, akpm@osdl.org, jamagallon@ono.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ignore smp_locks section warnings from init/exit code
Message-Id: <20060611171740.b7f8e0fc.rdunlap@xenotime.net>
In-Reply-To: <20060611232558.GB20639@ccure.user-mode-linux.org>
References: <20060607104724.c5d3d730.akpm@osdl.org>
	<20060608003153.36f59e6a@werewolf.auna.net>
	<20060607154054.cf4f2512.akpm@osdl.org>
	<20060607162326.3d2cc76b.rdunlap@xenotime.net>
	<20060608021149.GA5567@ccure.user-mode-linux.org>
	<20060608183549.GB18815@mars.ravnborg.org>
	<20060611232558.GB20639@ccure.user-mode-linux.org>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.5 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 11 Jun 2006 19:25:58 -0400 Jeff Dike wrote:

> On Thu, Jun 08, 2006 at 08:35:49PM +0200, Sam Ravnborg wrote:
> > As for .bss this is a much more generic section - so for now this is not
> > added. Can you explain why there is a reference to do_mount_root from
> > .bss or is this a bug in modpost pointing out something wrong?
> 
> For me, the ld complaints are completely opaque.  Can you give me a
> clue how you go about figuring out where the complaint is coming from?
> 
> This is what I get with UML/x86_64 with rc6-mm2:
> 	WARNING: vmlinux - Section mismatch: reference to .init.text:huft_free from .bss between 'stdout@@GLIBC_2.2.5' (at offset 0x6027b748) and 'completed.6111'
> 
> gdb tells me:
> 	(gdb) x/4xa 0x6027b748
> 	0x6027b748 <stdout@@GLIBC_2.2.5>:       0x0     0x0
> 	0x6027b758 <completed.6111+8>:  0x0     0x0
> 
> So, with stdout@@GLIBC_2.2.5 at 0x6027b748 and completed.6111 at
> 0x6027b750 - right next to each other - there would seem to be nothing
> between them to reference anything.

gdb says 0x6027b758 for <completed.6111>, not 0x6027b750 as you
wrote, so there's 8 more bytes for gunk there.  ;)
Anyway, since I can't build UML, I'm willing to look at the
file if you can put it on a web page along with its System.map file.


> In any case, with bss containing zero-initialized stuff, I don't see
> how anything here can refer to anything anywhere else.
> 
> > With the above patch we are down to two section mismatch warnings for
> > a defconfig build on x86_64.
> 
> I see one (the one quoted above).  Thanks for adding .plt - that made
> the build much more pleasant.


---
~Randy
