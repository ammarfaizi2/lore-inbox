Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262946AbTEGH2x (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 03:28:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262955AbTEGH2x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 03:28:53 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:26245 "EHLO
	imladris.demon.co.uk") by vger.kernel.org with ESMTP
	id S262946AbTEGH2w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 03:28:52 -0400
Subject: Re: [PATCH] Only use MSDOS-Partitions by default on X86
From: David Woodhouse <dwmw2@infradead.org>
To: Jens Axboe <axboe@suse.de>
Cc: Nicolas Pitre <nico@cam.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Russell King <rmk@arm.linux.org.uk>,
       =?ISO-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>,
       Marcus Meissner <meissner@suse.de>, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20030507072237.GW905@suse.de>
References: <20030506183010.GK905@suse.de>
	 <Pine.LNX.4.44.0305061436510.11648-100000@xanadu.home>
	 <20030506184914.GL905@suse.de>
	 <1052254888.7532.58.camel@imladris.demon.co.uk>
	 <20030507072237.GW905@suse.de>
Content-Type: text/plain
Organization: 
Message-Id: <1052293277.10965.14.camel@imladris.demon.co.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5.dwmw2) 
Date: Wed, 07 May 2003 08:41:17 +0100
Content-Transfer-Encoding: 7bit
X-SA-Exim-Rcpt-To: axboe@suse.de, nico@cam.org, alan@lxorguk.ukuu.org.uk, rmk@arm.linux.org.uk, joern@wohnheim.fh-wedel.de, meissner@suse.de, linux-kernel@vger.kernel.org
X-SA-Exim-Scanned: No; SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-05-07 at 08:22, Jens Axboe wrote:
> > That's a little short of what I was intending. Ideally we stick 'struct
> > request', 'struct buffer_head' and 'struct bio' inside #ifdef
> > CONFIG_BLK_DEV, then kill all the dead code which uses them.
> 
> struct request can be a goner with my patch, the others not really.
> request is really a block private property, so it's easy to kill off.
> You are going for the really minimal approach, basically ruling out lots
> of filesystems and requiring major surgery all around. While I can see
> that make sense for an embedded kernel, I'm having a hard time
> envisioning this as something mergable :-)

Last time I looked, it wasn't that bad until I got mired in VM code.
I haven't looked at that since we got CONFIG_SWAP, but I'm fairly sure
the VM bits will be a lot nicer now too.

> > mtdblock.c cleanup noted with interest -- I'll play with that shortly;
> > thanks. Note that you don't actually need flash hardware, you can load
> > the 'mtdram' device which fakes it with vmalloc-backed storage instead.
> > Not too useful for powerfail-testing but for mounting something like
> > ext2 on mtdblock on mtdram it's fine.
> 
> I'm attaching an updated version, I don't think it's safe to use atomic
> kmaps across the do_cached_read/write.

It's not -- the flash read/write/erase functions may sleep.

> Also, I want bio_endio() to increment the sector position of the bio as
> well. Makes for a nicer api, and the sector var in mtdblock would then
> be killable.

OK. Let me know when you're done and I'll fix up FTL and NFTL
accordingly too.

-- 
dwmw2


