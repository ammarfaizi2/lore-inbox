Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130016AbRBYK2n>; Sun, 25 Feb 2001 05:28:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130020AbRBYK2d>; Sun, 25 Feb 2001 05:28:33 -0500
Received: from ns.suse.de ([213.95.15.193]:34320 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S130016AbRBYK2S>;
	Sun, 25 Feb 2001 05:28:18 -0500
To: Chris Wedgwood <cw@f00f.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Core dumps for threads
In-Reply-To: <20010224134523.O26109@valinux.com> <E14WmhG-0000Yj-00@the-village.bc.nu> <20010225221505.A12595@metastasis.f00f.org>
From: Andi Kleen <ak@suse.de>
Date: 25 Feb 2001 11:28:14 +0100
In-Reply-To: Chris Wedgwood's message of "25 Feb 2001 10:16:13 +0100"
Message-ID: <oupk86fjbup.fsf@pigdrop.muc.suse.de>
User-Agent: Gnus/5.0803 (Gnus v5.8.3) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wedgwood <cw@f00f.org> writes:

> On Sat, Feb 24, 2001 at 09:57:44PM +0000, Alan Cox wrote:
> 
>     The I/O to dump the core would race other changes on the mm. The
>     right fix is probably to copy the mm (as fork does) then dump the
>     copy.
> 
> Stupid question... but since all threads see the same memory space as
> each other; can we not lock the entire vma for the process whilst
> it's being written out?


It would need a recursive mm semaphore -- core dumps can page fault and page 
faults take the semaphore again. Other alternative is to copy the MM like
fork before dumping, but then core dumping could fail much quicker when you 
ran out of memory.


-Andi

