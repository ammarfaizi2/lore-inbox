Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135285AbRARMc0>; Thu, 18 Jan 2001 07:32:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135307AbRARMcR>; Thu, 18 Jan 2001 07:32:17 -0500
Received: from mail.crc.dk ([130.226.184.8]:59909 "EHLO mail.crc.dk")
	by vger.kernel.org with ESMTP id <S135285AbRARMcL>;
	Thu, 18 Jan 2001 07:32:11 -0500
Message-ID: <3A66E248.8A1E6A85@crc.dk>
Date: Thu, 18 Jan 2001 13:32:08 +0100
From: Mogens Kjaer <mk@crc.dk>
Organization: Carlsberg Laboratory
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0 i686)
X-Accept-Language: da, en, de
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: nfs client problem in kernel 2.4.0
In-Reply-To: <3A6466E3.AB55716@crc.dk> <shsy9wb334a.fsf@charged.uio.no> <shsu26z32lg.fsf@charged.uio.no>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trond Myklebust wrote:
> 
> >>>>> " " == Mogens Kjaer <mk@crc.dk> writes:
>     >> getdents64(3, /* 6 entries */, 65536) = 160 lseek(3,
>     >> 1547825467, SEEK_SET) = 1547825467 ...  getdents64(3, /* 1
>     >> entries */, 65536) = 32
> 
> BTW: there does in any case seem to be a bug in your version of
> glibc. getdents64() is returning 64-bit file offsets, so they're not
> going to fit with ordinary lseek().

This turned out to be more difficult than I thought...

I suspect glibc-2.2-12 being the reason, but I'm not quite sure yet:

The problem is, that the 64-bit dirent's are converted to 32-bit
dirent's
and a sanity check is performed, if the inodes or offsets don't fit into
32 bits.

The offset of the last entry is 4294967295 (no, not -1),
this won't fit in a signed 32 bit number.

Does this number come from the SGI or from the NFS stuff in the Linux
kernel?

Mogens
-- 
Mogens Kjaer, Carlsberg Laboratory, Dept. of Chemistry
Gamle Carlsberg Vej 10, DK-2500 Valby, Denmark
Phone: +45 33 27 53 25, Fax: +45 33 27 47 08
Email: mk@crc.dk Homepage: http://www.crc.dk
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
