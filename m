Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965055AbVJUSGY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965055AbVJUSGY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Oct 2005 14:06:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965052AbVJUSGY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Oct 2005 14:06:24 -0400
Received: from verein.lst.de ([213.95.11.210]:15041 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S965051AbVJUSGX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Oct 2005 14:06:23 -0400
Date: Fri, 21 Oct 2005 20:04:55 +0200
From: Christoph Hellwig <hch@lst.de>
To: Luben Tuikov <luben_tuikov@adaptec.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, andrew.patterson@hp.com,
       Christoph Hellwig <hch@lst.de>,
       "Moore, Eric Dean" <Eric.Moore@lsil.com>, jejb@steeleye.com,
       linux-scsi@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: ioctls, etc. (was Re: [PATCH 1/4] sas: add flag for locally attached PHYs)
Message-ID: <20051021180455.GA6834@lst.de>
References: <91888D455306F94EBD4D168954A9457C048F0E34@nacos172.co.lsil.com> <20051020160155.GA14296@lst.de> <4357CB03.4020400@adaptec.com> <20051020170330.GA16458@lst.de> <4357F7DE.7050004@adaptec.com> <1129852879.30258.137.camel@bluto.andrew> <43583A53.2090904@pobox.com> <435929FD.4070304@adaptec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <435929FD.4070304@adaptec.com>
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 21, 2005 at 01:48:45PM -0400, Luben Tuikov wrote:
> > why James has suggested implementing SMP as a block driver.  People get 
> > stuck into thinking "block driver == block device", which is wrong.  The 

                     ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

> > Linux block layer is nothing but a message queueing interface.
> 
> Now, just because James suggested implementing the SMP service as a block
> device you think this is the right thing to do?
> 
> How about this: Why not as a char device?

you can implement a char device using the block layer.  See
drivers/scsi/{ch.c,osst.c,sg.c,st.c} for examples.

That beeing said I tried this approach.  It looks pretty cool when you
think about it, but the block layer is quite a bit too heavyweight for
queueing up a few SMP requests, and we need to carry too much useless
code around for it.
