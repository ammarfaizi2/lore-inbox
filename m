Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262384AbSJ0NXM>; Sun, 27 Oct 2002 08:23:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262385AbSJ0NXL>; Sun, 27 Oct 2002 08:23:11 -0500
Received: from dbl.q-ag.de ([80.146.160.66]:9912 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id <S262384AbSJ0NXL>;
	Sun, 27 Oct 2002 08:23:11 -0500
Message-ID: <3DBBEA2F.6000404@colorfullife.com>
Date: Sun, 27 Oct 2002 14:29:19 +0100
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020827
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Manfred Spraul <manfred@colorfullife.com>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH,RFC] faster kmalloc lookup
References: <3DBAEB64.1090109@colorfullife.com> <1035671412.13032.125.camel@irongate.swansea.linux.org.uk> <3DBBBB30.20409@colorfullife.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've run my slab microbenchmark over the 3 versions:
- current
- generic_fls
- i386 asm optimized fls

The test reports the fastest time for 100 kmalloc calls in a tight loop 
(Duron 700). Loop/test overhead substracted.

32-byte alloc:
current:        41 ticks
generic_fls: 56 ticks
bsrl:            54 ticks

4096 byte alloc: 84 ticks
generic_fls: 53 ticks
bsrl:        54 ticks

40 ticks difference for -current between 4096 and 32 bytes - ~4 cycles 
for each loop.
bit scan is 10 ticks slower for 32 byte allocs, 30 ticks faster for 4096 
byte allocs.

No difference between generic_fls and bsrl - the branch predictor can 
easily predict all branches in generic_fls for constant kmalloc calls.

--
    Manfred

