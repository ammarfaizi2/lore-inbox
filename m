Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750867AbVHVUOb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750867AbVHVUOb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Aug 2005 16:14:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750863AbVHVUOb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Aug 2005 16:14:31 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:54751 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1750813AbVHVUOa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Aug 2005 16:14:30 -0400
Date: Mon, 22 Aug 2005 10:44:15 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Rolf Eike Beer <eike-kernel@sf-tec.de>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Helge Hafting <helge.hafting@aitel.hist.no>,
       Dave Airlie <airlied@gmail.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Michael Ellerman <michael@ellerman.id.au>,
       Greg Kroah-Hartman <gregkh@suse.de>, Andrew Morton <akpm@osdl.org>
Subject: Re: rc5 seemed to kill a disk that rc4-mm1 likes. Also some X trouble.
In-Reply-To: <200508221001.39050@bilbo.math.uni-mannheim.de>
Message-ID: <Pine.LNX.4.58.0508221034090.3317@g5.osdl.org>
References: <Pine.LNX.4.58.0508012201010.3341@g5.osdl.org> <42F89F79.1060103@aitel.hist.no>
 <200508171326.21948@bilbo.math.uni-mannheim.de> <200508221001.39050@bilbo.math.uni-mannheim.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 22 Aug 2005, Rolf Eike Beer wrote:

> >It's a PII-350 with more or less SuSE 9.3. The machine has no net access, so
> > I can only try to narrow it down to one rc at the weekend.
> 
> 2.6.12 works fine, everything since 2.6.13-rc1 breaks it.

Gaah. I don't see anything really obvious in that range. However, I notice
that pci_mmap_resource() (in drivers/pci/pci-sysfs.c) now has

+       if (i >= PCI_ROM_RESOURCE)
+               return -ENODEV;

which seems a big bogus. Why wouldn't we allow the ROM resource to be 
mapped? I could imagine that the X server would very much like to mmap it, 
although I don't know if modern X actually does that. The fact that it 
works when root runs the X server and causes problems for normal users 
does seem like there's something that root can do that users can't do, and 
doing a mmap() on /dev/mem might be just that.

Eike, maybe you could change the ">=" to just ">" instead?

PS. The patch that introduced this was billed as "no change for anything 
but ppc". Tssk.

		Linus
