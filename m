Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319317AbSH2Tzg>; Thu, 29 Aug 2002 15:55:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319323AbSH2Tzg>; Thu, 29 Aug 2002 15:55:36 -0400
Received: from vasquez.zip.com.au ([203.12.97.41]:18949 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S319317AbSH2Tzg>; Thu, 29 Aug 2002 15:55:36 -0400
Message-ID: <3D6E7CBB.407299E3@zip.com.au>
Date: Thu, 29 Aug 2002 12:57:47 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andre Hedrick <andre@linux-ide.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: /pub/linux/kernel/people/hedrick/ide-2.5.32
References: <Pine.LNX.4.10.10208291240560.24156-100000@master.linux-ide.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andre Hedrick wrote:
> 
> ...
> There is one more thing to fix.
> 
> ./fs/mpage.c
> 
> /*
>  * The largest-sized BIO which this code will assemble, in bytes.  Set this
>  * to PAGE_CACHE_SIZE if your drivers are broken.
>  */
> #define MPAGE_BIO_MAX_SIZE 32768        //BIO_MAX_SIZE
> 
> This is confirmed with Al Viro and was required to make things sane!

You'll need to do the same thing to fs/direct-io.c:DIO_BIO_MAX_SIZE
in that case.

I'd suggest that you just go in and change BIO_MAX_SECTORS
to 64.   Or 32 if you happen to be using a qlogic controller :(

So everything's broken in there - a hardwired constant doesn't
cut it.   Jens is cooking up an `add_page_to_bio()' API which
will do the right thing based upon q->max_sectors.  But that
is not yet available.
