Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268961AbUIHOi0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268961AbUIHOi0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 10:38:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269154AbUIHOiL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 10:38:11 -0400
Received: from the-village.bc.nu ([81.2.110.252]:17576 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S268961AbUIHOhd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 10:37:33 -0400
Subject: Re: bug in md write barrier support?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jens Axboe <axboe@suse.de>
Cc: Neil Brown <neilb@cse.unsw.edu.au>, Christoph Hellwig <hch@lst.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20040908092309.GD2258@suse.de>
References: <20040903172414.GA6771@lst.de>
	 <16697.4817.621088.474648@cse.unsw.edu.au> <20040904082121.GB2343@suse.de>
	 <16699.48946.29579.495180@cse.unsw.edu.au>  <20040908092309.GD2258@suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1094650500.11723.32.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 08 Sep 2004 14:35:01 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2004-09-08 at 10:23, Jens Axboe wrote:
> That is correct. The current definition is to ensure that previously
> sent writes are on disk. I hope to tie a range to it in the future, for
> devices that can optimize the flush in that case. So for ide with write
> back caching, it's currently a FLUSH_CACHE command. Ditto for SCSI. SCSI
> with write through cache can make it a noop as well.

Some semantics questions I have thinking about it from the I2O and
aacraid side: You talk about it as a barrier. Can other I/O cross the
cache flush ? In other words if I issue a flush_cache and continue doing
I/O the flush will finish when the I/O outstanding at that time has
completed but other I/O may get scheduled to disk first.

Secondly what are the intended semantics for a flush error ?


