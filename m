Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276622AbRI2UxM>; Sat, 29 Sep 2001 16:53:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276620AbRI2Uwx>; Sat, 29 Sep 2001 16:52:53 -0400
Received: from 65-45-81-178.customer.algx.net ([65.45.81.178]:50958 "EHLO
	master.aslab.com") by vger.kernel.org with ESMTP id <S274964AbRI2Uwr>;
	Sat, 29 Sep 2001 16:52:47 -0400
Date: Sat, 29 Sep 2001 13:37:03 -0700 (PDT)
From: Andre Hedrick <andre@aslab.com>
To: Mark Hahn <hahn@physics.mcmaster.ca>
cc: Christian =?iso-8859-1?q?Borntr=E4ger?= 
	<linux-kernel@borntraeger.net>,
        <linux-kernel@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: RFC (patch below) Re: ide drive problem?
In-Reply-To: <Pine.LNX.4.10.10109291627300.9176-100000@coffee.psychology.mcmaster.ca>
Message-ID: <Pine.LNX.4.31.0109291333300.7545-100000@postbox.aslab.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Mark, you have a valid point but if they see this level of noise the
auto-dma-downgrade feature set exclusive to Linux will ramp down the max.
performance from init to a reasonable threshold.  The object is to
stablize the transfer rates first and then maintain performance.

You know the song and dance my friend, if anyone does.  Very few could
keep me in check, but you have managed quite well and I am impressed!

Cheers,

Andre Hedrick
CTO ASL, Inc.
Linux ATA Development
-----------------------------------------------------------------------------
ASL, Inc.                                    Tel: (510) 857-0055 x103
38875 Cherry Street                          Fax: (510) 857-0010
Newark, CA 94560                             Web: www.aslab.com

On Sat, 29 Sep 2001, Mark Hahn wrote:

> > This is an error that I am considering removing form the user's view.
> > For the very fact/reason you are pointing out; however, it becomse
> > more painful when performing error sorting.
>
> yes, most of the time, the warning scares people unnecessarily.
> but if the machine is seeing lots of CRC failures, there should
> definitely be some prominent messages.  perhaps something simple
> like producing a warning if more than a few of recent IOs
> have had CRC problems:
>
> int crcState = 0;
>
> on successful IO:
> 	crcState >>= 1;
>
> on CRC failure:
> 	if (crcState)
> 		printk("dang, CRC failed on hda, see http://whatever");
> 	crcState = 1 << 10;
>
> so if >10 IOs succeed between CRC failures, there's no warning.
> (uh, I guess that would actually be 9, since presumably the retry
> would succeed...)  keeping a global count of CRC failures would be
> kind of nice, too.
>
> regards, mark hahn.
>

