Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131213AbQKVBMh>; Tue, 21 Nov 2000 20:12:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132008AbQKVBM1>; Tue, 21 Nov 2000 20:12:27 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:50951 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S131213AbQKVBMT>; Tue, 21 Nov 2000 20:12:19 -0500
Message-ID: <3A1B1565.F6CD1810@timpanogas.org>
Date: Tue, 21 Nov 2000 17:37:57 -0700
From: "Jeff V. Merkey" <jmerkey@timpanogas.org>
Organization: TRG, Inc.
X-Mailer: Mozilla 4.7 [en] (WinNT; I)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: CMA <cma@mclink.it>, tytso@mit.edu, card@masi.ibp.fr,
        linux-kernel@vger.kernel.org
Subject: Re: e2fs performance as function of block size
In-Reply-To: <E13yNlM-0005Q3-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Alan Cox wrote:
> 
> > It's as though the disk drivers are optimized for this case (1024).  I
> 
> The disk drivers are not, and they normally see merged runs of blocks so they
> will see big chunks rather than 1K then 1K then 1K etc.
> 
> > behavior, but there is clearly some optimization relative to this size
> > inherent in the design of Linux -- and it may be a pure accident.  This
> > person may be mixing and matching block sizes in the buffer cache, which
> > would satisfy your explanation.
> 
> I see higher performance with 4K block sizes. I should see higher latency too
                                                            
^^^^^^^^^^^^^^^^^
Since buffer heads are chained, this would make sense.


> but have never been able to measure it. Maybe it depends on the file system.
> It certainly depends on the nature of requests

Could be.  NWFS likes 4K block sizes -- this is it's default.  On linux,
I've been emulating other block sizes beneath it.  I see best
performance at 1024 byte blocks, worst at 512.  The overhead of buffer
chaining is clearly the culprit.

On the TCPIP oops on 2.2.18-22, I have not been able to reproduce it
reliably.  It appears to be in the ppp code, however, and not the TCPIP
code.  The problem only shows up after several pppd connections have
accessed the box then terminated the connections (which is why I think
it's pp related).  I would rate this as a level IV bug due to the
difficulty in creating it, and the fact that you have to deliberately
misconfigure a TCPIP network to make it show up.

Jeff

Jeff
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
