Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261761AbSJCRNY>; Thu, 3 Oct 2002 13:13:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261763AbSJCRNY>; Thu, 3 Oct 2002 13:13:24 -0400
Received: from pizda.ninka.net ([216.101.162.242]:17364 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S261761AbSJCRNW>;
	Thu, 3 Oct 2002 13:13:22 -0400
Date: Thu, 03 Oct 2002 10:11:37 -0700 (PDT)
Message-Id: <20021003.101137.56158798.davem@redhat.com>
To: zaitcev@redhat.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: virt_to_page(pci_alloc_consistent())
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20021003122509.B8147@devserv.devel.redhat.com>
References: <20021003023814.A5856@devserv.devel.redhat.com>
	<20021003.010344.123986131.davem@redhat.com>
	<20021003122509.B8147@devserv.devel.redhat.com>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Pete Zaitcev <zaitcev@redhat.com>
   Date: Thu, 3 Oct 2002 12:25:10 -0400

   > Date: Thu, 03 Oct 2002 01:03:44 -0700 (PDT)
   > From: "David S. Miller" <davem@redhat.com>
   
   > I think we MUST allow architectures to do what SPARC and ARM
   > do, there is simply no other way to change the page protections
   > easily for these kinds of systems.
   
   I can fix sparc, dunno about others. Do you have a problem
   on sparc64? Are you using a huge page to map the kernel?

ARM I believe does not have luxury you have.

See, some processors are like MIPS and something sort of
KSEG0 is used for PAGE_OFFSET mapping of physical pages.
So pages with page protections changes must live in some other
area of the kernel address space just like vmalloc() to get
the different protection bits.

I really would like sun4m to use big pages for the PAGE_OFFSET
mappings when possible Peter.  So I even don't think fixing Sparc
the way I know you are likely to is wise.

