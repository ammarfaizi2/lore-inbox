Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312887AbSDTTiC>; Sat, 20 Apr 2002 15:38:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312899AbSDTTiB>; Sat, 20 Apr 2002 15:38:01 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:1550 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S312887AbSDTTh7>;
	Sat, 20 Apr 2002 15:37:59 -0400
Message-ID: <3CC1C38F.37D1F8C2@zip.com.au>
Date: Sat, 20 Apr 2002 12:37:51 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@suse.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.4.19pre7aa1
In-Reply-To: <20020420194213.K1291@dualathlon.random>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli wrote:
> 
> ...
> Only in 2.4.19pre6aa1: 00_prepare-write-fixes-2
> Only in 2.4.19pre7aa1: 00_prepare-write-fixes-3
> 
>         Add a missing flush_dcache_page() to the prepare write corruption
>         fixes. Noticed by Andrew Morton.
> 

Why do we perform those "flushes"[1] at all?  The memsets should
never occur when the page is mapped into any process tables.

I seem to be missing something here.


[1] Can we please not that term?  A "flush" is something which you
    do to a "dunny" after taking a "crap". [2]

    Caches are either "written back" or are "invalidated".  Nothing
    else.

    This is not just semantics.  This stuff is hard.  90% of kernel
    developers are on x86, and 90% of those do not understand the
    nuances of all this.  The careful choice and use of terminology
    will aid other platforms.

[2] And a "sync" is something which you wash your hands in after the
    "flush".

    Dirty disk data is either "written out" or is "waited upon".  The
    kernel has real performance bugs due to this confusion.

-
