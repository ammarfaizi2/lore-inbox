Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318756AbSHBIaS>; Fri, 2 Aug 2002 04:30:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318757AbSHBIaS>; Fri, 2 Aug 2002 04:30:18 -0400
Received: from pizda.ninka.net ([216.101.162.242]:39586 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S318756AbSHBIaR>;
	Fri, 2 Aug 2002 04:30:17 -0400
Date: Fri, 02 Aug 2002 01:20:40 -0700 (PDT)
Message-Id: <20020802.012040.105531210.davem@redhat.com>
To: davidm@hpl.hp.com, davidm@napali.hpl.hp.com
Cc: gh@us.ibm.com, riel@conectiva.com.br, akpm@zip.com.au,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org, rohit.seth@intel.com,
       sunil.saxena@intel.com, asit.k.mallick@intel.com
Subject: Re: large page patch 
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <15690.9727.831144.67179@napali.hpl.hp.com>
References: <15690.6005.624237.902152@napali.hpl.hp.com>
	<20020801.222053.20302294.davem@redhat.com>
	<15690.9727.831144.67179@napali.hpl.hp.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: David Mosberger <davidm@napali.hpl.hp.com>
   Date: Thu, 1 Aug 2002 23:26:07 -0700
   
   I'm a bit concerned about this, too.  My preference would have been to
   use the regular mmap() and shmat() syscalls with some
   augmentation/hint as to what the preferred page size is (Simon
   Winwood's OLS 2002 paper talks about some options here).  I like this
   because hints could be useful even with a transparent superpage
   scheme.

A "hint" to use superpages?  That's absurd.

Any time you are able to translate N pages instead of 1 page with 1
TLB entry it's always preferable.

I also don't buy the swapping complexity bit.  The fact is, SHM and
anonymous pages are easy.  Just stay away from the page cache and it
is pretty simple to just make the normal VM do this.

If set_pte sees a large page, you simply undo the large ptes in that
group and the complexity ends right there.  This means the only maker
of large pages is the bit that creates the large mappings and has all
of the ideal conditions up front.  Any time anything happens to that
pte you undo the large'ness of it so that you get normal PAGE_SIZE
ptes back.

Using superpages for anonymous+SHM pages is really the only area I
still think Linux's MM can offer inferior performance compared to what
the hardware is actually capable of.
