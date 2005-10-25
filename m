Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932126AbVJYKPK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932126AbVJYKPK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Oct 2005 06:15:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932121AbVJYKPJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Oct 2005 06:15:09 -0400
Received: from xproxy.gmail.com ([66.249.82.193]:39381 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932126AbVJYKPI convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Oct 2005 06:15:08 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=qnBccClxocE4mvwaIpoTx5g0g4c4edJZNDkq1kC9qipXGoQ2MnG9UfKmiFG+NEEdWons/KsAugyusik4+a+nER3hvwe0pGhUflSRmDPHxp+AdxldxMozIP7NHiRwhbvaSYbap+Ed+/avQxWHP72uh8p1LftWkH6FyaIieVNcoS0=
Message-ID: <1e62d1370510250315n690e3455j13f2e1651476d784@mail.gmail.com>
Date: Tue, 25 Oct 2005 15:15:07 +0500
From: Fawad Lateef <fawadlateef@gmail.com>
To: Block Device <blockdevice@gmail.com>
Subject: Re: Block I/O sizes
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <64c763540510250243v64c0c22bt4a6e57bb5490fb77@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <64c763540510250243v64c0c22bt4a6e57bb5490fb77@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/25/05, Block Device <blockdevice@gmail.com> wrote:
>     When any fs i/o is done, the bi_sector value is in terms of fs
> block size and not sector size (for the block device). When i perform
> raw i/o to the device ( dd for eg ), bi_sector is in terms of sectors
> and not fs blocks.
>
>     In both the cases though, bio_sectors(bio) returns the amount of
> data written in sectors.
>
> To me this is rather strange. Should it not be in terms of sector size always ?
>  Can someone please explain ?
>

bio_sectors is a macro which calculates nr_sectors from the bi_size
field, and as far as bi_sector is concerned, I always considered and
used as a sector (in terms of sector size) in my block-device drivers
whether the user is performing dd or anything else. And you can also
see ll_rw_blk.c in function __make_request its considering
bio->bi_sector as sector like this:

	sector_t sector;
	sector = bio->bi_sector;
	nr_sectors = bio_sectors(bio);

So, I don't think bi_sector in some case contains block_nr or
sector_nr, rather it always keeps sector_nr (CMIIW)


And __please__ change your name from Block Device to your real name,
its annoying to see Block Device as a name of a person. :(


--
Fawad Lateef
