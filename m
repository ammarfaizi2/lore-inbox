Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317787AbSGPI3S>; Tue, 16 Jul 2002 04:29:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317789AbSGPI3R>; Tue, 16 Jul 2002 04:29:17 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:970 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S317787AbSGPI3Q>;
	Tue, 16 Jul 2002 04:29:16 -0400
Date: Tue, 16 Jul 2002 10:31:42 +0200
From: Jens Axboe <axboe@suse.de>
To: Andrew Morton <akpm@zip.com.au>
Cc: William Lee Irwin III <wli@holomorphy.com>, linux-kernel@vger.kernel.org
Subject: Re: [BUG] loop.c oopses
Message-ID: <20020716083142.GQ811@suse.de>
References: <20020716062453.GK1022@holomorphy.com> <3D33C64A.7491B591@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D33C64A.7491B591@zip.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 16 2002, Andrew Morton wrote:
> William Lee Irwin III wrote:
> > 
> > loop.c oopses when bio_copy() returns NULL. This was encountered while
> > running dbench 16 on a loopback-mounted reiserfs filesystem.
> 
> ugh.  GFP_NOIO is evil.  I guess it's better to add __GFP_HIGH
> there, but it's not a happy solution.

GFP_NOIO has __GFP_WAIT set, so bio_copy -> bio_alloc -> mempool_alloc
should never fail. Puzzled.

-- 
Jens Axboe

