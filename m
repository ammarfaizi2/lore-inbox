Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132359AbRDNOXa>; Sat, 14 Apr 2001 10:23:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132370AbRDNOXU>; Sat, 14 Apr 2001 10:23:20 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:29457 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S132359AbRDNOXG>; Sat, 14 Apr 2001 10:23:06 -0400
Subject: Re: MO-Drive under 2.4.3
To: detlev@offenbach.fs.uunet.de (Detlev Offenbach)
Date: Sat, 14 Apr 2001 15:25:10 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <01041411451300.01534@majestix> from "Detlev Offenbach" at Apr 14, 2001 11:45:13 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14oQzA-00050l-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > This is a bug in the scsi layer. linux-scsi@vger.kernel.org, not that any
> > of the scsi maintainers seem to care about it right now.
> 
> Does this mean I can forget about using kernel 2.4.x? :-(( Can you give me a 
> hint where to look. Maybe I can fix it myself.

The FAT layer asks for a 512 byte block, the scsi layer in 2.2 would then 
reblock the data to handle this internally. In 2.4 the scsi layer errors this
then all the error handling gets tangled up (and doesnt work) and the machine
oopses.

So you either need to teach lots of file systems about handling blocks that
are smaller than the physical layer, or the block layer to do reblocking in
some cases (at an obvious performance hit).

And someone needs to fix the error handling so it errors rather than exploding

