Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267450AbRHFIhf>; Mon, 6 Aug 2001 04:37:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267512AbRHFIh0>; Mon, 6 Aug 2001 04:37:26 -0400
Received: from celebris.bdk.pl ([212.182.99.100]:54541 "EHLO celebris.bdk.pl")
	by vger.kernel.org with ESMTP id <S267450AbRHFIhM>;
	Mon, 6 Aug 2001 04:37:12 -0400
Date: Mon, 6 Aug 2001 10:40:58 +0200 (CEST)
From: Wojtek Pilorz <wpilorz@bdk.pl>
To: Jochen Siebert <siebert@kawo2.rwth-aachen.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: copying/creating large (>500MB) files results in sluggish
 behaviour.
In-Reply-To: <01072317440600.01317@siebert.kawo2.rwth-aachen.de>
Message-ID: <Pine.LNX.4.21.0108061031410.14558-100000@celebris.bdk.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-2
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Jul 2001, Jochen Siebert wrote:

> Date: Mon, 23 Jul 2001 18:10:34 +0000
> From: Jochen Siebert <siebert@kawo2.rwth-aachen.de>
> Reply-To: siebert@physik.rwth-aachen.de
> To: linux-kernel@vger.kernel.org
> Subject: PROBLEM: copying/creating large (>500MB) files results in
>     sluggish behaviour.
> 
> Hi,                     (look at the end of email for data) 
> 
> I´ve got a problem with my linux 2.4.7 box. If I download a 
> large (>500MB) file from a computer connected via 100Mbit 
> LAN (i.e. with more than 2MB/s) *or* I create such a large 
> file via the "dd" command (dd if=/dev/zero of=sloow)
> after some time my computer gets very sluggy and reacts
> veery sloow. I´ve watched the memory usage while creating 
> such a big file and noticed that all memory gets filled up, 
> and even swapping starts, *before* the disk starts to write 
> the file. Ok, so swapping and file writing at once seems to
> be not such a good idea of the kernel, even if the IBM 
> IC35L040 IDE disk is a fast one. Feel free to ask my via 
> email.
> 
> Adies,
> Jochen
> 
> ps: plz cc me.
> 
> Now the facts:
> =============================
[...]
> MemTotal:       384880 kB +128MB Swap,

I can see similar problem with kernels 2.2.x when writing a large amount
of data (compared to size of RAM, of size of free RAM) to a slow media (PD
drive , with write performance of about 250 kBytes/s).

It seems all data is 'cached' before being written, and this can make
system really unusable for the copy time - login from console can take
several minutes.
My understanding is that Linux is too aggressive in caching data to be
written and does not make distinction between fast and slow media;

The only workaround I am aware of is to reduce the speed data is put to
the filesystem (e.g. by using rsync with option --bwlimit)

Best regards,

Wojtek




