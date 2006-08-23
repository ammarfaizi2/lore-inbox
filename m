Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932438AbWHWMIM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932438AbWHWMIM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 08:08:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932439AbWHWMIL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 08:08:11 -0400
Received: from brick.kernel.dk ([62.242.22.158]:44595 "EHLO kernel.dk")
	by vger.kernel.org with ESMTP id S932438AbWHWMIJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 08:08:09 -0400
Date: Wed, 23 Aug 2006 14:10:28 +0200
From: Jens Axboe <axboe@suse.de>
To: Andi Kleen <ak@suse.de>
Cc: Akinobu Mita <mita@miraclelinux.com>, akpm@osdl.org, okuji@enbug.org,
       linux-kernel@vger.kernel.org
Subject: Re: [patch 4/5] fail-injection capability for disk IO
Message-ID: <20060823121028.GE5893@suse.de>
References: <20060823113243.210352005@localhost.localdomain> <20060823113317.722640313@localhost.localdomain> <p73lkpf64gh.fsf@verdi.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <p73lkpf64gh.fsf@verdi.suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 23 2006, Andi Kleen wrote:
> Akinobu Mita <mita@miraclelinux.com> writes:
> >   * @bio:  The bio describing the location in memory and on the device.
> > @@ -3077,6 +3093,9 @@ end_io:
> >  		if (unlikely(test_bit(QUEUE_FLAG_DEAD, &q->queue_flags)))
> >  			goto end_io;
> >  
> > +		if (should_fail(fail_make_request, bio->bi_size))
> > +			goto end_io;
> 
> AFAIK it is reasonably easy to write stacking block drivers.
> I think I would prefer a stackable driver instead of this hook.

But that makes it more tricky to setup a test, since you have to change
from using /dev/sda (for example) to /dev/stacked-driver.

-- 
Jens Axboe

