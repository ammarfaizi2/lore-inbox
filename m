Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267534AbRGMTxR>; Fri, 13 Jul 2001 15:53:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267535AbRGMTxJ>; Fri, 13 Jul 2001 15:53:09 -0400
Received: from mail1.qualcomm.com ([129.46.64.223]:2299 "EHLO
	mail1.qualcomm.com") by vger.kernel.org with ESMTP
	id <S267534AbRGMTxB>; Fri, 13 Jul 2001 15:53:01 -0400
Content-Type: text/plain; charset=US-ASCII
From: Maksim Krasnyanskiy <maxk@qualcomm.com>
Organization: Qualcomm
To: Joerg Reuter <jreuter@suse.de>
Subject: Re: [BUG?] vtund broken by tun driver changes in 2.4.6
Date: Fri, 13 Jul 2001 12:44:28 -0700
X-Mailer: KMail [version 1.2]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0107070058350.29490-100000@mackman.net.suse.lists.linux.kernel> <01071308585200.00792@btdemo1.qualcomm.com> <20010713194317.A18866@suse.de>
In-Reply-To: <20010713194317.A18866@suse.de>
MIME-Version: 1.0
Message-Id: <01071312442805.00792@btdemo1.qualcomm.com>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Ioctls were defined _without_ IOW macros. And that was ugly. That's why I
> > redifened them. So, if you recompile everything will be fine.
>
> So you break binary compatibilty within a _stable_ kernel release just
> for the sake of beauty ? 
I rewrote a lot of driver code to support persistent device and device ownership. So, I thought it was a right time
to clean up interface as well. API was supposed to be cleaned up before 2.4.0 final.

> Besides, this does not only affect VTUND but  also other applications like Hercules.
Yeah :(. Dave warned me about that.  I agree that it's a bad thing. Sorry about that.
I promice that there will be no API changes in 2.4.x. 
 
> Just recompiling Hercules  doesn't  help here anyway, because it (rightfully) refuses to include kernel
> headers but (due to the lack of net/if_tun.h within glibc) constructs the IOCTL command on its own.
Which imho is not a good idea.

> > > And BTW, you shouldn't include kernel headers from user space programs, should you.
> > That rule doesn't apply here.
>
> Can you tell me why it does not apply here? Just because you happen to
> be the author of both the driver (which is, without doubt, very
> valuable) and _one_ of several applications using it?
No. Just because glibc lacks a lot of if_*.h headers and if_tun.h is one of them.
Also it seems that there is no standard where if_*.h should go (include/netinet or in include/net).
On my RH 7.1 box if_ether.h is in netinet (which is imho wrong) and if_ppp.h is in net. 

Max
-- 

Maksim Krasnyanskiy      
Senior Kernel Engineer
Qualcomm Incorporated

maxk@qualcomm.com
http://bluez.sf.net
http://vtun.sf.net
