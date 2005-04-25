Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261180AbVDYX6I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261180AbVDYX6I (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Apr 2005 19:58:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261182AbVDYX6H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Apr 2005 19:58:07 -0400
Received: from groover.houseafrikarecords.com ([12.162.17.52]:35913 "EHLO
	Mansi.STRATNET.NET") by vger.kernel.org with ESMTP id S261180AbVDYX6E
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Apr 2005 19:58:04 -0400
To: Andrew Morton <akpm@osdl.org>
Cc: Timur Tabi <timur.tabi@ammasso.com>, hch@infradead.org, hozer@hozed.org,
       linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: Re: [PATCH][RFC][0/4] InfiniBand userspace verbs implementation
X-Message-Flag: Warning: May contain useful information
References: <200544159.Ahk9l0puXy39U6u6@topspin.com>
	<20050411142213.GC26127@kalmia.hozed.org> <52mzs51g5g.fsf@topspin.com>
	<20050411163342.GE26127@kalmia.hozed.org> <5264yt1cbu.fsf@topspin.com>
	<20050411180107.GF26127@kalmia.hozed.org> <52oeclyyw3.fsf@topspin.com>
	<20050411171347.7e05859f.akpm@osdl.org> <4263DEC5.5080909@ammasso.com>
	<20050418164316.GA27697@infradead.org> <4263E445.8000605@ammasso.com>
	<20050423194421.4f0d6612.akpm@osdl.org> <426BABF4.3050205@ammasso.com>
	<52is2bvvz5.fsf@topspin.com> <20050425135401.65376ce0.akpm@osdl.org>
	<521x8yv9vb.fsf@topspin.com> <20050425151459.1f5fb378.akpm@osdl.org>
	<426D6D68.6040504@ammasso.com> <20050425153256.3850ee0a.akpm@osdl.org>
From: Roland Dreier <roland@topspin.com>
Date: Mon, 25 Apr 2005 16:58:03 -0700
In-Reply-To: <20050425153256.3850ee0a.akpm@osdl.org> (Andrew Morton's
 message of "Mon, 25 Apr 2005 15:32:56 -0700")
Message-ID: <52vf6atnn8.fsf@topspin.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 25 Apr 2005 23:58:03.0622 (UTC) FILETIME=[9E45E060:01C549F2]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Andrew> ug.  What stops the memory from leaking if the process
    Andrew> exits?

    Andrew> I hope this is a privileged operation?

I don't think it has to be privileged.  In my implementation, the
driver keeps a per-process list of registered memory regions and
unpins/cleans up on process exit.

    Andrew> It would be better to obtain this memory via a mmap() of
    Andrew> some special device node, so we can perform appropriate
    Andrew> permission checking and clean everything up on unclean
    Andrew> application exit.

This seems to interact poorly with how applications want to use RDMA,
ie typically through a library interface such as MPI.  People doing
HPC don't want to recode their apps to use a new allocator, they just
want to link to a new MPI library and have the app go fast.

 - R.

