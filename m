Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261748AbUDCNto (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Apr 2004 08:49:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261746AbUDCNto
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Apr 2004 08:49:44 -0500
Received: from mail.shareable.org ([81.29.64.88]:45718 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S261748AbUDCNtf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Apr 2004 08:49:35 -0500
Date: Sat, 3 Apr 2004 14:49:14 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Jeremy Higdon <jeremy@sgi.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, Nick Piggin <nickpiggin@yahoo.com.au>,
       linux-ide@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] speed up SATA
Message-ID: <20040403134914.GC4706@mail.shareable.org>
References: <406611CA.3050804@pobox.com> <406616EE.80301@pobox.com> <4066191E.4040702@yahoo.com.au> <40662108.40705@pobox.com> <20040328135124.GA32597@mail.shareable.org> <40670A36.3000005@pobox.com> <20040328173623.GA1087@mail.shareable.org> <20040402101108.GA752170@sgi.com> <20040402161149.GA32483@mail.shareable.org> <20040403104826.GA737325@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040403104826.GA737325@sgi.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeremy Higdon wrote:
> > Are you refuting the following assertion by Eric D. Mudama's, based on
> > your measurements?  In other words, are ATA's 32 TCQ slots enough to
> > eliminate the performance advantage of write cacheing?
> 
> I must apologize.  I had thought the context was SCSI, but now I
> see that it is linux-ide.  So please disregard comments about command
> queueing.

We're talking about _with_ TCQ, on serial ATA (SATA) where TCQ is common,
and deliberately disabling the write cache so that TCQ completions
indicate when the data is written.

If your measurements indicate that 32 queue slots is adequate with
SCSI drives to eliminate the overhead of disabling write cacheing,
then that's valuable information.  The drives are basically the same
after all.

> If you have write cache disabled and no TCQ (latter is common,
> former may or may not be), you want to write as big a chunk as you can.

That's a handy insight too.  Personally I hadn't thought about large
requests reducing the rotation latency with write cache disabled.

-- Jamie
