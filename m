Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274633AbRJAGsf>; Mon, 1 Oct 2001 02:48:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274635AbRJAGsP>; Mon, 1 Oct 2001 02:48:15 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:48330 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S274633AbRJAGsG>;
	Mon, 1 Oct 2001 02:48:06 -0400
Date: Mon, 1 Oct 2001 02:48:34 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Erik Andersen <andersen@codepoet.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: [CFT][PATCH] cleanup of partition code
In-Reply-To: <20011001000446.A24245@codepoet.org>
Message-ID: <Pine.GSO.4.21.0110010243520.14026-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 1 Oct 2001, Erik Andersen wrote:

> Here is what I normally see (in this case with 2.4.9-ac17):

> 	 sda:<5>ll_rw_block: device 08:00: only 2048-char blocks implemented (1024)
> 	 unable to read boot sectors / partition sectors
> 	SCSI device sdb: 310352 2048-byte hdwr sectors (636 MB)
> 	sdb: Write Protect is off
> 	 sdb:<5>ll_rw_block: device 08:10: only 2048-char blocks implemented (1024)
> 	 unable to read boot sectors / partition sectors
 
> Note the ll_rw_block msg from where the acorn stuff is not reading in units
> of the physical sector size?  Also notice the "unable to read..." msg, which
> is where acorn chokes the partition table scanning...

Yes.  I've finished converting this sucker and I think I understand what's
going on there.  Reliance on block size being <= 1024 seems to be a
side effect of the implementation - not something fundamental.  I'll
try to feed the stuff you've sent into it and see if it works - new
code shouldn't care about the block size.

