Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271420AbTHMHZr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Aug 2003 03:25:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271423AbTHMHZr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Aug 2003 03:25:47 -0400
Received: from smithers.nildram.co.uk ([195.112.4.34]:2573 "EHLO
	smithers.nildram.co.uk") by vger.kernel.org with ESMTP
	id S271420AbTHMHZq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Aug 2003 03:25:46 -0400
Date: Wed, 13 Aug 2003 08:25:45 +0100
From: Joe Thornber <thornber@sistina.com>
To: Neil Brown <neilb@cse.unsw.edu.au>
Cc: Andrew Morton <akpm@osdl.org>, Tupshin Harper <tupshin@tupshin.com>,
       linux-kernel@vger.kernel.org, Jens Axboe <axboe@suse.de>
Subject: Re: data corruption using raid0+lvm2+jfs with 2.6.0-test3
Message-ID: <20030813072544.GA422@fib011235813.fsnet.co.uk>
References: <3F3951F1.9040605@tupshin.com> <20030812142846.46eacc48.akpm@osdl.org> <16185.29398.80225.875488@gargle.gargle.HOWL>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16185.29398.80225.875488@gargle.gargle.HOWL>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 13, 2003 at 09:05:58AM +1000, Neil Brown wrote:
> A better solution, which is too much for 2.6.0, is to have a cleaner
> interface wherein the client of the block device uses a two-stage
> process to submit requests.
> Firstly it says:
>   I want to do IO at this location, what is the max number of sectors
>   allowed?
> Then it adds pages to the bio upto that limit. 
> Finally it say
>   OK, here is the request.
> 
> The first and final stages have to be properly paired so that a
> device knows if there are any pending requests and can hold-off any
> device reconfiguration until all pending requests have completed.

This is exactly what I'd like to do.  The merge_bvec_fn is unusable by
dm (and probably md) because this function is mapping specific - so
dm_suspend/dm_resume need to be lifted above it.

- Joe
