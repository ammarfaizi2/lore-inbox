Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129091AbQKWUZi>; Thu, 23 Nov 2000 15:25:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129586AbQKWUZ3>; Thu, 23 Nov 2000 15:25:29 -0500
Received: from Cantor.suse.de ([194.112.123.193]:12563 "HELO Cantor.suse.de")
        by vger.kernel.org with SMTP id <S129091AbQKWUY5>;
        Thu, 23 Nov 2000 15:24:57 -0500
Date: Thu, 23 Nov 2000 20:54:54 +0100
From: Andi Kleen <ak@suse.de>
To: Tigran Aivazian <tigran@aivazian.fsnet.co.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: alloc_tty_struct() question.
Message-ID: <20001123205454.A26886@gruyere.muc.suse.de>
In-Reply-To: <Pine.LNX.4.21.0011231852590.2128-100000@penguin.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.21.0011231852590.2128-100000@penguin.homenet>; from tigran@aivazian.fsnet.co.uk on Thu, Nov 23, 2000 at 06:54:48PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 23, 2000 at 06:54:48PM +0000, Tigran Aivazian wrote:
> Hi,
> 
> The sizeof(struct tty_struct) = 3084. Why don't we have a private slab
> cache for it instead of getting a page and wasting some precious bytes at
> the end? Potentially, we can have thousands of tty_struct allocated
> (assuming we have thousands of concurrent users)...

A slab cache could only save significant memory if it allocated in 
order 2 slabs (order 1 would waste exactly the same memory because 
you only had a ~2K gap) Order 2 is nasty and unreliable.


-Andi
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
