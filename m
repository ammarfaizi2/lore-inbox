Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271276AbRIDPCw>; Tue, 4 Sep 2001 11:02:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269796AbRIDPCl>; Tue, 4 Sep 2001 11:02:41 -0400
Received: from chaos.analogic.com ([204.178.40.224]:38018 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S269756AbRIDPCg>; Tue, 4 Sep 2001 11:02:36 -0400
Date: Tue, 4 Sep 2001 11:02:43 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Ulrich Weigand <Ulrich.Weigand@de.ibm.com>
cc: Jeff Mahoney <jeffm@suse.com>, Andi Kleen <ak@suse.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [SOLVED + PATCH]: documented Oops running big-endian reiserfs on parisc architecture
In-Reply-To: <OF263FB8E3.75D4DAB3-ONC1256ABD.004F349C@de.ibm.com>
Message-ID: <Pine.LNX.3.95.1010904105643.22082A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Sep 2001, Ulrich Weigand wrote:
[SNIPPED...]

> 
> If these instructions really *need* to be atomic, then reiserfs should
> ensure they are performed on properly aligned data, or else there might
> be subtle bugs even on Intel, because the operations will not actually
> be atomic (even though they don't trap).
>

Regardless of alignment, locked instructions in Intel machines are
atomic. Any "hidden" read/modify/write operations are performed
by the hardware, under the lock, preventing access by any other
CPUs or DMA.
 
> If you say that reiserfs doesn't really need these operations to be
> atomic because they run under other locks anyway, then they should not
> be using atomic operations in the first place; this will only cause
> unnecessary slowdown even on Intel.
> 

Agreed that there are many "atomic_t" types on some drivers, and
"atomic" operations that don't need to be there. Unless a DMA operation
is in progress, anything executing under a spin-lock doesn't need
to be an "atomic" operation to make it, truly, atomic.

Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

    I was going to compile a list of innovations that could be
    attributed to Microsoft. Once I realized that Ctrl-Alt-Del
    was handled in the BIOS, I found that there aren't any.


