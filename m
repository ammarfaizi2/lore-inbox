Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287609AbRLaTc3>; Mon, 31 Dec 2001 14:32:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287610AbRLaTcT>; Mon, 31 Dec 2001 14:32:19 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:31761 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S287609AbRLaTcO>; Mon, 31 Dec 2001 14:32:14 -0500
Message-ID: <3C30BC5F.227349E8@zip.com.au>
Date: Mon, 31 Dec 2001 11:28:31 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.17-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Manfred Spraul <manfred@colorfullife.com>
CC: Dave Jones <davej@suse.de>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] Prefetching file_read_actor()
In-Reply-To: <20011231033220.A1686@suse.de> <3C2FFB2F.D02095A2@zip.com.au> <3C3044D3.EBEF6657@colorfullife.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Manfred Spraul wrote:
> 
> BUT: Prefetch doesn't preload the TLB. If the TLB entry for the kmap is
> not in the TLB, all prefetch instructions are treated as nops.(on pIII).

umm..  That will be the case practically 100% of the time in this
application, won't it?

Looks like you'll need to do a __get_user() against the page to
populate the tlb.  We're going to need it in the copy_to_user()
anyway, so the cost is negligible.


-
