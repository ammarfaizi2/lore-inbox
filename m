Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266236AbUHGFFe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266236AbUHGFFe (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Aug 2004 01:05:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266240AbUHGFFe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Aug 2004 01:05:34 -0400
Received: from fw.osdl.org ([65.172.181.6]:50876 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266236AbUHGFF1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Aug 2004 01:05:27 -0400
Date: Fri, 6 Aug 2004 22:03:51 -0700
From: Andrew Morton <akpm@osdl.org>
To: "admin@wodkahexe.de" <admin@wodkahexe.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Problem with OOMKiller 2.6.8-rc3
Message-Id: <20040806220351.5e2b69b0.akpm@osdl.org>
In-Reply-To: <20040806195709.160722fa.admin@wodkahexe.de>
References: <20040806195709.160722fa.admin@wodkahexe.de>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"admin@wodkahexe.de" <admin@wodkahexe.de> wrote:
>
> today i tried to burn a cd (bin+cue image) that was located on an
>  nfs share.
> 
>  - boot 2.6.8-rc3
>  - startx
>  - start k3b
>  - burn image
> 
>  after ~50% of burning the mouse stopped moving over the screen. the
>  keyboard was dead.

What sort of CD was it?  Audio?  Judging by k3b.org, I'd say it was.

>  the maschine was reachable via network, so i ssh'd and saw the
>  following in dmesg:
> 
>  laptop oom-killer: gfp_mask=0x1d2
>  laptop DMA per-cpu:
>  laptop cpu 0 hot: low 2, high 6, batch 1 
>  laptop cpu 0 cold: low 0, high 2, batch 1 
>  laptop Normal per-cpu:
>  laptop cpu 0 hot: low 32, high 96, batch 16
>  laptop cpu 0 cold: low 0, high 32, batch 16
>  laptop HighMem per-cpu: empty
>  laptop  
>  laptop Free pages:        2192kB (0kB HighMem)
>  laptop Active:2113 inactive:643 dirty:0 writeback:0 unstable:0 free:548 slab:2233 mapped:1518 pagetables:210
>  laptop DMA free:1376kB min:20kB low:40kB high:60kB active:0kB inactive:0kB present:16384kB
>  laptop protections[]: 10 354 354 
>  laptop Normal free:816kB min:688kB low:1376kB high:2064kB active:8452kB inactive:2572kB present:491456kB

All your memory seems to have gone away.  There's a memory leak associated
with audio writing which we haven't yet tracked down - it's probably that.

