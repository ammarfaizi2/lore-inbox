Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274723AbRIYXZ6>; Tue, 25 Sep 2001 19:25:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274721AbRIYXZt>; Tue, 25 Sep 2001 19:25:49 -0400
Received: from moutvdom01.kundenserver.de ([195.20.224.200]:2857 "EHLO
	moutvdom01.kundenserver.de") by vger.kernel.org with ESMTP
	id <S274716AbRIYXZc> convert rfc822-to-8bit; Tue, 25 Sep 2001 19:25:32 -0400
Content-Type: text/plain; charset=US-ASCII
From: Christian =?iso-8859-1?q?Borntr=E4ger?= 
	<linux-kernel@borntraeger.net>
To: Andrea Arcangeli <andrea@suse.de>
Subject: Re: __alloc_pages: 0-order allocation failed
Date: Wed, 26 Sep 2001 01:24:10 +0200
X-Mailer: KMail [version 1.3.1]
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
        Paul Larson <plars@austin.ibm.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        =?iso-8859-1?q?Jacek=5Biso-8859-2=5DPop=B3awski?= 
	<jpopl@interia.pl>,
        lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <1001319223.4613.34.camel@plars.austin.ibm.com> <E15m0Wz-0002He-00@mrvdom01.schlund.de> <20010926010149.U8350@athlon.random>
In-Reply-To: <20010926010149.U8350@athlon.random>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E15m1a6-0000K1-00@mrvdom00.schlund.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Could you enable CONFIG_DEBUG_GFP (kernel debugging menu) in 2.4.10aa1
> and send me full traces of the faliures so I can better see where the
> problem cames from? Thanks!

OK, with the vm-tweaks and the gfp-patch I got the following output:

__alloc_pages: 0-order allocation failed (gfp=0x1d2/0)
dcb81e30 c01fd640 00000000 000001d2 00000000 00000000 dcb81e5c 00000001
       c0223848 c02239b8 000001d2 00000000 00000001 c1978d40 de9f30c0 de9855a0
       c01219d7 00000000 00000000 c012b35f c0223848 de9f30c0 c1978d40 00000001
Call Trace: [<c01219d7>] [<c012b35f>] [<c0121a60>] [<c0121b40>] [<c011152e>]
   [<c010adc2>] [<c0121e27>] [<c01113b0>] [<c0106dec>]
VM: killing process a.out


feeding it to ksymoops....:


dcb81e30 c01fd640 00000000 000001d2 00000000 00000000 dcb81e5c 00000001
       c0223848 c02239b8 000001d2 00000000 00000001 c1978d40 de9f30c0 de9855a0
       c01219d7 00000000 00000000 c012b35f c0223848 de9f30c0 c1978d40 00000001
Call Trace: [<c01219d7>] [<c012b35f>] [<c0121a60>] [<c0121b40>] [<c011152e>]
   [<c010adc2>] [<c0121e27>] [<c01113b0>] [<c0106dec>]
Warning (Oops_read): Code line not seen, dumping what data is available

Trace; c01219d7 <do_anonymous_page+37/90>
Trace; c012b35f <__alloc_pages+4f/240>
Trace; c0121a60 <do_no_page+30/b0>
Trace; c0121b40 <handle_mm_fault+60/d0>
Trace; c011152e <do_page_fault+17e/4b0>
Trace; c010adc2 <timer_interrupt+62/110>
Trace; c0121e27 <sys_brk+b7/f0>
Trace; c01113b0 <do_page_fault+0/4b0>
Trace; c0106dec <error_code+34/3c>


If you need a run on a complete aa1-patch, let me know.

greetings

Christian
