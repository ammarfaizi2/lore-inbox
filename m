Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131271AbRCRVhw>; Sun, 18 Mar 2001 16:37:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131273AbRCRVhn>; Sun, 18 Mar 2001 16:37:43 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:26377 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S131271AbRCRVhi>;
	Sun, 18 Mar 2001 16:37:38 -0500
Date: Sun, 18 Mar 2001 22:35:58 +0100
From: Jens Axboe <axboe@suse.de>
To: Paul Gortmaker <p_gortmaker@yahoo.com>
Cc: torvalds@transmeta.com, alan@lxorguk.ukuu.org.uk, andre@linux-ide.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] off-by-1 error in ide-probe (2.4.x)
Message-ID: <20010318223558.L29105@suse.de>
In-Reply-To: <3AB47DA4.795B609B@yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3AB47DA4.795B609B@yahoo.com>; from p_gortmaker@yahoo.com on Sun, Mar 18, 2001 at 04:19:32AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 18 2001, Paul Gortmaker wrote:
> There is a potentially serious bug in ide-probe.c in which max_sectors
> is set to 256 instead of 255.  I am surprised that this hasn't bit anyone
> else yet.  Perhaps because you need a disk that is slow in comparison to 
> the host in order for the queue to climb up to and then hit the 256, at
> which point it then falls over.  

You don't need a slow disk, it's trivial to provoke 256 sector sized
request on even the fastest disk available. People hit it all the time,
just with working drives...

> For example, with an old 700MB Maxtor on a "fast" 486, VL-bus, PIO, 
> hdparm -c1 -m8 -u1, I could pretty much on demand generate the following 
> error by multiple builds, or by the final linking of any big project:

The 256 is _not_ a bug in the driver, it's more likely a bug in your
drive. 256 is a perfectly legal transfer size. That said, maybe it is
a good idea to leave it at 255 just for safety on drives not handling
0 sectors == 128kB transfer.

-- 
Jens Axboe

