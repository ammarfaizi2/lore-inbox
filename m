Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317506AbSGXUKl>; Wed, 24 Jul 2002 16:10:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317512AbSGXUKl>; Wed, 24 Jul 2002 16:10:41 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:51218 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S317506AbSGXUKj>;
	Wed, 24 Jul 2002 16:10:39 -0400
Message-ID: <3D3F0A00.51C112C1@zip.com.au>
Date: Wed, 24 Jul 2002 13:11:44 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@suse.de>
CC: David F Barrera <dbarrera@us.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: kernel BUG at page_alloc.c:92! & page allocation failure. order:0, 
 mode:0x0
References: <OF58871EFC.4272F3EB-ON85256C00.004B3677@pok.ibm.com> <3D3F019A.80BC3632@zip.com.au> <20020724195503.GD1180@dualathlon.random>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli wrote:
> 
> On Wed, Jul 24, 2002 at 12:35:54PM -0700, Andrew Morton wrote:
> > And please drop the ptrace.c change and use
> > http://www.zip.com.au/~akpm/linux/patches/2.5/2.5.27/lru-removal.patch
> > instead.
> 
> page_cache_release() can return a #define to __free_page().
> 

Man, it can do a ton more than that.  This patch is just a stopgap
to prevent the oops.

page_cache_release() goes out onto the bus for the PageReserved()
test and then immediately goes out onto the bus again to perform the
atomic_dec_and_test().  Plus it tends to do all this inside
a global lock.  That PageReserved thing needs to go away.

Seriously, this stuff needs a truck driven through it.  See
http://mail.nl.linux.org/linux-mm/2002-07/msg00009.html and things
like pagevec_release().  It still needs quite some work, but the
optimisations which are available here are considerable.

-
