Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316828AbSFDViF>; Tue, 4 Jun 2002 17:38:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316835AbSFDViE>; Tue, 4 Jun 2002 17:38:04 -0400
Received: from pizda.ninka.net ([216.101.162.242]:53633 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S316828AbSFDViB>;
	Tue, 4 Jun 2002 17:38:01 -0400
Date: Tue, 04 Jun 2002 14:34:53 -0700 (PDT)
Message-Id: <20020604.143453.35012407.davem@redhat.com>
To: mochel@osdl.org
Cc: anton@samba.org, linux-kernel@vger.kernel.org
Subject: Re: [2.5.19] Oops during PCI scan on Alpha
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.LNX.4.33.0206041427260.654-100000@geena.pdx.osdl.net>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Patrick Mochel <mochel@osdl.org>
   Date: Tue, 4 Jun 2002 14:29:21 -0700 (PDT)

   
   On Tue, 4 Jun 2002, David S. Miller wrote:
   
   > Linkers are allowed to reorder object files unless you tell them
   > explicitly not to.
   > 
   > This is why you need to put this stuff into a seperate initcall level.
   > This is precisely why I suggest postcore_initcall as the fix.
   
   Ok, how about just keeping it a subsys_initcall, like it was in the first 
   place? 

Then there are ordering problems with subsys_initcalls which want to
add devices to sys_bus.  In fact, arch_initcalls are the places where
most of the actual uses of subsys_bus registry.

So for the ump-teenth time, you need to init this thing EXACTLY after
core_initcalls.  I can only say this so many times, this is the
initcall classification we need to fix this bug, "POST CORE INITCALL"
and "BEFORE ANYTHING ELSE".

One way to do that, for the ump-teenth time, is to rename
unused_initcall to postcore_initcall and use that new initcall
to fix the pci_bus and sys_bus generic bus initialization ordering
problems.

We're talking in circles and the fixes you're proposing are not
going to fix the bug, just create new versions of the old bug.
