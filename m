Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131942AbQKVAlF>; Tue, 21 Nov 2000 19:41:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131956AbQKVAkz>; Tue, 21 Nov 2000 19:40:55 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:43527 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S131942AbQKVAku>; Tue, 21 Nov 2000 19:40:50 -0500
Message-ID: <3A1B0DFC.72E4E9FF@timpanogas.org>
Date: Tue, 21 Nov 2000 17:06:20 -0700
From: "Jeff V. Merkey" <jmerkey@timpanogas.org>
Organization: TRG, Inc.
X-Mailer: Mozilla 4.7 [en] (WinNT; I)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: CMA <cma@mclink.it>, tytso@mit.edu, card@masi.ibp.fr,
        linux-kernel@vger.kernel.org
Subject: Re: e2fs performance as function of block size
In-Reply-To: <E13yMvv-0005Ly-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Alan Cox wrote:
> 
> > Sirs,
> > performing extensive tests on linux platform performance, optimized as
> > database server, I got IMHO confusing results:
> > in particular e2fs initialized to use 1024 block/fragment size showed
> > significant I/O gains over 4096 block/fragment size, while I expected t=
> > he
> > opposite. I would appreciate some hints to understand this.
> 
> It may be that your database is writing out 1K sized blocks on random
> boundaries. If so then the behaviour you describe would be quite reasonable.

Alan,

Perhaps, but I have reported this before and seen something similiar. 
It's as though the disk drivers are optimized for this case (1024).  I
get better performance running NWFS at 1024 block size vs. all the other
sizes, even with EXT2 configured to use 4096, etc.  At first glance,
when I was changing block sizes, I did note that by default, EXT2 set to
1024 would mix buffer sizes in the buffer cache, which skewed caching
behavior, but there is clearly some optimization relative to this size
inherent in the design of Linux -- and it may be a pure accident.  This
person may be mixing and matching block sizes in the buffer cache, which
would satisfy your explanation.

Jeff

> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
