Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317371AbSHBAvb>; Thu, 1 Aug 2002 20:51:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317385AbSHBAvb>; Thu, 1 Aug 2002 20:51:31 -0400
Received: from pizda.ninka.net ([216.101.162.242]:3743 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S317371AbSHBAva>;
	Thu, 1 Aug 2002 20:51:30 -0400
Date: Thu, 01 Aug 2002 17:43:01 -0700 (PDT)
Message-Id: <20020801.174301.123634127.davem@redhat.com>
To: akpm@zip.com.au
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, rohit.seth@intel.com,
       sunil.saxena@intel.com, asit.k.mallick@intel.com
Subject: Re: large page patch
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <3D49D45A.D68CCFB4@zip.com.au>
References: <3D49D45A.D68CCFB4@zip.com.au>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Andrew Morton <akpm@zip.com.au>
   Date: Thu, 01 Aug 2002 17:37:46 -0700

   Some observations which have been made thus far:
   
   - Minimal impact on the VM and MM layers
   
Well the downside of this is that it means it isn't transparent
to userspace.  For example, specfp2000 results aren't going to
improve after installing these changes.  Some of the other large
page implementations would.

   - The change to MAX_ORDER is unneeded
   
This is probably done to increase the likelyhood that 4MB page orders
are available.  If we collapse 4MB pages deeper, they are less likely
to be broken up because smaller orders would be selected first.

Maybe it doesn't make a difference....

   - swapping of large pages and making them pagecache-coherent is
     unpopular.
   
Swapping them is easy, any time you hit a large PTE you unlarge it.
This is what some of other large page implementations do.  Basically
the implementation is that set_pte() breaks apart large ptes when
necessary.

I agree on the pagecache side.

Actually to be honest the other implementations seemed less
intrusive and easier to add support for.  The downside is that
handling of weird cases like x86 using pmd's for 4MB pages
was not complete last time I checked.
