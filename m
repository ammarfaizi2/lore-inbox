Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261532AbVC2WYv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261532AbVC2WYv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 17:24:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261546AbVC2WYv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 17:24:51 -0500
Received: from smtpout.mac.com ([17.250.248.89]:19156 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S261532AbVC2WYr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 17:24:47 -0500
In-Reply-To: <4249D06F.30802@tmr.com>
References: <1111731361.20797.5.camel@uganda> <1111731361.20797.5.camel@uganda> <20050325061311.GA22959@gondor.apana.org.au> <4249D06F.30802@tmr.com>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <9801bba0783f5a8c507ff6a10a120c8d@mac.com>
Content-Transfer-Encoding: 7bit
Cc: Evgeniy Polyakov <johnpol@2ka.mipt.ru>,
       David McCullough <davidm@snapgear.com>,
       Herbert Xu <herbert@gondor.apana.org.au>,
       Jeff Garzik <jgarzik@pobox.com>, Andrew Morton <akpm@osdl.org>,
       cryptoapi@lists.logix.cz, linux-kernel@vger.kernel.org,
       linux-crypto@vger.kernel.org, James Morris <jmorris@redhat.com>
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: [PATCH] API for true Random Number Generators to add entropy (2.6.11)
Date: Tue, 29 Mar 2005 17:24:36 -0500
To: Bill Davidsen <davidsen@tmr.com>
X-Mailer: Apple Mail (2.619.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mar 29, 2005, at 17:02, Bill Davidsen wrote:
> Wait a minute, if it fails the system drops back to software,

Does it?  It would seem that if it fails and begins returning
all zeroes, then the seed function would (depending on the
implementation) be called like this:

add_random_bytes("\0\0\0\0".... , 4096);
add_random_bytes("\0\0\0\0".... , 4096);
[...]

Or:

add_random_bytes("\0\0\0\0".... , 4096);
add_random_bytes(soft_random()  , 64);
add_random_bytes("\0\0\0\0".... , 4096);
add_random_bytes(soft_random()  , 64);
[...]

In either case, it's very bad, and will likely return cause
some _very_ predictable data to be emitted.

> I'm not sure you would get people to agree what should be
> done if a hardware RNG fails, other than make the failure
> information available to user space.

How do you know if it fails?  You know when your disk fails
and begins giving bad data because the filesystem detects
that the data is invalid, but how do you tell when your
random number generator starts giving bad data? AFAIK, the
only way to do that is to continuously monitor the random
data produced and _immediately_ stop the data flow when
you start getting bad data.  That should only be done from
a userspace rngd-type daemon.

Cheers,
Kyle Moffett

-----BEGIN GEEK CODE BLOCK-----
Version: 3.12
GCM/CS/IT/U d- s++: a18 C++++>$ UB/L/X/*++++(+)>$ P+++(++++)>$
L++++(+++) E W++(+) N+++(++) o? K? w--- O? M++ V? PS+() PE+(-) Y+
PGP+++ t+(+++) 5 X R? tv-(--) b++++(++) DI+ D+ G e->++++$ h!*()>++$ r  
!y?(-)
------END GEEK CODE BLOCK------


