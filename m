Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132680AbRDCHlo>; Tue, 3 Apr 2001 03:41:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132673AbRDCHle>; Tue, 3 Apr 2001 03:41:34 -0400
Received: from [195.63.194.11] ([195.63.194.11]:60686 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S132680AbRDCHlb>; Tue, 3 Apr 2001 03:41:31 -0400
Message-ID: <3AC97B8C.A7D5CCCC@evision-ventures.com>
Date: Tue, 03 Apr 2001 09:28:12 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Andries.Brouwer@cwi.nl
CC: torvalds@transmeta.com, alan@lxorguk.ukuu.org.uk, hpa@transmeta.com,
        linux-kernel@vger.kernel.org, tytso@MIT.EDU
Subject: Re: Larger dev_t
In-Reply-To: <UTC200104022017.WAA89061.aeb@vlet.cwi.nl>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andries.Brouwer@cwi.nl wrote:
> 
> OK - everybody back from San Jose - pity I couldnt come -
> and it is no longer April 1st, so we can continue quarreling
> a little.
> 
> Interesting that where I had divided stuff in the trivial part,
> the interesting part and the lot-of-work part we already start
> fighting on the trivial part. Maybe it is not very important -
> still I'd prefer to do things right from the start.
> 
> Yes. We need a larger dev_t as everybody agrees.
> How large?
> 
> What is dev_t used for? It is a communication channel from
> filesystem to user space (via the stat() system call)
> and from user space to filesystem (via the mknod() system call).
> 
> So, it seems the kernel interface must allow passing the values
> that actually occur, in present or future file systems.
> Making the interface narrow is only asking for problems later.
> Are there already any filesystems that use 64-bits?
> I would say that that is irrelevant - what we don't have today
> may come tomorrow - but in fact the NFSv3 interface uses
> a 64-bit device number.
> 
> So glibc comes with 64 bits, the kernel has to hand these bits
> over to NFS but is unwilling to - you are not going to get
> more than 32. Why?
> 
> > I have a holy crusade.
> 
> I fail to see the connection. There is no bloat here, the kernel
> is hardly involved. Some values are passed. If the values are
> larger than the filesystem likes it will probably return EINVAL.
> But the kernel has no business getting in the way.
> 
> There is no matter of efficiency either - mknod is not precisely
> the most frequently used system call, and our stat interface, which
> really is important, is 64 bits today.

I think the only reason for Linux to take 12 bit major is the
fact that then he only has to increas the lenght of the static
major device pointers in the kernel and it will be there...
However the problem is mostly that the aforementioned array
of pointers shouldn't me there in first place.

> 
> Not using 64 also gives interesting small problems with Solaris or
> FreeBSD NFS mounts. One uses 14+18, the other 8+24, so with 12+20
> we cannot handle Solaris' majors and we cannot handle FreeBSD's minors.
> 
> [Then there were discussions about naming.
> These are interesting, but independent.
> The current discussion is almost entirely about mknod.]
> 
> Andries
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
- phone: +49 214 8656 283
- job:   eVision-Ventures AG, LEV .de (MY OPINIONS ARE MY OWN!)
- langs: de_DE.ISO8859-1, en_US, pl_PL.ISO8859-2, last ressort:
ru_RU.KOI8-R
