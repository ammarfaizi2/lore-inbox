Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317214AbSHBBZ0>; Thu, 1 Aug 2002 21:25:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317287AbSHBBZ0>; Thu, 1 Aug 2002 21:25:26 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:17419 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S317214AbSHBBZ0>;
	Thu, 1 Aug 2002 21:25:26 -0400
Message-ID: <3D49DFD0.FE0DBC1D@zip.com.au>
Date: Thu, 01 Aug 2002 18:26:40 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: linux-kernel@vger.kernel.org, linux-mm@kvack.org, rohit.seth@intel.com,
       sunil.saxena@intel.com, asit.k.mallick@intel.com
Subject: Re: large page patch
References: <3D49D45A.D68CCFB4@zip.com.au> <20020801.174301.123634127.davem@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David S. Miller" wrote:
> 
>    From: Andrew Morton <akpm@zip.com.au>
>    Date: Thu, 01 Aug 2002 17:37:46 -0700
> 
>    Some observations which have been made thus far:
> 
>    - Minimal impact on the VM and MM layers
> 
> Well the downside of this is that it means it isn't transparent
> to userspace.  For example, specfp2000 results aren't going to
> improve after installing these changes.  Some of the other large
> page implementations would.
> 
>    - The change to MAX_ORDER is unneeded
> 
> This is probably done to increase the likelyhood that 4MB page orders
> are available.  If we collapse 4MB pages deeper, they are less likely
> to be broken up because smaller orders would be selected first.

This is leakage from ia64, which supports up to 256k pages.

> Maybe it doesn't make a difference....
> 
>    - swapping of large pages and making them pagecache-coherent is
>      unpopular.
> 
> Swapping them is easy, any time you hit a large PTE you unlarge it.
> This is what some of other large page implementations do.  Basically
> the implementation is that set_pte() breaks apart large ptes when
> necessary.

As far as mm/*.c is concerned, there is no pte.  It's just a vma
which is marked "don't touch"  These pages aren't on the LRU, nothing
knows about them.

Apparently a page-table based representation could not be used by PPC.
