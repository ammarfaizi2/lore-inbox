Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261292AbVEYICw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261292AbVEYICw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 May 2005 04:02:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261336AbVEYICw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 May 2005 04:02:52 -0400
Received: from siaag1ab.compuserve.com ([149.174.40.4]:44284 "EHLO
	siaag1ab.compuserve.com") by vger.kernel.org with ESMTP
	id S261292AbVEYICq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 May 2005 04:02:46 -0400
Date: Wed, 25 May 2005 03:57:14 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [patch 07/16] ide-disk: Fix LBA8 DMA
To: Chris Wright <chrisw@osdl.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       linux-stable <stable@kernel.org>, Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Chuck Wolber <chuckw@quantumlinux.com>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
       Daniel Drake <dsd@gentoo.org>
Message-ID: <200505250400_MC3-1-9FB4-BDB5@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 May 2005 at 16:24:14 -0700, Chris Wright wrote:

> --- linux-2.6.11.10.orig/drivers/ide/ide-disk.c       2005-05-16 10:50:31.000000000 -0700
> +++ linux-2.6.11.10/drivers/ide/ide-disk.c    2005-05-20 09:36:31.933319224 -0700
> @@ -133,6 +133,8 @@
>       if (hwif->no_lba48_dma && lba48 && dma) {
>               if (block + rq->nr_sectors > 1ULL << 28)

                                           ^

  Maybe I'm an idiot, but shouldn't that be ">="?  Either that or it should be
comparing to (1ULL < 28 - 1)?

>                       dma = 0;
> +               else
> +                       lba48 = 0;

   ^^^^^^^^^^^^^^^^^^^^^^^

  Spaces instead of tabs?

>       }
>  
>       if (!dma) {


--
Chuck
