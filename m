Return-Path: <linux-kernel-owner+w=401wt.eu-S932789AbWLNUWU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932789AbWLNUWU (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 15:22:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932827AbWLNUWT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 15:22:19 -0500
Received: from brick.kernel.dk ([62.242.22.158]:4226 "EHLO kernel.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932790AbWLNUWS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 15:22:18 -0500
Date: Thu, 14 Dec 2006 21:23:44 +0100
From: Jens Axboe <jens.axboe@oracle.com>
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Cc: "'linux-kernel'" <linux-kernel@vger.kernel.org>
Subject: Re: [patch] speed up single bio_vec allocation
Message-ID: <20061214202343.GK5010@kernel.dk>
References: <000001c71b16$4ca91b90$d134030a@amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000001c71b16$4ca91b90$d134030a@amr.corp.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 08 2006, Chen, Kenneth W wrote:
> > Chen, Kenneth wrote on Wednesday, December 06, 2006 10:20 AM
> > > Jens Axboe wrote on Wednesday, December 06, 2006 2:09 AM
> > > This is what I had in mind, in case it wasn't completely clear. Not
> > > tested, other than it compiles. Basically it eliminates the small
> > > bio_vec pool, and grows the bio by 16-bytes on 64-bit archs, or by
> > > 12-bytes on 32-bit archs instead and uses the room at the end for the
> > > bio_vec structure.
> > 
> > Yeah, I had a very similar patch queued internally for the large benchmark
> > measurement.  I will post the result as soon as I get it.
> 
> 
> Jens, this improves 0.25% on our db transaction processing benchmark setup.
> The patch tested is (on top of 2.6.19):
> http://marc.theaimsgroup.com/?l=linux-kernel&m=116539972229021&w=2

Ok, well it's not much but if it's significant it's not too bad either
:-)

Some tests I ran locally showed it being _slower_, which is a little
odd. They were basically hammering requests through the block layer with
a null end.

-- 
Jens Axboe

