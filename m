Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130079AbRBKUjc>; Sun, 11 Feb 2001 15:39:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130285AbRBKUjW>; Sun, 11 Feb 2001 15:39:22 -0500
Received: from colorfullife.com ([216.156.138.34]:23047 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S130152AbRBKUjK>;
	Sun, 11 Feb 2001 15:39:10 -0500
Message-ID: <3A86F86E.524778E2@colorfullife.com>
Date: Sun, 11 Feb 2001 21:39:10 +0100
From: Manfred Spraul <manfred@colorfullife.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.1 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: David Weinehall <tao@acc.umu.se>, Jeff Garzik <jgarzik@mandrakesoft.com>,
        Nick Urbanik <nicku@vtc.edu.hk>,
        Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.2-pre3 compile error in 6pack.c
In-Reply-To: <E14S38k-0004wM-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> > > Would it be costly/reasonable to have kmalloc -not- panic if given a
> > > too-large size?  Principle of Least Surprises says it should return NULL
> > > at the very least.
> >
> > It's on purpose; to find the erroneous drivers.
> 
> Unfortunately Linus forgot to provide a way to check if a kmalloc is too
> large so the drivers cannot work around it. Dave put an incredibly ugly
> constant assumption in af_unix for this and no doubt more will follow.
> 
> So -ac added the constant
>
What about removing the BUG?

I means all drivers should be aware that kmalloc() > 16 kB fail quite
often.
kmalloc() over 128 kB always fail.

Do you really prefer if drivers contain a 

static inline void* safe_kmalloc(size, flags)
{
	if(size > LIMIT)
		return NULL;
	return kmalloc(size, flags);
}

--
	Manfred
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
