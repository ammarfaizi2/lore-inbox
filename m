Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261684AbTJ2VZg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Oct 2003 16:25:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261699AbTJ2VZg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Oct 2003 16:25:36 -0500
Received: from ns.suse.de ([195.135.220.2]:19842 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261684AbTJ2VZe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Oct 2003 16:25:34 -0500
Date: Wed, 29 Oct 2003 22:24:54 +0100
From: Andi Kleen <ak@suse.de>
To: George Anzinger <george@mvista.com>
Cc: jim.houston@ccur.com, linux-kernel@vger.kernel.org
Subject: Re: Is there a kgdb for Opteron for linux-2.6?
Message-Id: <20031029222454.7ec07a9e.ak@suse.de>
In-Reply-To: <3FA02DCF.4080906@mvista.com>
References: <1066678923.1007.164.camel@new.localdomain>
	<20031024135112.GE2286@wotan.suse.de>
	<3F9EF206.1040105@mvista.com>
	<20031029002517.47d8f329.ak@suse.de>
	<3FA02DCF.4080906@mvista.com>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Oct 2003 13:14:55 -0800
George Anzinger <george@mvista.com> wrote:

> Andi Kleen wrote:
> > On Tue, 28 Oct 2003 14:47:34 -0800
> > George Anzinger <george@mvista.com> wrote:
> > 
> > 
> > 
> >>I see that Andrew has not picked up my latest kgdb.  In the latest version I 
> >>have the dwarf2 stuff working in entry.S.  Just ask, off list.
> > 
> > 
> > Do you use the .cfi* mnemonics in newer binutils? Without that it would get ugly.
> 
> I use asm mnemonics .uleb*, .sleb*, .byte and .long.  For operands I use the 
> defines in dwarf2.h (after fixing them to work with asm).  These are, for the 
> most part DW_CFA_* and other DW_* things.  I put this together to build macros 
> (CCP) so that I can code things like:

The latest binutils has new .cfi_* mnemonics in gas that make writing such a table
much cleaner and easier. My plan was to use that. It would require new binutils,
but make future mainteance much easier. When people don't have the new binutils
it can be defined away.

See http://www.logix.cz/~mic/devel/gas-cfi/

> 
> Which allows "bt" through entry.S code.  I did not try to allow you to get the 
> correct answer if you stop in the middle of the register save or restore code.

On x86-64 it is unfortunately more complicated because it has a separate interrupt
or exception stack. The backtracker has to read the old stack pointer from the 
frame. This can be expressed in dwarf2, but is a bit tricky.

-Andi


