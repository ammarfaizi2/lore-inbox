Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262120AbVATLUJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262120AbVATLUJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jan 2005 06:20:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262121AbVATLUJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jan 2005 06:20:09 -0500
Received: from hirsch.in-berlin.de ([192.109.42.6]:3234 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S262120AbVATLUE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jan 2005 06:20:04 -0500
X-Envelope-From: kraxel@bytesex.org
Date: Thu, 20 Jan 2005 12:12:27 +0100
From: Gerd Knorr <kraxel@bytesex.org>
To: linux-kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: bttv/v4l2/Linux 2.6.10-ac8: xawtv hanging in videobuf_waiton
Message-ID: <20050120111227.GE10029@bytesex>
References: <20050110000043.GA9549@m.safari.iki.fi> <871xct1pq2.fsf@bytesex.org> <20050110161821.GA5561@m.safari.iki.fi> <20050114032226.GB6032@m.safari.iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050114032226.GB6032@m.safari.iki.fi>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> About 100 pixels from my windowmaker background got garbled (I also ran
> xrefresh) while panicking ;-> and "rpm -V mozilla" showed three modified
> libs.

> However, the libs were OK after reboot (maybe because no time for syncing),
> but reiserfsck found vpf-10640 error for /var partition.

Thats typical for page cache corruption.  The libs are read-only data
and thus never ever flushed back to disk, thus a reboot will fix it.
Creating some memory pressure to make the kernel drop the corrupted
pages from the cache should make it go away as well.

> How to debug this kind of memory corruption?
> 
> garbled by bttv:
> 
> 0035b000  08 00 00 14 00 c0 35 0a  f8 03 00 18 08 cc 35 0a  |......5.......5.|
> 0035b010  08 08 00 14 00 50 0a 03  f8 0b 00 18 08 64 88 0a  |.....P.......d..|

Could be bt878 risc code.  No idea how this makes it into the mozilla
libs ...

  Gerd

-- 
#define printk(args...) fprintf(stderr, ## args)
