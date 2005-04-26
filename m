Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261252AbVDZANP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261252AbVDZANP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Apr 2005 20:13:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261225AbVDZANK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Apr 2005 20:13:10 -0400
Received: from fire.osdl.org ([65.172.181.4]:46055 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261252AbVDZAM0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Apr 2005 20:12:26 -0400
Date: Mon, 25 Apr 2005 17:11:45 -0700
From: Andrew Morton <akpm@osdl.org>
To: Roland Dreier <roland@topspin.com>
Cc: timur.tabi@ammasso.com, hch@infradead.org, hozer@hozed.org,
       linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: Re: [PATCH][RFC][0/4] InfiniBand userspace verbs implementation
Message-Id: <20050425171145.2f0fd7f8.akpm@osdl.org>
In-Reply-To: <52vf6atnn8.fsf@topspin.com>
References: <200544159.Ahk9l0puXy39U6u6@topspin.com>
	<20050411142213.GC26127@kalmia.hozed.org>
	<52mzs51g5g.fsf@topspin.com>
	<20050411163342.GE26127@kalmia.hozed.org>
	<5264yt1cbu.fsf@topspin.com>
	<20050411180107.GF26127@kalmia.hozed.org>
	<52oeclyyw3.fsf@topspin.com>
	<20050411171347.7e05859f.akpm@osdl.org>
	<4263DEC5.5080909@ammasso.com>
	<20050418164316.GA27697@infradead.org>
	<4263E445.8000605@ammasso.com>
	<20050423194421.4f0d6612.akpm@osdl.org>
	<426BABF4.3050205@ammasso.com>
	<52is2bvvz5.fsf@topspin.com>
	<20050425135401.65376ce0.akpm@osdl.org>
	<521x8yv9vb.fsf@topspin.com>
	<20050425151459.1f5fb378.akpm@osdl.org>
	<426D6D68.6040504@ammasso.com>
	<20050425153256.3850ee0a.akpm@osdl.org>
	<52vf6atnn8.fsf@topspin.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roland Dreier <roland@topspin.com> wrote:
>
>     Andrew> ug.  What stops the memory from leaking if the process
>     Andrew> exits?
> 
>     Andrew> I hope this is a privileged operation?
> 
> I don't think it has to be privileged.  In my implementation, the
> driver keeps a per-process list of registered memory regions and
> unpins/cleans up on process exit.

How does the driver detect process exit?

>     Andrew> It would be better to obtain this memory via a mmap() of
>     Andrew> some special device node, so we can perform appropriate
>     Andrew> permission checking and clean everything up on unclean
>     Andrew> application exit.
> 
> This seems to interact poorly with how applications want to use RDMA,
> ie typically through a library interface such as MPI.  People doing
> HPC don't want to recode their apps to use a new allocator, they just
> want to link to a new MPI library and have the app go fast.

Fair enough.
