Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265145AbSKESoB>; Tue, 5 Nov 2002 13:44:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265150AbSKESoB>; Tue, 5 Nov 2002 13:44:01 -0500
Received: from NEUROSIS.MIT.EDU ([18.243.0.82]:9707 "EHLO neurosis.mit.edu")
	by vger.kernel.org with ESMTP id <S265145AbSKESoB>;
	Tue, 5 Nov 2002 13:44:01 -0500
Date: Tue, 5 Nov 2002 13:50:29 -0500
From: Jim Paris <jim@jtan.com>
To: Willy Tarreau <willy@w.ods.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Re: time() glitch on 2.4.18: solved
Message-ID: <20021105135029.A6424@neurosis.mit.edu>
References: <20021102013704.A24684@neurosis.mit.edu> <20021103143216.A27147@neurosis.mit.edu> <1036355418.30679.28.camel@irongate.swansea.linux.org.uk> <20021105113020.A5210@neurosis.mit.edu> <20021105171035.GB879@alpha.home.local> <1036520191.5012.109.camel@irongate.swansea.linux.org.uk> <20021105130222.A6245@neurosis.mit.edu> <1036521477.4827.118.camel@irongate.swansea.linux.org.uk> <20021105182019.GA25472@alpha.home.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20021105182019.GA25472@alpha.home.local>; from willy@w.ods.org on Tue, Nov 05, 2002 at 07:20:19PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> could that be the reason a few people have experienced occasionnal jumps
> backwards in gettimeofday() a few months ago, which many others could never
> reproduce ? Just because of buggy hardware ?

An unpaired read on port 0x40 is almost certainly the cause of e.g.

    http://www.uwsg.iu.edu/hypermail/linux/kernel/0206.0/1505.html

and we would expect to see the problem with count==LATCH about 1/11932
of the time, about 0.008% -- almost exactly the value reported in:

    http://www.uwsg.iu.edu/hypermail/linux/kernel/0206.3/0043.html

I believe that by adding both the (count > LATCH) check and a second
(count == LATCH) check, we can fix both of these.

-jim
