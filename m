Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966417AbWLDUnL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966417AbWLDUnL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 15:43:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937379AbWLDUnK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 15:43:10 -0500
Received: from brick.kernel.dk ([62.242.22.158]:25136 "EHLO kernel.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S937362AbWLDUnJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 15:43:09 -0500
Date: Mon, 4 Dec 2006 21:43:51 +0100
From: Jens Axboe <jens.axboe@oracle.com>
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] speed up single bio_vec allocation
Message-ID: <20061204204351.GO4392@kernel.dk>
References: <20061204200645.GN4392@kernel.dk> <000601c717e3$f098a8a0$2589030a@amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000601c717e3$f098a8a0$2589030a@amr.corp.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 04 2006, Chen, Kenneth W wrote:
> > [...]
> > 
> > Another idea would be to kill SLAB_HWCACHE_ALIGN (it's pretty pointless,
> > I bet), and always alloc sizeof(*bio) + sizeof(*bvl) in one go when a
> > bio is allocated. It doesn't add a lot of overhead even for the case
> > where we do > 1 page bios, and it gets rid of the dual allocation for
> > the 1 page bio.
> 
> I will try that too.  I'm a bit touchy about sharing a cache line for
> different bio.  But given that there are 200,000 I/O per second we are
> currently pushing the kernel, the chances of two cpu working on two
> bio that sits in the same cache line are pretty small.

Yep I really think so. Besides, it's not like we are repeatedly writing
to these objects in the first place.

-- 
Jens Axboe

