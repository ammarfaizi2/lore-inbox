Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129604AbRARQL1>; Thu, 18 Jan 2001 11:11:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129831AbRARQLR>; Thu, 18 Jan 2001 11:11:17 -0500
Received: from pat.uio.no ([129.240.130.16]:54206 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S129604AbRARQLF>;
	Thu, 18 Jan 2001 11:11:05 -0500
To: Mogens Kjaer <mk@crc.dk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: nfs client problem in kernel 2.4.0
In-Reply-To: <3A6466E3.AB55716@crc.dk> <shsy9wb334a.fsf@charged.uio.no> <shsu26z32lg.fsf@charged.uio.no> <3A66E248.8A1E6A85@crc.dk>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 18 Jan 2001 17:10:58 +0100
In-Reply-To: Mogens Kjaer's message of "Thu, 18 Jan 2001 13:32:08 +0100"
Message-ID: <shsg0igvo19.fsf@charged.uio.no>
X-Mailer: Gnus v5.6.45/XEmacs 21.1 - "Channel Islands"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Mogens Kjaer <mk@crc.dk> writes:

     > This turned out to be more difficult than I thought...

     > I suspect glibc-2.2-12 being the reason, but I'm not quite sure
     > yet:

     > The problem is, that the 64-bit dirent's are converted to
     > 32-bit dirent's and a sanity check is performed, if the inodes
     > or offsets don't fit into 32 bits.

     > The offset of the last entry is 4294967295 (no, not -1), this
     > won't fit in a signed 32 bit number.

     > Does this number come from the SGI or from the NFS stuff in the
     > Linux kernel?

It comes from the SGI. The NFS client just considers it all a cookie,
and passes it on to glibc. We probably shouldn't do that, as indeed
the cookie is not guaranteed to be 32-bit signed, but it's what we
always did for 2.2.x.

Cheers,
  Trond
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
