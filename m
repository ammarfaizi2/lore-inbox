Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265212AbUBKO5b (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Feb 2004 09:57:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265289AbUBKO5b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Feb 2004 09:57:31 -0500
Received: from asteroids.scarlet-internet.nl ([213.204.195.163]:31166 "EHLO
	asteroids.scarlet-internet.nl") by vger.kernel.org with ESMTP
	id S265212AbUBKO52 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Feb 2004 09:57:28 -0500
Message-ID: <1076511445.402a42d5c6ff9@webmail.dds.nl>
Date: Wed, 11 Feb 2004 15:57:25 +0100
From: wdebruij@dds.nl
To: sting sting <zstingx@hotmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Example Code Was : Re: Re : Re: printk and long long
References: <Sea2-F294mt5UJoched000331f3@hotmail.com>
In-Reply-To: <Sea2-F294mt5UJoched000331f3@hotmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.2.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> Well I had tried it but I got
> the follwing compilation errors while trying to add that code:
> invalid operands to binary >>
> invalid operands to binary <<

I just ran the following on my computer :

"
#define LLHIGH(n) (unsigned long) (n >> (8 * sizeof(long)))
#define LLLOW(n) (unsigned long) ((n << (8 * sizeof(long)))  >> (8 * sizeof(long)))
/** internal function: called from the template module's init function */
int myfunc(void){

	unsigned long long int ullint = ((unsigned long long int) 1 << 32) - 1; //
LONG_MAX returns 7fffffff, this at least is a max_long
	unsigned long int ulint = ((unsigned long long int) 1 << 32) - 1;
	printk("a long long consists of %d bits on an x86 (athlon-xp), whereas a long
consists of %d bits\n", sizeof(ullint) * 8, sizeof(long) * 8);
	printk("my test long long reads %.8lx%.8lx; my test long %.8lx\n",
LLHIGH(ullint), LLLOW(ullint), ulint );
	ullint += 1; // will we get overflow or is a long long really > long?
	ulint += 1;
	printk("my test long long now reads %.8lx%.8lx; my test long %.8lx\n",
LLHIGH(ullint), LLLOW(ullint), ulint );

"

"
a long long consists of 64 bits on an x86 (athlon-xp), whereas a long consists
of 32 bits
my test long reads 00000000ffffffff; my test long ffffffff
my test long reads 0000000100000000; my test long 00000000
"

It took a bit longer to get right than I imagined (doesn't it always ;), but at
least here you've got a working example. Enjoy.

cheers,

  Willem
> 
> I assume maybe it is a problems with the flags I use:
> I use gcc 3.2.2 and the flags are:
> O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common
> -DMODULE -D__KERNEL__ -DNOKERNEL

to the best of my knowledge it has nothing to do with this.

