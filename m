Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268588AbUJKArP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268588AbUJKArP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Oct 2004 20:47:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268589AbUJKArP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Oct 2004 20:47:15 -0400
Received: from fw.osdl.org ([65.172.181.6]:18079 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268588AbUJKArL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Oct 2004 20:47:11 -0400
Date: Sun, 10 Oct 2004 17:47:05 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: "Maciej W. Rozycki" <macro@linux-mips.org>
cc: Len Brown <len.brown@intel.com>, Andrew Morton <akpm@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ACPI Developers <acpi-devel@lists.sourceforge.net>
Subject: Re: [BKPATCH] LAPIC fix for 2.6
In-Reply-To: <Pine.LNX.4.58L.0410102000160.4217@blysk.ds.pg.gda.pl>
Message-ID: <Pine.LNX.4.58.0410101744110.3897@ppc970.osdl.org>
References: <1097429707.30734.21.camel@d845pe> <Pine.LNX.4.58.0410101044200.3897@ppc970.osdl.org>
 <Pine.LNX.4.58L.0410102000160.4217@blysk.ds.pg.gda.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 10 Oct 2004, Maciej W. Rozycki wrote:
> 
>  Hmm, any particular reason to keep the local APIC disabled by default?  

Yes. It changes interrupt handling, so any SMM stuff tends to break on
BIOSes that don't know about APICs. Things like the magic keys etc. It
apparently also breaks some ACPI stuff (likely AML code that "knows" that
interrupts are done with the legacy controller).

Mostly a laptop issue, I suspect - simply because desktops don't do 
anything strange these days.

So the default is the "safe" settings. And if you care, and your machine
works with the APIC, the command line thing is available.

		Linus
