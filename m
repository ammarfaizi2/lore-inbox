Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262186AbUKKHua@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262186AbUKKHua (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Nov 2004 02:50:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262187AbUKKHua
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Nov 2004 02:50:30 -0500
Received: from fw.osdl.org ([65.172.181.6]:1748 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262186AbUKKHuZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Nov 2004 02:50:25 -0500
Date: Wed, 10 Nov 2004 23:50:14 -0800
From: Andrew Morton <akpm@osdl.org>
To: Jens Axboe <axboe@suse.de>
Cc: ncunningham@linuxmail.org, wli@holomorphy.com,
       linux-kernel@vger.kernel.org
Subject: Re: Broken kunmap calls in rc4-mm1.
Message-Id: <20041110235014.1eeb13bb.akpm@osdl.org>
In-Reply-To: <20041111074509.GD9129@suse.de>
References: <1100135825.7402.32.camel@desktop.cunninghams>
	<20041111012919.GD3217@holomorphy.com>
	<1100137328.7402.45.camel@desktop.cunninghams>
	<20041110185925.1c2eb9bf.akpm@osdl.org>
	<20041111074509.GD9129@suse.de>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe <axboe@suse.de> wrote:
>
> On Wed, Nov 10 2004, Andrew Morton wrote:
> > Nigel Cunningham <ncunningham@linuxmail.org> wrote:
> > >
> > > Remaining culprits are....
> > > 
> > >  Reiser4:
> > >  - do_readpage_tail
> > >   -reiser4_status_init
> > >   -reiser4_status_write
> > 
> > obuggerit.  Look, a simple helper is to redefine kmap_atomic() and
> > kunmap_atomic() to work on char*'s.  This will spit warnings if someone
> > feeds in a page*.  Which would be a lot more useful if we didn't have all
> > those infernal __iomem warnings scrolling off the screen but ho hum.
> 
> I tried something like this, but got stuck on people passing a structure
> in which is valid (aio_setup_ring(), for instance). We can always cast
> those of course, but it's not so pretty.

yup, that's what I did.  It's not too bad, apart from cachefs which has
gone kmap nutso.
