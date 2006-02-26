Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750792AbWBZVGq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750792AbWBZVGq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Feb 2006 16:06:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751209AbWBZVGq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Feb 2006 16:06:46 -0500
Received: from xproxy.gmail.com ([66.249.82.205]:33560 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750792AbWBZVGp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Feb 2006 16:06:45 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:subject:from:reply-to:to:cc:in-reply-to:references:content-type:date:message-id:mime-version:x-mailer:content-transfer-encoding;
        b=rpe0ELxe8uSWEzVOolWxoMOQAYeSr1A3jFDdl9vVki50yra8WcHwZSgDioG5N4YBxeULvlZPvcf6NLBCwhQ5Ad8bqVJ9FyzVIdGJ0bnC/4uHHqUGvVzyZDtRUubclWVb+0ARTTigGWQXufUgK00SGltoewMRtAnpZQ65ppjjK2I=
Subject: Re: OOM-killer too aggressive?
From: Chris Largret <largret@gmail.com>
Reply-To: largret@gmail.com
To: Andrew Morton <akpm@osdl.org>
Cc: Chuck Ebbert <76306.1226@compuserve.com>, linux-kernel@vger.kernel.org,
       axboe@suse.de, Andi Kleen <ak@muc.de>
In-Reply-To: <20060226102152.69728696.akpm@osdl.org>
References: <200602260938_MC3-1-B94B-EE2B@compuserve.com>
	 <20060226102152.69728696.akpm@osdl.org>
Content-Type: text/plain
Date: Sun, 26 Feb 2006 13:06:55 -0800
Message-Id: <1140988015.5178.15.camel@shogun.daga.dyndns.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 Dropline GNOME 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-02-26 at 10:21 -0800, Andrew Morton wrote: 
> Chuck Ebbert <76306.1226@compuserve.com> wrote:
> >
> > Chris Largret is getting repeated OOM kills because of DMA memory
> > exhaustion:
> > 
> > oom-killer: gfp_mask=0xd1, order=3
> > 
> 
> This could be related to the known GFP_DMA oom on some x86_64 machines.

I'm not sure if this has any bearing on it, but the OOM Killer only does
this when I compile the kernel with SMP support.

> > Or should floppy.c be fixed so it doesn't ask for so much?
> 
> The page allocator uses 32k as the threshold for when-to-try-like-crazy.
> 
> x86_64 should probably be defining its own fd_dma_mem_alloc() which doesn't
> use GFP_DMA.
> 
> --- devel/drivers/block/floppy.c~floppy-false-oom-fix	2006-02-26 10:14:38.000000000 -0800
> +++ devel-akpm/drivers/block/floppy.c	2006-02-26 10:15:04.000000000 -0800
> @@ -278,7 +278,8 @@ static void do_fd_request(request_queue_

Sorry, this didn't help on my machine. I am running that latest kernel
pre-patch (2.6.16-rc4) for testing right now and had to modify the
offsets a little. If there's any output that would help, please let me
know.

--
Chris Largret <http://daga.dyndns.org>

