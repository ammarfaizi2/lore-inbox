Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274736AbRIYXqA>; Tue, 25 Sep 2001 19:46:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274737AbRIYXpk>; Tue, 25 Sep 2001 19:45:40 -0400
Received: from [195.223.140.107] ([195.223.140.107]:6129 "EHLO athlon.random")
	by vger.kernel.org with ESMTP id <S274736AbRIYXpg>;
	Tue, 25 Sep 2001 19:45:36 -0400
Date: Wed, 26 Sep 2001 01:46:03 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Christian =?iso-8859-1?Q?Borntr=E4ger?= 
	<linux-kernel@borntraeger.net>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
        Paul Larson <plars@austin.ibm.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        =?iso-8859-1?Q?Jacek=5Biso-8859-2=5DPop=B3awski?= 
	<jpopl@interia.pl>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: __alloc_pages: 0-order allocation failed
Message-ID: <20010926014603.S1782@athlon.random>
In-Reply-To: <1001319223.4613.34.camel@plars.austin.ibm.com> <E15m0Wz-0002He-00@mrvdom01.schlund.de> <20010926010149.U8350@athlon.random> <E15m1a6-0000K1-00@mrvdom00.schlund.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <E15m1a6-0000K1-00@mrvdom00.schlund.de>; from linux-kernel@borntraeger.net on Wed, Sep 26, 2001 at 01:24:10AM +0200
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 26, 2001 at 01:24:10AM +0200, Christian Bornträger wrote:
> > Could you enable CONFIG_DEBUG_GFP (kernel debugging menu) in 2.4.10aa1
> > and send me full traces of the faliures so I can better see where the
> > problem cames from? Thanks!
> 
> OK, with the vm-tweaks and the gfp-patch I got the following output:
> 
> __alloc_pages: 0-order allocation failed (gfp=0x1d2/0)
> dcb81e30 c01fd640 00000000 000001d2 00000000 00000000 dcb81e5c 00000001
>        c0223848 c02239b8 000001d2 00000000 00000001 c1978d40 de9f30c0 de9855a0
>        c01219d7 00000000 00000000 c012b35f c0223848 de9f30c0 c1978d40 00000001
> Call Trace: [<c01219d7>] [<c012b35f>] [<c0121a60>] [<c0121b40>] [<c011152e>]
>    [<c010adc2>] [<c0121e27>] [<c01113b0>] [<c0106dec>]
> VM: killing process a.out
> 
> 
> feeding it to ksymoops....:
> 
> 
> dcb81e30 c01fd640 00000000 000001d2 00000000 00000000 dcb81e5c 00000001
>        c0223848 c02239b8 000001d2 00000000 00000001 c1978d40 de9f30c0 de9855a0
>        c01219d7 00000000 00000000 c012b35f c0223848 de9f30c0 c1978d40 00000001
> Call Trace: [<c01219d7>] [<c012b35f>] [<c0121a60>] [<c0121b40>] [<c011152e>]
>    [<c010adc2>] [<c0121e27>] [<c01113b0>] [<c0106dec>]
> Warning (Oops_read): Code line not seen, dumping what data is available
> 
> Trace; c01219d7 <do_anonymous_page+37/90>
> Trace; c012b35f <__alloc_pages+4f/240>
> Trace; c0121a60 <do_no_page+30/b0>
> Trace; c0121b40 <handle_mm_fault+60/d0>
> Trace; c011152e <do_page_fault+17e/4b0>
> Trace; c010adc2 <timer_interrupt+62/110>
> Trace; c0121e27 <sys_brk+b7/f0>
> Trace; c01113b0 <do_page_fault+0/4b0>
> Trace; c0106dec <error_code+34/3c>
> 
> 
> If you need a run on a complete aa1-patch, let me know.

ok, this sounds like a normal oom condition but of course I assume it
isn't. Can you show a `vmstat 1` during the oom kill + some
/proc/meminfo? thanks for the great feedback!

Andrea
