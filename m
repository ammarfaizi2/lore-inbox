Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272508AbRIKQTl>; Tue, 11 Sep 2001 12:19:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272511AbRIKQTW>; Tue, 11 Sep 2001 12:19:22 -0400
Received: from [195.63.194.11] ([195.63.194.11]:61455 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S272508AbRIKQTL>; Tue, 11 Sep 2001 12:19:11 -0400
Message-ID: <3B9E3819.90F21593@evision-ventures.com>
Date: Tue, 11 Sep 2001 18:13:13 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.3-12 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
CC: Daniel Phillips <phillips@bonn-fries.net>,
        Linus Torvalds <torvalds@transmeta.com>,
        Rik van Riel <riel@conectiva.com.br>,
        Andreas Dilger <adilger@turbolabs.com>,
        Andrea Arcangeli <andrea@suse.de>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-2.4.10-pre5
In-Reply-To: <20010911155953Z16272-1367+16@humbolt.nl.linux.org> <1033942741.1000228033@[10.132.112.53]>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alex Bligh - linux-kernel wrote:
> 
> --On Tuesday, September 11, 2001 6:07 PM +0200 Daniel Phillips
> <phillips@bonn-fries.net> wrote:
> 
> > There is clearly something nonoptimal about the hardware readahead and/or
> > caching.
> 
> Partly I guess that the disk h/w cache is the wrong side of a potential
> IO bottleneck - i.e. you can read faster from main memory than from
> any disk cache.


But during the read from the disk you can do different things in
paralell.
Think DMA! And then please remember my posts from a year ago:

We have already 3 different read-ahead layers in Linux!

Read it twice THRE one on top of the other:

1. Physical.

2. Inside the driver.

2a. block device layer.

3. File system layer.

And in addition to this there is:

2a. or maybe even 2b if you take MD and RAID into account as well.

And plase remember that each of them can fight against the other becouse
they all presume different ordering mechanisms.
