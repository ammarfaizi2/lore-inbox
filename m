Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132933AbRDEPjL>; Thu, 5 Apr 2001 11:39:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132932AbRDEPi7>; Thu, 5 Apr 2001 11:38:59 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:38668 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S132933AbRDEPiZ>;
	Thu, 5 Apr 2001 11:38:25 -0400
Date: Thu, 5 Apr 2001 17:37:31 +0200
From: Jens Axboe <axboe@suse.de>
To: "Heinz J. Mauelshagen" <Mauelshagen@Sistina.com>
Cc: Herbert Valerio Riedel <hvr@hvrlab.org>, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@transmeta.com>,
        linux-lvm-patch@EZ-Darmstadt.Telekom.de
Subject: Re: /dev/loop0 over lvm... leading to d-state :-(
Message-ID: <20010405173731.C5187@suse.de>
In-Reply-To: <Pine.LNX.4.30.0104042152490.1183-100000@janus.txd.hvrlab.org> <20010405071313.A418@suse.de> <20010405163818.M418@suse.de> <20010405164942.N418@suse.de> <20010405163239.F6981@sistina.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010405163239.F6981@sistina.com>; from Mauelshagen@Sistina.com on Thu, Apr 05, 2001 at 04:32:39PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 05 2001, Heinz J. Mauelshagen wrote:
> > Irks, another one. lvm_make_request_fn also needs to call b_end_io
> > if a map fails.
> 
> This is wrong.
> 
> In case of an io error we do already call buffer_IO_error() on 2.4 in
> lvm_map().

Where? Calling buffer_IO_error would be ok, but there are no such calls
in 2.4.3. I just stated elsewhere that submit_bh should probably be
clearing the dirty bit, not ll_rw_block, in which case the b_end_io
is fine. But buffer_IO_error is probably more clear. I trust you'll
take care of that part then.

-- 
Jens Axboe

