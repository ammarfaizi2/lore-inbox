Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130164AbQLUDyY>; Wed, 20 Dec 2000 22:54:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130205AbQLUDyO>; Wed, 20 Dec 2000 22:54:14 -0500
Received: from linuxcare.com.au ([203.29.91.49]:11012 "EHLO
	front.linuxcare.com.au") by vger.kernel.org with ESMTP
	id <S130164AbQLUDx4>; Wed, 20 Dec 2000 22:53:56 -0500
From: Anton Blanchard <anton@linuxcare.com.au>
Date: Thu, 21 Dec 2000 14:21:35 +1100
To: Heiko.Carstens@de.ibm.com
Cc: Pavel Machek <pavel@suse.cz>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        linux-kernel@vger.kernel.org
Subject: Re: CPU attachent and detachment in a running Linux system
Message-ID: <20001221142135.G6183@linuxcare.com>
In-Reply-To: <C12569B9.002C03CF.00@d12mta01.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <C12569B9.002C03CF.00@d12mta01.de.ibm.com>; from Heiko.Carstens@de.ibm.com on Mon, Dec 18, 2000 at 09:00:43AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
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

I remember someone from SGI had a patch to merge all the per cpu structures
together which would make this easier. It would also save bytes especially
on machines like the e10k where we must have NR_CPUS = 64.

Anton
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
