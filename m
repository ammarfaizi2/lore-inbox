Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261682AbTDFNVW (for <rfc822;willy@w.ods.org>); Sun, 6 Apr 2003 09:21:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261693AbTDFNVW (for <rfc822;linux-kernel-outgoing>); Sun, 6 Apr 2003 09:21:22 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:63469 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261682AbTDFNVV (for <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Apr 2003 09:21:21 -0400
Date: Sun, 6 Apr 2003 15:32:50 +0200
From: Jens Axboe <axboe@suse.de>
To: John Bradford <john@grabjohn.com>
Cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] take 48-bit lba a bit further
Message-ID: <20030406133250.GN786@suse.de>
References: <20030406130737.GL786@suse.de> <200304061332.h36DWnaD000165@81-2-122-30.bradfords.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200304061332.h36DWnaD000165@81-2-122-30.bradfords.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 06 2003, John Bradford wrote:
> > Thanks for taking the previous bit Alan, here's an incremental update to
> > 2.5.66-ac2. Just cleans up the 'when to use 48-bit lba' logic a bit per
> > Andries suggestion, and also expands the request size for 48-bit lba
> > capable drives to 512KiB.
> > 
> > Works perfectly in testing here, ext2/3 generates nice big 512KiB
> > requests and the drive flies.
> 
> Then, don't we want to be using 48-bit lba all the time on compatible devices
> instead of falling back to 28-bit when possible to save a small amount of
> instruction overhead?  (Or is that what we're doing already?  I haven't really
> had the time to follow this thread).

The logic in the patch is to enable large requests _if_ the drive can do
48-bit lba. However, we will only use 48-bit lba commands if the request
is either beyond 2^28 sectors _or_ bigger than 256 sectors since neither
of these can be addressed with 28-bit lba.

See rq_lba48 in the patch, it explains it.

-- 
Jens Axboe

