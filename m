Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266611AbRGEC1B>; Wed, 4 Jul 2001 22:27:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266612AbRGEC0u>; Wed, 4 Jul 2001 22:26:50 -0400
Received: from [210.77.38.126] ([210.77.38.126]:23304 "EHLO
	ns.turbolinux.com.cn") by vger.kernel.org with ESMTP
	id <S266611AbRGEC0p>; Wed, 4 Jul 2001 22:26:45 -0400
Date: Thu, 5 Jul 2001 10:28:35 +0800
From: michaelc <michaelc@turbolinux.com.cn>
X-Mailer: The Bat! (v1.49) UNREG / CD5BF9353B3B7091
Reply-To: michaelc <michaelc@turbolinux.com.cn>
X-Priority: 3 (Normal)
Message-ID: <1224736781.20010705102835@turbolinux.com.cn>
To: "Stephen C. Tweedie" <sct@redhat.com>
CC: linux-kernel@vger.kernel.org
Subject: Re[2]: about kmap_high function
In-Reply-To: <20010703103809.A29868@redhat.com>
In-Reply-To: <3620762046.20010629150601@turbolinux.com.cn>
 <20010703103809.A29868@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

  Tuesday, July 03, 2001, 5:38:09 PM, you wrote:

SCT> kmap_high is intended to be called routinely for access to highmem
SCT> pages.  It is coded to be as fast as possible as a result.  TLB
SCT> flushes are expensive, especially on SMP, so kmap_high tries hard to
SCT> avoid unnecessary flushes.

SCT> The way it does it is to do only a single, complete TLB flush of the
SCT> whole kmap VA range once every time the kmap address ring cycles.
SCT> That's what flush_all_zero_pkmaps() does --- it evicts old, unused
SCT> kmap mappings and flushes the whole TLB range, so that we are
SCT> guaranteed that there is a TLB flush between any two different uses of
SCT> any given kmap virtual address.

SCT> That way, we can avoid the cost of having to flush the TLB for every
SCT> single kmap mapping we create.

       Thank you very much for your kindly guide, and I have two question to ask
   you, One question is, Is kmap_high intended to be called merely in the user
   context, so the  highmem pages are mapped into user process page table, so
   on SMP, other processes ( including kernel and user process) that running
   on another cpu doesn't need to get that kmap virtual address.
      Another question is, when kernel evicts old, unused kmap  mapping and
   flushes the whole TLB range( call the flush_all_zero_pkmaps), the TLB won't
   keep those zero  mappings, after that, when user process call kmap_high to
   get a new kmap mappings, and when the process access that virtual
   address, MMU component will get the page directory and page table from MEMORY
   instead of TLB to translate the virtual address into physical  address.
   
--
Best regards,
 Michael Chen                            mailto:michaelc@turbolinux.com.cn


