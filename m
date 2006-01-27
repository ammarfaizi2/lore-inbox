Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422662AbWA0WzJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422662AbWA0WzJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 17:55:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422664AbWA0Wyl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 17:54:41 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:8973 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1422660AbWA0Wyg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 17:54:36 -0500
Date: Fri, 27 Jan 2006 22:54:28 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Jens Axboe <axboe@suse.de>
Cc: Pierre Ossman <drzeus-list@drzeus.cx>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: How to map high memory for block io
Message-ID: <20060127225428.GD2767@flint.arm.linux.org.uk>
Mail-Followup-To: Jens Axboe <axboe@suse.de>,
	Pierre Ossman <drzeus-list@drzeus.cx>,
	LKML <linux-kernel@vger.kernel.org>
References: <43D9F705.5000403@drzeus.cx> <20060127104321.GE4311@suse.de> <43DA0E97.5030504@drzeus.cx> <20060127194318.GA1433@flint.arm.linux.org.uk> <43DA7CD1.4040301@drzeus.cx> <20060127201458.GA2767@flint.arm.linux.org.uk> <20060127202206.GH9068@suse.de> <20060127202646.GC2767@flint.arm.linux.org.uk> <43DA84B2.8010501@drzeus.cx> <43DA97A3.4080408@drzeus.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43DA97A3.4080408@drzeus.cx>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 27, 2006 at 10:58:59PM +0100, Pierre Ossman wrote:
> Test done here, few minutes ago. Added this to the wbsd driver in its
> kmap routine:
> 
>     if ((host->cur_sg->offset + host->cur_sg->length) > PAGE_SIZE)
>         printk(KERN_DEBUG "wbsd: Big sg: %d, %d\n",
>             host->cur_sg->offset, host->cur_sg->length);
> 
> got:
> 
> [17385.425389] wbsd: Big sg: 0, 8192
> [17385.436849] wbsd: Big sg: 0, 7168
> [17385.436859] wbsd: Big sg: 0, 7168
> [17385.454029] wbsd: Big sg: 2560, 5632
> [17385.454216] wbsd: Big sg: 2560, 5632

Jens - what's going on?  These look like invalid sg entries to me.

If they are supposed to be like that, there will be additional problems
for block drivers ensuring cache coherency on PIO.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
