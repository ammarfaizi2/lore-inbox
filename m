Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130600AbRCTSox>; Tue, 20 Mar 2001 13:44:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130565AbRCTSoo>; Tue, 20 Mar 2001 13:44:44 -0500
Received: from unthought.net ([212.97.129.24]:48328 "HELO mail.unthought.net")
	by vger.kernel.org with SMTP id <S130733AbRCTSoX>;
	Tue, 20 Mar 2001 13:44:23 -0500
Date: Tue, 20 Mar 2001 19:43:41 +0100
From: Jakob Østergaard <jakob@unthought.net>
To: Serge Orlov <sorlov@con.mcst.ru>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>,
        sorlov@mcst.ru
Subject: Re: Linux 2.4.2 fails to merge mmap areas, 700% slowdown.
Message-ID: <20010320194341.E1508@unthought.net>
Mail-Followup-To: Jakob Østergaard <jakob@unthought.net>,
	Serge Orlov <sorlov@con.mcst.ru>, linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@transmeta.com>, sorlov@mcst.ru
In-Reply-To: <3AB7A169.53F4E4BB@con.mcst.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2i
In-Reply-To: <3AB7A169.53F4E4BB@con.mcst.ru>; from sorlov@con.mcst.ru on Tue, Mar 20, 2001 at 09:28:57PM +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 20, 2001 at 09:28:57PM +0300, Serge Orlov wrote:
>  Hi,
> I upgraded one of our computer happily running 2.2.13 kernel
> to 2.4.2. Everything was OK, but compilation time of our C++
> project greatly increased (1.4 times slower). I investigated the
> issue and found that g++ spends 7 times more time in kernel.

I see the *exact* same problem. Large C++ codes, and gcc spending most of the
CPU time in kernel.

> The reason for this is big vm map:
> 
> cat /proc/15677/maps |wc -l
>    2238

Exactly what I see too.   200 MB of memory allocated in 4K maps...

There is an easy fix:  In libiberty in GCC we could change xmalloc()
to do real malloc instead of calloc().   I think that would fix it.

Or glibc could be fixed to make calloc() behave more reasonably
when it's called with tons and tons of 4K allocations.

Or the kernel could be fixed to merge maps.

...
> .....
> 15677 old_mmap(NULL, 4096, PROT_READ|PROT_WRITE,
> MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x40019000

hear hear !   

...
> 
> OK, the numbers are here. g++ is 2.96 from RedHat 7.0.
> Please, CC me, as I'm not on the list.

gcc 2.96 here too.

Should we take this up with the glibc or gcc folks, or should
someone fix the kernel ?

This *is* a very significant performance problem for a standard tool.

-- 
................................................................
:   jakob@unthought.net   : And I see the elder races,         :
:.........................: putrid forms of man                :
:   Jakob Østergaard      : See him rise and claim the earth,  :
:        OZ9ABN           : his downfall is at hand.           :
:.........................:............{Konkhra}...............:
