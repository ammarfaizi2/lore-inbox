Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129694AbRCCTZ2>; Sat, 3 Mar 2001 14:25:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129686AbRCCTZT>; Sat, 3 Mar 2001 14:25:19 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:39954 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S129696AbRCCTZH>;
	Sat, 3 Mar 2001 14:25:07 -0500
Date: Sat, 3 Mar 2001 20:24:58 +0100
From: Jens Axboe <axboe@suse.de>
To: agrawal@ais.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: lingering loopback bugs?
Message-ID: <20010303202458.L2528@suse.de>
In-Reply-To: <E14Yyrs-0002Wz-00@the-village.bc.nu> <Pine.LNX.4.10.10103031303220.15395-100000@SLASH.REM.CMU.EDU>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.10.10103031303220.15395-100000@SLASH.REM.CMU.EDU>; from agrawal@ais.org on Sat, Mar 03, 2001 at 03:16:02PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 03 2001, agrawal@ais.org wrote:
> 
> I have an encrypted filesystem mounted over loopback that I created under
> a 2.2.16 kernel. (Using AES, 128 bit key.) Works fine in 2.2.16. Sort of
> works under the unpatched 2.4 series. (Mounts okay, but hangs the system
> on random blocks.)
> 
> Under various 2.4 kernels with Jens' patched, the filesystem fails to
> mount. I've tried 2.4.2-loop6, 2.4.2-ac6, and 2.4.2-ac8. All give the same
> result. 

Look for the patch I posted yesterday (hint: just remove these two
lines from loop_end_io_transfer)

               if (atomic_dec_and_test(&lo->lo_pending))
                       up(&lo->lo_bh_mutex);

-- 
Jens Axboe

