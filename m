Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315558AbSERFTg>; Sat, 18 May 2002 01:19:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316670AbSERFTf>; Sat, 18 May 2002 01:19:35 -0400
Received: from ucsu.Colorado.EDU ([128.138.129.83]:22930 "EHLO
	ucsu.colorado.edu") by vger.kernel.org with ESMTP
	id <S315558AbSERFTe>; Sat, 18 May 2002 01:19:34 -0400
Content-Type: text/plain; charset=US-ASCII
From: "Ivan G." <ivangurdiev@linuxfreemail.com>
Reply-To: ivangurdiev@linuxfreemail.com
Organization: ( )
To: "'Roger Luethi'" <rl@hellgate.ch>
Subject: Re: [PATCH] #2 VIA Rhine stalls: TxAbort handling
Date: Fri, 17 May 2002 17:13:33 -0600
X-Mailer: KMail [version 1.2]
In-Reply-To: <369B0912E1F5D511ACA5003048222B75A3C06E@EXCHANGE2> <20020518040143.GA9318@k3.hellgate.ch>
Cc: LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <02051717133300.00656@cobra.linux>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> [1] "aborted due to excessive collisions" according to the doc, but it also
>     mentions that for "excessive collisions", bit 13 would have to be set.
>     It isn't.
>     (I have seen it on my VT6102, though, with interrupt status of 0x2008
>     for instance)

bit 13 = IntrTxAborted
I don't see it below.

/* Enable interrupts by setting the interrupt mask. */
writew(IntrRxDone | IntrRxErr | IntrRxEmpty| IntrRxOverflow| IntrRxDropped|
   IntrTxDone | IntrTxAbort | IntrTxUnderrun | IntrPCIErr | IntrStatsMax | 
IntrLinkChange | IntrMIIChange, ioaddr + IntrEnable);

Interrupts referenced in the driver and not listed here are: IntrRxNoBuf,
IntrRxWakeUp, IntrTxAborted

Interrupts included here but not used in the driver are:
IntrRxOverflow, IntrRxDropped.

I've known about this for a while but I wasn't sure how to fix everything...
I wasn't sure if every interrupt was handled correctly.
For example what exactly is the difference between IntrTxAbort and 
IntrTxAborted. 

I was also puzzled as to why the docs say:
Transmit Descriptor Underflow for IntrMIIChange

I am talking about the newest VT86C100A docs.
I believe Urban Widmark had a patch that redefined that interrupt but it was 
never included.







