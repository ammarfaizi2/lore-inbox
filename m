Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316896AbSGNPc6>; Sun, 14 Jul 2002 11:32:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316897AbSGNPc5>; Sun, 14 Jul 2002 11:32:57 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:7667 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S316896AbSGNPc4>; Sun, 14 Jul 2002 11:32:56 -0400
Subject: Re: IDE/ATAPI in 2.5
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Joerg Schilling <schilling@fokus.gmd.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200207141512.g6EFCSIZ019177@burner.fokus.gmd.de>
References: <200207141512.g6EFCSIZ019177@burner.fokus.gmd.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 14 Jul 2002 17:45:10 +0100
Message-Id: <1026665110.13886.66.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-07-14 at 16:12, Joerg Schilling wrote:
> >From alan@lxorguk.ukuu.org.uk Sun Jul 14 16:18:38 2002
> >> It seems that you miss to understand the needed underlying driver structures.
> >> SCSI is not a block layer, it is a generic transport.
> 
> >It is not generic - its handling of sophisticated I/O stuff is non
> 
> The fact that you don't know st does not make this statement true.

Try doing the following in SCSI

-	Device managed storage layout  "Allocate x blocks close to 	handle y
and give me a new handle"

-	Per I/O request readahead hints (please read on xyzK , please 	dont
readahead)

-	Per I/O request writeback hints (write back cache is ok, write 	back
cache is ok only if NV, don't bother caching, streaming I/O
	hint)

Nor are all the FC problems caused by bad transport implementations in
Linux. Physical layer incompatibilities occur everywhere - but aren't
the one I'm talking about. Of more concern are the inability to manage
multiple levels of caches properly.

I have controllers which can do most of the above. I don't want to talk
scsi to them and spend all my cpu time faking, decoding and recoding
command blocks, spoofing error handling and the like.

Its simply inappropriate to consider the SCSI command set as a high
level interface for block and related I/O. 

As to your comments on sg. Everyone except you happened to think that
Doug Gilberts very nice sg changes were the right path. I still think it
was the right decision. 

> If this discussion stays as it currently looks like, it does not make 
> sense for me to try to find a better solution. Let me call it this
> way: this thread was just another proof that it is not possible to
> have a technical based solution with the Linux folks. It seems t be >
> just a waste of time :-(

The Linux development process aggressively filters bad ideas.

Alan

