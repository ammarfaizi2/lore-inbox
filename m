Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262185AbUKKHqD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262185AbUKKHqD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Nov 2004 02:46:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262186AbUKKHqD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Nov 2004 02:46:03 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:53962 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262185AbUKKHp6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Nov 2004 02:45:58 -0500
Date: Thu, 11 Nov 2004 08:45:10 +0100
From: Jens Axboe <axboe@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: ncunningham@linuxmail.org, wli@holomorphy.com,
       linux-kernel@vger.kernel.org
Subject: Re: Broken kunmap calls in rc4-mm1.
Message-ID: <20041111074509.GD9129@suse.de>
References: <1100135825.7402.32.camel@desktop.cunninghams> <20041111012919.GD3217@holomorphy.com> <1100137328.7402.45.camel@desktop.cunninghams> <20041110185925.1c2eb9bf.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041110185925.1c2eb9bf.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 10 2004, Andrew Morton wrote:
> Nigel Cunningham <ncunningham@linuxmail.org> wrote:
> >
> > Remaining culprits are....
> > 
> >  Reiser4:
> >  - do_readpage_tail
> >   -reiser4_status_init
> >   -reiser4_status_write
> 
> obuggerit.  Look, a simple helper is to redefine kmap_atomic() and
> kunmap_atomic() to work on char*'s.  This will spit warnings if someone
> feeds in a page*.  Which would be a lot more useful if we didn't have all
> those infernal __iomem warnings scrolling off the screen but ho hum.

I tried something like this, but got stuck on people passing a structure
in which is valid (aio_setup_ring(), for instance). We can always cast
those of course, but it's not so pretty.

-- 
Jens Axboe

