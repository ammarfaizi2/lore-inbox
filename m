Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262263AbTE2OZy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 May 2003 10:25:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262267AbTE2OZy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 May 2003 10:25:54 -0400
Received: from mailgate.rz.uni-karlsruhe.de ([129.13.64.97]:29453 "EHLO
	mailgate.rz.uni-karlsruhe.de") by vger.kernel.org with ESMTP
	id S262263AbTE2OZx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 May 2003 10:25:53 -0400
Date: Thu, 29 May 2003 16:38:28 +0200
From: Matthias Mueller <matthias.mueller@rz.uni-karlsruhe.de>
To: Willy Tarreau <willy@w.ods.org>
Cc: Andrea Arcangeli <andrea@suse.de>, Con Kolivas <kernel@kolivas.org>,
       Andrew Morton <akpm@digeo.com>, axboe@suse.de, m.c.p@wolk-project.de,
       manish@storadinc.com, marcelo@conectiva.com.br,
       linux-kernel@vger.kernel.org
Subject: Re: 2.4.20: Proccess stuck in __lock_page ...
Message-ID: <20030529143827.GA777@rz.uni-karlsruhe.de>
Mail-Followup-To: Willy Tarreau <willy@w.ods.org>,
	Andrea Arcangeli <andrea@suse.de>, Con Kolivas <kernel@kolivas.org>,
	Andrew Morton <akpm@digeo.com>, axboe@suse.de,
	m.c.p@wolk-project.de, manish@storadinc.com,
	marcelo@conectiva.com.br, linux-kernel@vger.kernel.org
References: <3ED2DE86.2070406@storadinc.com> <20030528101348.GA804@rz.uni-karlsruhe.de> <20030528032315.679e77b0.akpm@digeo.com> <200305290000.12116.kernel@kolivas.org> <20030529132431.GK1453@dualathlon.random> <20030529135508.GC21673@alpha.home.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030529135508.GC21673@alpha.home.local>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 29, 2003 at 03:55:08PM +0200, Willy Tarreau wrote:
> Hello !
> 
> I've done a few tests with -rc6 on my dev machine (dual xp 1.5G, 512 MB, scsi).
> It's the *FIRST* time I have ever seen my mouse cursor hang (just a little bit
> however, and totally acceptable) ! Usually, my kernel include -aa VM and lowlat
> patches, and I've never encountered this behaviour on this machine with such a
> configuration. However, with stock kernel, I admit that during the 2 minutes it
> takes to write the 2G file, I see the mouse stick two or three times during
> about 1 second, which is quite acceptable IMHO. Opening an xterm may take 10s
> to get to the prompt (more annoying). Same to launch 'ps'.
> 
> I use a fairly simple window manager (ctwm), which doesn't access the disk once
> it's launched. It never gets stuck during all the operation if I disable the
> swap. If I enable the swap, it sometimes takes one or two seconds to draw a
> menu. The swap is used up to about 4 MB.
> 
> I then tried -rc6 with ll_rw_blk from -rc5, and it's worse, even with swap
> disabled. The hangs happen more often, but are about the same durations. So I
> confirm that -rc6 is better here than -rc5.
> 
> I retried with rc4aa1, and everything went very smooth again ; it takes at most
> 1 second to get an xterm with the prompt ready, and ps responds immediately. So
> I think that there are two things here:
>   - those who experience very long hangs may use a heavy window manager
>     which does continuous disk accesses (I mean it accesses the disk for any
>     simple operation).
>   - a hungry WM may also be swapped during such operations, rendering it
>     totally unusable, particularly if the swap is on the same physical disk
>     as the file being written to.
> 
> So, could the people who report long hangs retry with swap disabled ?
> Can we limit the amount of memory consummed by the cache during such a write ?

I run fluxbox, not a very heavy window manager, but I installed ctwm and
tried again with vanilla 2.4.20. If I disabled swap the short hangs (1s) are
gone, but the long mouse hangs (10s) are still there.

Matthias
-- 
Matthias.Mueller@rz.uni-karlsruhe.de
Rechenzentrum Universitaet Karlsruhe
Abteilung Netze
