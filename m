Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262580AbVDGXym@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262580AbVDGXym (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Apr 2005 19:54:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262592AbVDGXym
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Apr 2005 19:54:42 -0400
Received: from smtpout.mac.com ([17.250.248.44]:35027 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S262580AbVDGXyj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Apr 2005 19:54:39 -0400
In-Reply-To: <42540560.2000205@grupopie.com>
References: <4252BC37.8030306@grupopie.com> <Pine.LNX.4.62.0504052052230.2444@dragon.hyggekrogen.localhost> <521x9pc9o6.fsf@topspin.com> <Pine.LNX.4.62.0504052148480.2444@dragon.hyggekrogen.localhost> <20050406112837.GC7031@wohnheim.fh-wedel.de> <4253D2CD.2040600@grupopie.com> <84144f02050406061077de4c2e@mail.gmail.com> <42540560.2000205@grupopie.com>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <360495f04d557922068b477d7e149778@mac.com>
Content-Transfer-Encoding: 7bit
Cc: Pekka Enberg <penberg@gmail.com>, Roland Dreier <roland@topspin.com>,
       =?ISO-8859-1?Q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>,
       LKML <linux-kernel@vger.kernel.org>, penberg@cs.helsinki.fi,
       Jesper Juhl <juhl-lkml@dif.dk>
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: RFC: turn kmalloc+memset(,0,) into kcalloc
Date: Thu, 7 Apr 2005 19:54:17 -0400
To: Paulo Marques <pmarques@grupopie.com>
X-Mailer: Apple Mail (2.619.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Apr 06, 2005, at 11:50, Paulo Marques wrote:
> kzalloc it is, then.
>
> [...]
>
> So we gain 8kB on the uncompressed image and 1347 bytes on the 
> compressed one. This was just a dumb test and actual results might be 
> better due to smarter human cleanups.
>
> Not a spectacular gain per se, but the increase in code readability is 
> still worth it, IMHO.

Perhaps this could eventually be modified to draw from a prezeroed 
block of
memory, similar to the current code for doing the same thing for 
userspace.
It probably wouldn't give much performance gain, especially since it's 
not
used for large blocks or large numbers of small objects (As you would 
use a
slabcache for those), but it might help a bit.  Of course, the code 
would
need to fall back quickly if such an allocation would be messy or 
expensive
for any reason.

Cheers,
Kyle Moffett

-----BEGIN GEEK CODE BLOCK-----
Version: 3.12
GCM/CS/IT/U d- s++: a18 C++++>$ UB/L/X/*++++(+)>$ P+++(++++)>$
L++++(+++) E W++(+) N+++(++) o? K? w--- O? M++ V? PS+() PE+(-) Y+
PGP+++ t+(+++) 5 X R? tv-(--) b++++(++) DI+ D+ G e->++++$ h!*()>++$ r  
!y?(-)
------END GEEK CODE BLOCK------


