Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133099AbRDRMTe>; Wed, 18 Apr 2001 08:19:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133097AbRDRMTZ>; Wed, 18 Apr 2001 08:19:25 -0400
Received: from chaos.analogic.com ([204.178.40.224]:49539 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S133098AbRDRMTR>; Wed, 18 Apr 2001 08:19:17 -0400
Date: Wed, 18 Apr 2001 08:18:29 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Dawson Engler <engler@csl.Stanford.EDU>
cc: linux-kernel@vger.kernel.org
Subject: Re: [CHECKER] copy_*_user length bugs?
In-Reply-To: <200104180439.VAA21983@csl.Stanford.EDU>
Message-ID: <Pine.LNX.3.95.1010418081430.6999A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Apr 2001, Dawson Engler wrote:

> Hi All,
> 
> at the suggestion of Chris (chris@ferret.lmh.ox.ac.uk) I wrote a simple
> checker to warn when the length parameter to copy_*_user was (1) an
> integer and (2) not checked < 0.    
> 
> As an example, the ipv6 routine rawv6_geticmpfilter gets an integer 'len'
> from user space, checks that it is smaller than a struct size and then
> uses length as an argument to copy_to_user: 
> 
>                 if (get_user(len, optlen))
>                         return -EFAULT;
>                 if (len > sizeof(struct icmp6_filter))
>                         len = sizeof(struct icmp6_filter);
>                 if (put_user(len, optlen))
>                         return -EFAULT;
>                 if (copy_to_user(optval, &sk->tp_pinfo.tp_raw.filter, len))
>                         return -EFAULT;
> 
> Is this a real bug?  Or is the checked rule only applicable to
> __copy_*_user routines rather than copy_*_user routines?  (If its a real
> bug, theres about 8 others that we found).
> 
> Thanks,
> Dawson

Length is type size_t (unsigned). It can't be less than zero.
copy_to_user() should fault with invalid lengths. That's one
of the things it's supposed to do.


Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

"Memory is like gasoline. You use it up when you are running. Of
course you get it all back when you reboot..."; Actual explanation
obtained from the Micro$oft help desk.


