Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267553AbUIPGDg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267553AbUIPGDg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 02:03:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267554AbUIPGDg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 02:03:36 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:16056 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S267553AbUIPGDe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 02:03:34 -0400
Date: Thu, 16 Sep 2004 07:56:51 +0200
From: Jens Axboe <axboe@suse.de>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: "Jeff V. Merkey" <jmerkey@drdos.com>, jmerkey@galt.devicelogics.com,
       linux-kernel@vger.kernel.org, jmerkey@comcast.net
Subject: Re: 2.6.8.1 mempool subsystem sickness
Message-ID: <20040916055650.GE2300@suse.de>
References: <091420042058.15928.41475B8000002BA100003E382200763704970A059D0A0306@comcast.net> <4147555C.7010809@drdos.com> <414777EA.5080406@yahoo.com.au> <20040914223122.GA3325@galt.devicelogics.com> <41478419.3020606@yahoo.com.au> <41487B6D.1080202@drdos.com> <4148F059.9060100@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4148F059.9060100@yahoo.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 16 2004, Nick Piggin wrote:
> Jeff V. Merkey wrote:
> >Jeff
> >
> >Here's the stats from the test of the patch against 2.6.8-rc2 with the 
> >patch applied
> >
> >
> 
> Scanning stats look good at a quick glance. kswapd doesn't seem to be
> going crazy.
> 
> However,
> size-65536         32834  32834  65536    1   16
> 
> This slab entry is taking up about 2GB of unreclaimable memory (order-4,
> no less). This must be a leak... does the number continue to rise as
> your system runs?

There's also a huge amount of 16-page bio + vecs in flight:

biovec-16         131340

That would point to a leak as well, most likely.

-- 
Jens Axboe

