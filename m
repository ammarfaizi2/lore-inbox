Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263010AbTDFPeU (for <rfc822;willy@w.ods.org>); Sun, 6 Apr 2003 11:34:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263016AbTDFPeU (for <rfc822;linux-kernel-outgoing>); Sun, 6 Apr 2003 11:34:20 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:18560 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S263010AbTDFPeU (for <rfc822;linux-kernel@vger.kernel.org>); Sun, 6 Apr 2003 11:34:20 -0400
From: John Bradford <john@grabjohn.com>
Message-Id: <200304061547.h36FlvbL000563@81-2-122-30.bradfords.org.uk>
Subject: Re: [PATCH] take 48-bit lba a bit further
To: alan@lxorguk.ukuu.org.uk (Alan Cox)
Date: Sun, 6 Apr 2003 16:47:57 +0100 (BST)
Cc: axboe@suse.de, linux-kernel@vger.kernel.org
In-Reply-To: <1049639724.962.7.camel@dhcp22.swansea.linux.org.uk> from "Alan Cox" at Apr 06, 2003 03:35:25 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Then, don't we want to be using 48-bit lba all the time on compatible devices
> > instead of falling back to 28-bit when possible to save a small amount of
> > instruction overhead?  (Or is that what we're doing already?  I haven't really
> > had the time to follow this thread).
> 
> The overhead of the double load of the command registers is microseconds so it
> is actually quite a lot, especially since IDE lacks TCQ so neither end of the
> link is doing *anything* useful. SCSI has similar problems on older SCSI with 
> command sending being slow, but the drive is at least doing other commands during
> this.

So, say you have a choice of either a 256Kb request to a low block number,
which can use the faster 28-bit mode, or a 512Kb request to the same low block
number, which can only be made using 48-bit LBA, which is the best to use?

I originally thought that we might only be honouring 512Kb requests for blocks
over the 28-bit limit, which Jens corrected me on, but maybe we *should* only
do 512Kb requests on high block number, where we have to use 48-bit anyway.

John.
