Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131027AbQLRIhp>; Mon, 18 Dec 2000 03:37:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131034AbQLRIhf>; Mon, 18 Dec 2000 03:37:35 -0500
Received: from d12lmsgate-3.de.ibm.com ([195.212.91.201]:21465 "EHLO
	d12lmsgate-3.de.ibm.com") by vger.kernel.org with ESMTP
	id <S131027AbQLRIh1>; Mon, 18 Dec 2000 03:37:27 -0500
From: Heiko.Carstens@de.ibm.com
X-Lotus-FromDomain: IBMDE
To: Pavel Machek <pavel@suse.cz>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Message-ID: <C12569B9.002C03CF.00@d12mta01.de.ibm.com>
Date: Mon, 18 Dec 2000 09:00:43 +0100
Subject: Re: CPU attachent and detachment in a running Linux system
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org





Hi,

>> I still wonder what you and other people think about the idea of an
>> interface where the parts of the kernel with per-cpu dependencies should
>> register two functions...
>Why not compile kernel with structeres big enough for 32 processors,
>and then just add CPUs up to the limit without changing anything?

That's a good point and it would probably work for attachment of cpus, but
it won't work for detachment because there are some data structures that
need to be updated if a cpu gets detached. For example it would be nice
to flush the per-cpu cache of the detached cpu in the slabcache. Then one
has to think of pending tasklets for the detached cpu which should be
moved to another cpu and then there are a lot of per-cpu data structures
in the networking part of the kernel.. most of them seem to be for
statistics only but I think these structures should be updated in any
case.
So at least for detaching it would make sense to register functions which
will be called whenever a cpu gets detached.

Heiko


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
