Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287478AbRLaK7A>; Mon, 31 Dec 2001 05:59:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287486AbRLaK6t>; Mon, 31 Dec 2001 05:58:49 -0500
Received: from colorfullife.com ([216.156.138.34]:2321 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S287478AbRLaK6c>;
	Mon, 31 Dec 2001 05:58:32 -0500
Message-ID: <3C3044D3.EBEF6657@colorfullife.com>
Date: Mon, 31 Dec 2001 11:58:27 +0100
From: Manfred Spraul <manfred@colorfullife.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.5.1-dj6 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Andrew Morton <akpm@zip.com.au>
CC: Dave Jones <davej@suse.de>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] Prefetching file_read_actor()
In-Reply-To: <20011231033220.A1686@suse.de> <3C2FFB2F.D02095A2@zip.com.au>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> 
> 
> Is prefetching 4k at a time optimal?  Should the prefetch be embedded
> in copy_*_user?
>
For the Pentium III, that's the Intel recommended sequence.

> 
> The code makes no attempt to align the prefetch address to anything.
> Should it?

Not needed.

> What happens if a prefetch spills over the end of the page and
> faults?
>
Doesn't hurt, prefetch instruction never cause page faults.
BUT: Prefetch doesn't preload the TLB. If the TLB entry for the kmap is
not in the TLB, all prefetch instructions are treated as nops.(on pIII).

--
	Manfred
