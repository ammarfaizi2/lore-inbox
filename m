Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313346AbSDEXEB>; Fri, 5 Apr 2002 18:04:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313689AbSDEXDv>; Fri, 5 Apr 2002 18:03:51 -0500
Received: from mail.actcom.co.il ([192.114.47.13]:35018 "EHLO
	lmail.actcom.co.il") by vger.kernel.org with ESMTP
	id <S313346AbSDEXDe>; Fri, 5 Apr 2002 18:03:34 -0500
Message-Id: <200204052302.g35N2o516910@lmail.actcom.co.il>
Content-Type: text/plain; charset=US-ASCII
From: Itai Nahshon <nahshon@actcom.co.il>
Reply-To: nahshon@actcom.co.il
To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        rgooch@ras.ucalgary.ca (Richard Gooch)
Subject: Re: faster boots?
Date: Sat, 6 Apr 2002 02:02:36 +0300
X-Mailer: KMail [version 1.3.2]
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), bcrl@redhat.com (Benjamin LaHaise),
        akpm@zip.com.au (Andrew Morton), joeja@mindspring.com,
        linux-kernel@vger.kernel.org
In-Reply-To: <E16tTAF-0008F2-00@the-village.bc.nu>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 05 April 2002 15:49 pm, Alan Cox wrote:
> > Be careful here. I did this for a while with a Maxtor 80 GB IDE drive,
> > and after a few months, it started making unpleasant noises when
> > spinning up (lots of clicking and clacking). I went back to continuous
>
> I can tell you I've had 80Gb Maxtors do that that were always spun up. They
> went back and the replacement ones have behaved so far. I don't think its
> that related
>

That should all on a per-disk configuration. I would like a different,
configurable  spin-down timeout (optionally never) for each disk.

A required feature IMHO: there should _never_ be dirty blocks
for disks that are not spinning.

Maybe it is possible to internally remount RO file systems that
have data on the disk before spinning down. Should not be much
of a problem if the file system is mounted with noatime and there
aren't any files open for writing nor directory operations in progress.

I'd rather have open() blocking and not fill all the memory with
dirty buffers that need to wait for spin-up to complete before they
can be written.

Swap areas, direct access to block device. loop devices and
raid partitions may be more difficult but you get the idea...

-- Itai
