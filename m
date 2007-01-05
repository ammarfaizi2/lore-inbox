Return-Path: <linux-kernel-owner+w=401wt.eu-S1030360AbXAEHWr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030360AbXAEHWr (ORCPT <rfc822;w@1wt.eu>);
	Fri, 5 Jan 2007 02:22:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030362AbXAEHWr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Jan 2007 02:22:47 -0500
Received: from brick.kernel.dk ([62.242.22.158]:13251 "EHLO kernel.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030360AbXAEHWq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Jan 2007 02:22:46 -0500
Date: Fri, 5 Jan 2007 08:23:05 +0100
From: Jens Axboe <jens.axboe@oracle.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, Nick Piggin <npiggin@suse.de>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       Neil Brown <neilb@suse.de>, Mark Fasheh <mark.fasheh@oracle.com>,
       "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Subject: Re: [PATCH] 4/4 block: explicit plugging
Message-ID: <20070105072305.GN11203@kernel.dk>
References: <11678105083001-git-send-email-jens.axboe@oracle.com> <1167810508576-git-send-email-jens.axboe@oracle.com> <459C8427.9040704@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <459C8427.9040704@yahoo.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 04 2007, Nick Piggin wrote:
> Jens Axboe wrote:
> >Nick writes:
> >
> >This is a patch to perform block device plugging explicitly in the 
> >submitting
> >process context rather than implicitly by the block device.
> 
> Hi Jens,
> 
> Hey thanks for doing so much hard work with this, I couldn't have fixed
> all the block layer stuff myself. QRCU looks like a good solution for the
> barrier/sync operations (/me worried that one wouldn't exist), and a
> novel use of RCU!
> 
> The only thing I had been thinking about before it is ready for primetime
> -- as far as the VM side of things goes -- is whether we should change
> the hard calls to address_space operations, such that they might be
> avoided or customised when there is no backing block device?
> 
> I'm sure the answer to this is "yes", so I have an idea for a simple
> implementation... but I'd like to hear thoughts from network fs / raid
> people?

I suppose that would be the proper thing to do, for non __make_request()
operated backing devices. I'll add the hooks, then we can cook up a raid
implementation if need be.

-- 
Jens Axboe

