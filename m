Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262252AbTE2NzW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 May 2003 09:55:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262253AbTE2NzW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 May 2003 09:55:22 -0400
Received: from c17870.thoms1.vic.optusnet.com.au ([210.49.248.224]:24511 "EHLO
	mail.kolivas.org") by vger.kernel.org with ESMTP id S262252AbTE2NzV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 May 2003 09:55:21 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Willy Tarreau <willy@w.ods.org>, Andrea Arcangeli <andrea@suse.de>
Subject: Re: 2.4.20: Proccess stuck in __lock_page ...
Date: Fri, 30 May 2003 00:09:37 +1000
User-Agent: KMail/1.5.1
Cc: Andrew Morton <akpm@digeo.com>,
       Matthias Mueller <matthias.mueller@rz.uni-karlsruhe.de>, axboe@suse.de,
       m.c.p@wolk-project.de, manish@storadinc.com, marcelo@conectiva.com.br,
       linux-kernel@vger.kernel.org
References: <3ED2DE86.2070406@storadinc.com> <20030529132431.GK1453@dualathlon.random> <20030529135508.GC21673@alpha.home.local>
In-Reply-To: <20030529135508.GC21673@alpha.home.local>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200305300009.37207.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 May 2003 23:55, Willy Tarreau wrote:
> Hello !
>
> I've done a few tests with -rc6 on my dev machine (dual xp 1.5G, 512 MB,
> scsi). It's the *FIRST* time I have ever seen my mouse cursor hang (just a
> little bit however, and totally acceptable) ! Usually, my kernel include
> -aa VM and lowlat patches, and I've never encountered this behaviour on
> this machine with such a configuration. However, with stock kernel, I admit
> that during the 2 minutes it takes to write the 2G file, I see the mouse
> stick two or three times during about 1 second, which is quite acceptable
> IMHO. Opening an xterm may take 10s to get to the prompt (more annoying).
> Same to launch 'ps'.
>
> I use a fairly simple window manager (ctwm), which doesn't access the disk
> once it's launched. It never gets stuck during all the operation if I
> disable the swap. If I enable the swap, it sometimes takes one or two
> seconds to draw a menu. The swap is used up to about 4 MB.
>
> I then tried -rc6 with ll_rw_blk from -rc5, and it's worse, even with swap
> disabled. The hangs happen more often, but are about the same durations. So
> I confirm that -rc6 is better here than -rc5.
>
> I retried with rc4aa1, and everything went very smooth again ; it takes at
> most 1 second to get an xterm with the prompt ready, and ps responds
> immediately. So I think that there are two things here:
>   - those who experience very long hangs may use a heavy window manager
>     which does continuous disk accesses (I mean it accesses the disk for
> any simple operation).
>   - a hungry WM may also be swapped during such operations, rendering it
>     totally unusable, particularly if the swap is on the same physical disk
>     as the file being written to.
>
> So, could the people who report long hangs retry with swap disabled ?
> Can we limit the amount of memory consummed by the cache during such a
> write ?

I still get hangs with rc6 with massive writeouts to swap. The problem was 
that I was getting hangs without writeouts to swap with 2.4.19pre1 
->2.4.21pre5. I didn't expect the patch backout to suddenly make writing to 
swap occur for free (although that would be nice).

Con
