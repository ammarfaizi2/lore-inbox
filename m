Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135516AbRDWTSb>; Mon, 23 Apr 2001 15:18:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135519AbRDWTSW>; Mon, 23 Apr 2001 15:18:22 -0400
Received: from obelix.hrz.tu-chemnitz.de ([134.109.132.55]:6129 "EHLO
	obelix.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id <S135516AbRDWTSL>; Mon, 23 Apr 2001 15:18:11 -0400
Date: Mon, 23 Apr 2001 21:18:01 +0200
From: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Alon Ziv <alonz@nolaviz.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mike Kravetz <mkravetz@sequent.com>,
        Ulrich Drepper <drepper@cygnus.com>
Subject: Re: light weight user level semaphores
Message-ID: <20010423211801.U682@nightmaster.csn.tu-chemnitz.de>
In-Reply-To: <E14qHRp-0007Yc-00@the-village.bc.nu> <Pine.LNX.4.31.0104190944090.4074-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <Pine.LNX.4.31.0104190944090.4074-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Thu, Apr 19, 2001 at 09:46:17AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 19, 2001 at 09:46:17AM -0700, Linus Torvalds wrote:
> > libc is entitled to, and most definitely does exactly that. Take a look at
> > things like gethostent, getpwent etc etc.
> 
> Ehh.. I will bet you $10 USD that if libc allocates the next file
> descriptor on the first "malloc()" in user space (in order to use the
> semaphores for mm protection), programs _will_ break.

But we would not open the semaphore on malloc() but instead in
the init functions of the libc. So the semaphore will be already
allocated. May be dup2()ed to some very high range
(INT_MAX-__GLIBC_MALLOC_SEM_FD) and the original fd closed.

So this will be no real problem. That's why I don't like lazy
init: May be you cannot init anymore, if you come to and
condition, where you would need it.

Also init/fini are usally very slow operations and as many things
as possible are burdend onto their shoulders.

Semaphores tend to be structures living very long (at least in
all code I've written and seen so far) so I see no point in
defering their initialization.

Regards

Ingo Oeser
-- 
10.+11.03.2001 - 3. Chemnitzer LinuxTag <http://www.tu-chemnitz.de/linux/tag>
         <<<<<<<<<<<<     been there and had much fun   >>>>>>>>>>>>
