Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286692AbSA1J7U>; Mon, 28 Jan 2002 04:59:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282843AbSA1J7K>; Mon, 28 Jan 2002 04:59:10 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:65035 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S286692AbSA1J66>;
	Mon, 28 Jan 2002 04:58:58 -0500
Message-ID: <3C551F18.873EA52E@zip.com.au>
Date: Mon, 28 Jan 2002 01:51:20 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18-pre7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: benh@kernel.crashing.org
CC: Ed Sweetman <ed.sweetman@wmich.edu>,
        Kristian <kristian.peters@korseby.net>, linux-kernel@vger.kernel.org
Subject: Re: [CFT] Bus mastering support for IDE CDROM audio
In-Reply-To: <3C550BD4.E9CBE6A@zip.com.au>,
		<3C550BD4.E9CBE6A@zip.com.au> <20020128095136.1298@mailhost.mipsys.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

benh@kernel.crashing.org wrote:
> 
> >At no stage does a packet-mode DMA error turn off drive-level
> >DMA.  This is because some devices seem to perform ordinary
> >ATA DMA OK, but screw up packet DMA.
> >
> >The kernel internally retries the requests when it performs fallback,
> >so userspace shouldn't see any disruption as the kernel works
> >out what to do.
> >
> >Once the drive has fallen back to single-frame (or PIO mode) for
> >packet reads, the only way to get it back to a higher level is
> >a reboot.
> 
> Doesn that mean that a bad media (typically a scratched CDROM) will
> cause the drive to revert to PIO until next reboot ?
> 

Nope.  This error handling is specifically for busmastering
errors, not for media errors.

I've tested media errors (whiteboard marker scribblings on the
CD do this nicely).  DMA errors (bad return value from
HWIF->dmaproc) I can only simulate.


-
