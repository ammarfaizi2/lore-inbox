Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263447AbTKFJ7W (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Nov 2003 04:59:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263487AbTKFJ7H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Nov 2003 04:59:07 -0500
Received: from ns.suse.de ([195.135.220.2]:51343 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S263462AbTKFJ7A (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Nov 2003 04:59:00 -0500
Date: Thu, 6 Nov 2003 10:17:46 +0100
From: Jens Axboe <axboe@suse.de>
To: "Prakash K. Cheemplavam" <prakashpublic@gmx.de>
Cc: Nick Piggin <piggin@cyberone.com.au>, linux-kernel@vger.kernel.org
Subject: Re: 2.9test9-mm1 and DAO ATAPI cd-burning corrupt
Message-ID: <20031106091746.GA1379@suse.de>
References: <20031105095457.GG1477@suse.de> <3FA8CA87.2070201@gmx.de> <20031105100120.GH1477@suse.de> <3FA8CCF9.6070700@gmx.de> <20031105101207.GI1477@suse.de> <3FA8CEF1.1050200@gmx.de> <20031105102238.GJ1477@suse.de> <3FA8D17D.3060204@gmx.de> <20031105123923.GP1477@suse.de> <3FA945DD.8030105@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FA945DD.8030105@gmx.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 05 2003, Prakash K. Cheemplavam wrote:
> Jens Axboe wrote:
> >(cc me, just caught your message by luck)
> >
> >On Wed, Nov 05 2003, Prakash K. Cheemplavam wrote:
> >
> >>>>>it's a cdrecord option, I've never used k3b so cannot comment on how to
> >>>>>make it enable that.
> >>>>
> >>>>Hmm, I'll take a look, but I don't really think it is a problem of the 
> >>>>recording programme, otherwise how could my reader read it out 
> >>>>completely?
> >>>
> >>>
> >>>It isn't a problem of the recorder program. But some drives wont read
> >>>the very end of a disc unless there are some pad blocks at the end.
> >>>Thus, you should always use the cdrecord pad option.
> 
> Well, I now used the -pad option, but now the image (naturally) gets 
> larger and thus k3b reports verify fail. I think the k3b people need to 
> ignore the last 00s and calc the md5sum according to the original iso 
> size...

Sounds right, yes.

> >>>Don't remember, sorry :)
> >>
> >>I probably will make a new topic regarding issues (I think) I found with 
> >>the new mm kernel.
> >
> >
> >Fine, check the SG_IO thing first though.
> 
> I am sorry, but could you explain how to find out? I dunno where to 
> look... But I made your vmstat output:

Your other mail showed the device argument being the actual device, so
unless cdrecord screws, it is using SG_IO.

> procs -----------memory---------- ---swap-- -----io---- --system-- 
> ----cpu----
>  r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us 
> sy id wa
>  2  0      0 579472  13976 308572    0    0   425    85 1255   645  5 
> 3 84  9
>  2  0      0 579456  13976 308572    0    0     0     0  725   521  5 
> 5 91  0
>  1  0      0 579448  13976 308572    0    0     0     0  736   523  2 
> 5 94  0
>  0  0      0 579448  13976 308572    0    0     0    25  745   439  2 

[snip]

This looks good, from a system utilization point of view. I'm wondering
whether you have the iso image cached? There's no block io going on.

It does like more like a CPU scheduler problem at this point.

-- 
Jens Axboe

