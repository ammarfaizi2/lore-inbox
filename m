Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314241AbSDRF5W>; Thu, 18 Apr 2002 01:57:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314242AbSDRF5V>; Thu, 18 Apr 2002 01:57:21 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:13068 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S314241AbSDRF5V>;
	Thu, 18 Apr 2002 01:57:21 -0400
Date: Thu, 18 Apr 2002 07:55:17 +0200
From: Jens Axboe <axboe@suse.de>
To: peterc@gelato.unsw.edu.au
Cc: linux-kernel@vger.kernel.org
Subject: Re: A question about ll_10byte_cmd_build
Message-ID: <20020418055517.GD858@suse.de>
In-Reply-To: <E16y1rE-0001Zf-00@redback.cse.unsw.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 18 2002, peterc@gelato.unsw.edu.au wrote:
> 
> 
> (Linux 2.5.8)
> In ll_rw_blk.c there's a function, ll_10byte_cmd_build() which is
> supposed to be used to generate `10-byte commands'.
> 
> It appears to generate a SCSI READ_10 or WRITE_10 command (which
> happen to be identical in format to the ATAPI GPCMD_{READ,WRITE}_10 commands)
> 
> Is this IDE specific, or is it meant to cover all block devices?
> If it's IDE specific, why is it in ll_rw_blk.c, which is meant to be
> common to all block devices?

It's not IDE specific, since when does IDE use packet commands? It's
not ATAPI specific either.

> As far as I can tell, only ide-cd.c actually uses the function in a
> stock 2.5.8 kernel --- so it could theoretically be moved to ide-cd.c.

It's meant to be an example of a generic prep_rq_fn() queue function, a
start the conversion of using struct request as the generic passer of
cdb's. Only ide-cd uses it for now as you see, that's merely because
lots of bits of the infrastructure are still missing.

-- 
Jens Axboe

