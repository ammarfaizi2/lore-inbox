Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129477AbQLRUMi>; Mon, 18 Dec 2000 15:12:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129604AbQLRUM3>; Mon, 18 Dec 2000 15:12:29 -0500
Received: from ferret.phonewave.net ([208.138.51.183]:28173 "EHLO
	tarot.mentasm.org") by vger.kernel.org with ESMTP
	id <S129477AbQLRUMQ>; Mon, 18 Dec 2000 15:12:16 -0500
Date: Mon, 18 Dec 2000 11:34:44 -0800 (PST)
From: ferret@phonewave.net
To: Heiko.Carstens@de.ibm.com
cc: Pavel Machek <pavel@suse.cz>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        linux-kernel@vger.kernel.org
Subject: Re: CPU attachent and detachment in a running Linux system
In-Reply-To: <C12569B9.002C03CF.00@d12mta01.de.ibm.com>
Message-ID: <Pine.LNX.3.96.1001218113403.3555B-100000@tarot.mentasm.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 18 Dec 2000 Heiko.Carstens@de.ibm.com wrote:

> Hi,
> 
> >> I still wonder what you and other people think about the idea of an
> >> interface where the parts of the kernel with per-cpu dependencies should
> >> register two functions...
> >Why not compile kernel with structeres big enough for 32 processors,
> >and then just add CPUs up to the limit without changing anything?
> 
> That's a good point and it would probably work for attachment of cpus, but
> it won't work for detachment because there are some data structures that
> need to be updated if a cpu gets detached. For example it would be nice
> to flush the per-cpu cache of the detached cpu in the slabcache. Then one
> has to think of pending tasklets for the detached cpu which should be
> moved to another cpu and then there are a lot of per-cpu data structures
> in the networking part of the kernel.. most of them seem to be for
> statistics only but I think these structures should be updated in any
> case.
> So at least for detaching it would make sense to register functions which
> will be called whenever a cpu gets detached.


Plus userspace CPU monitors will need to know when the CPU arrangement has
changed.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
