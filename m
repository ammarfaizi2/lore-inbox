Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129928AbQKESrq>; Sun, 5 Nov 2000 13:47:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129822AbQKESrg>; Sun, 5 Nov 2000 13:47:36 -0500
Received: from smtpde02.sap-ag.de ([194.39.131.53]:24803 "EHLO
	smtpde02.sap-ag.de") by vger.kernel.org with ESMTP
	id <S129928AbQKESr0>; Sun, 5 Nov 2000 13:47:26 -0500
To: Rik van Riel <riel@conectiva.com.br>
Cc: Jonathan George <Jonathan.George@trcinc.com>,
        "'matthew@mattshouse.com'" <matthew@mattshouse.com>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.0-test10 Sluggish After Load
In-Reply-To: <Pine.LNX.4.05.10011051433540.9109-100000@humbolt.nl.linux.org>
From: Christoph Rohland <cr@sap.com>
Date: 05 Nov 2000 19:49:50 +0100
Message-ID: <m3ofzufe41.fsf@linux.local>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (Capitol Reef)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rik,

Rik van Riel <riel@conectiva.com.br> writes:
> On 4 Nov 2000, Christoph Rohland wrote:
> > I do see two problems here:
> > 1) shm_swap_core does not handle the failure of prepare_higmem_swapout
> >    right and basically cannot do so. It gets called zone independant
> >    and should probably get called per zone. At least it has to react:
> 
> AFAIC try_to_swap_out can handle this situation fine, it
> shouldn't be very difficult to get shm_swap to handle it
> too...

No I do not think that try_to_swap_out does handle this. It also
simply fails on this. I have seen lockups after try_to_swap_out
failing on prepare_higmem_swapout.

> > You see: you only have 5+27+27=59 pages under your control...
> 
> Ughhhh. Maybe we need some rebalancing there as well.
> That's a maximum of 5 pages of executable text mapped
> into all processes...

Yes, that's reasonable in my test case...

Greetings
                Christoph

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
