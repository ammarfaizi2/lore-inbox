Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263033AbTDFQbg (for <rfc822;willy@w.ods.org>); Sun, 6 Apr 2003 12:31:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263035AbTDFQbg (for <rfc822;linux-kernel-outgoing>); Sun, 6 Apr 2003 12:31:36 -0400
Received: from vana.vc.cvut.cz ([147.32.240.58]:56713 "EHLO vana.vc.cvut.cz")
	by vger.kernel.org with ESMTP id S263033AbTDFQbg (for <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Apr 2003 12:31:36 -0400
Date: Sun, 6 Apr 2003 18:43:06 +0200
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: Jens Axboe <axboe@suse.de>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] take 48-bit lba a bit further
Message-ID: <20030406164306.GC8303@vana.vc.cvut.cz>
References: <20030406130737.GL786@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030406130737.GL786@suse.de>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 06, 2003 at 03:07:37PM +0200, Jens Axboe wrote:
> Hi,
> 
> Thanks for taking the previous bit Alan, here's an incremental update to
> 2.5.66-ac2. Just cleans up the 'when to use 48-bit lba' logic a bit per
> Andries suggestion, and also expands the request size for 48-bit lba
> capable drives to 512KiB.
> 
> Works perfectly in testing here, ext2/3 generates nice big 512KiB
> requests and the drive flies.
> 
>  	(void) probe_lba_addressing(drive, 1);
>  
> +	if (drive->addressing)
> +		blk_queue_max_sectors(&drive->queue, 1024);
> +

Should not you honor host's max queue length? siimage & pdc4030 sets
max_sectors to 128 (resp. 16 resp. 127), while you overwrite it here
unconditionally with 1024.
					Thanks,
						Petr Vandrovec
						vandrove@vc.cvut.cz

