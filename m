Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277048AbRJEAfz>; Thu, 4 Oct 2001 20:35:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277283AbRJEAfq>; Thu, 4 Oct 2001 20:35:46 -0400
Received: from [209.237.5.66] ([209.237.5.66]:63194 "EHLO clyde.stargateip.com")
	by vger.kernel.org with ESMTP id <S277048AbRJEAfe>;
	Thu, 4 Oct 2001 20:35:34 -0400
From: "Ian Thompson" <ithompso@stargateip.com>
To: <root@chaos.analogic.com>
Cc: "Helge Hafting" <helgehaf@idb.hist.no>, <linux-kernel@vger.kernel.org>
Subject: RE: How can I jump to non-linux address space?
Date: Thu, 4 Oct 2001 17:35:51 -0700
Message-ID: <NFBBIBIEHMPDJNKCIKOBGEIOCAAA.ithompso@stargateip.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
In-Reply-To: <Pine.LNX.3.95.1011004155938.1774A-100000@chaos.analogic.com>
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Dick,

Thanks for the help!  A couple more questions for you...

> You use ioremap() to create a virtual address from 0x1000. Then
> you copy the relocated code, currently in some array, to the relocated
> address (0x1000), using the cookie returned from ioremap().

How does this make the virtual address the same as the physical address?  Or
are addr's in the first page (or 1st MB?) automatically mapped to the same
address when you call ioremap()?  I printed out the __ioremap() addr's for
0x1000 and 0x3000, and neither of the virt addr's were equal to the physical
ones.

I tried something slightly different, which didn't work...  Should it have?
What I did was put the code to turn off the MMU at physical address 0x3000,
and jumped to it (via branching to __ioremap(0x3000)).  I think the branch
is working, since I can load the correct instruction via this reloc'ed
address.  However, running the code that turns off the MMU instead reboots
the machine. =(

> In the code, you can disable the paging bit and set DS, ES to the
> page-table selector, which looks at linear addressing. Now you can
> see and access everything as 32-bit linear address-space.

Should I be looking for something else to twiddle instead of the MMU bit in
the CPU register?  You mentioned the paging bit; is this different?  Also,
what are DS & ES?

gracias,
-ian

