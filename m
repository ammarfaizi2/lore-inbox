Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264254AbUEXLrS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264254AbUEXLrS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 May 2004 07:47:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264255AbUEXLrS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 May 2004 07:47:18 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:25834 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S264254AbUEXLrL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 May 2004 07:47:11 -0400
Date: Mon, 24 May 2004 13:46:50 +0200
From: Jens Axboe <axboe@suse.de>
To: "Peter J. Braam" <braam@clusterfs.com>
Cc: torvalds@osdl.org, akpm@osdl.org, linux-kernel@vger.kernel.org,
       "'Phil Schwan'" <phil@clusterfs.com>
Subject: Re: [PATCH/RFC] Lustre VFS patch
Message-ID: <20040524114650.GV1952@suse.de>
References: <20040524114009.96CE13100E2@moraine.clusterfs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040524114009.96CE13100E2@moraine.clusterfs.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 24 2004, Peter J. Braam wrote:
> dev_read_only-vanilla-2.6.patch
>  
>   This introduces an ioctl on block devices to stop doing I/O. The
>   only purpose of the patch is automated recovery regression testing,
>   it is very convenient to have this available.

You still keep pushing this on, without having clarified why you can't
just use the genhd functions for this instead of adding some array of
block_devices. And while you fixed the bio->bi_rw check, you still don't
indicate error when you call bio_endio() for this case. So submitter of
that io thinks it completes successfully, while you just tossed it away.
Irk.

-- 
Jens Axboe

