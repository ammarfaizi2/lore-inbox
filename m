Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270956AbTGPQmX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 12:42:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270955AbTGPQmX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 12:42:23 -0400
Received: from fw.osdl.org ([65.172.181.6]:4527 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S270956AbTGPQmT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 12:42:19 -0400
Date: Wed, 16 Jul 2003 09:49:31 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jens Axboe <axboe@suse.de>
Cc: andrea@suse.de, alan@lxorguk.ukuu.org.uk, marcelo@conectiva.com.br,
       mason@suse.com, linux-kernel@vger.kernel.org, sct@redhat.com,
       jgarzik@pobox.com, viro@math.psu.edu
Subject: Re: RFC on io-stalls patch
Message-Id: <20030716094931.0a5015a5.akpm@osdl.org>
In-Reply-To: <20030716130442.GZ833@suse.de>
References: <Pine.LNX.4.55L.0307140922130.17091@freak.distro.conectiva>
	<20030714131206.GJ833@suse.de>
	<20030714195138.GX833@suse.de>
	<20030714201637.GQ16313@dualathlon.random>
	<20030715052640.GY833@suse.de>
	<1058268126.3857.25.camel@dhcp22.swansea.linux.org.uk>
	<20030715112737.GQ833@suse.de>
	<20030716124355.GE4978@dualathlon.random>
	<20030716124656.GY833@suse.de>
	<20030716125933.GF4978@dualathlon.random>
	<20030716130442.GZ833@suse.de>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe <axboe@suse.de> wrote:
>
> On Wed, Jul 16 2003, Andrea Arcangeli wrote:
> > On Wed, Jul 16, 2003 at 02:46:56PM +0200, Jens Axboe wrote:
> > > Well it's a combined problem. Threshold too high on dirty memory,
> > > someone doing a read well get stuck flushing out as well.
> > 
> > a pure read not. the write throttling should be per-process, then there
> > will be little risk.
> 
> A read from user space, dirtying data along the way.

Actually it's a read from userspace which allocates a page which goes into
direct reclaim which discovers a locked buffer on the tail of the LRU and
then waits on it.

And if he's especially unlucky: while he waits, some other process
continues to pound more writes into the queue which get merged ahead of the
one he's waiting on, up to a point.

(I don't know if 2.6 does much better in this regard.  It is supposed to. 
Has anyone tested for it?)

