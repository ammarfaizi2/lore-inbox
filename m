Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261191AbVDYWj4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261191AbVDYWj4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Apr 2005 18:39:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261253AbVDYWjz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Apr 2005 18:39:55 -0400
Received: from fire.osdl.org ([65.172.181.4]:22213 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261191AbVDYWgR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Apr 2005 18:36:17 -0400
Date: Mon, 25 Apr 2005 15:35:42 -0700
From: Andrew Morton <akpm@osdl.org>
To: Timur Tabi <timur.tabi@ammasso.com>
Cc: roland@topspin.com, hch@infradead.org, hozer@hozed.org,
       linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: Re: [PATCH][RFC][0/4] InfiniBand userspace verbs implementation
Message-Id: <20050425153542.70197e6a.akpm@osdl.org>
In-Reply-To: <426D6DFA.4090908@ammasso.com>
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
	<426D6DFA.4090908@ammasso.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Timur Tabi <timur.tabi@ammasso.com> wrote:
>
> Andrew Morton wrote:
> 
> > The way we expect get_user_pages() to be used is that the kernel will use
> > get_user_pages() once per application I/O request.
> 
> Are you saying that the mapping obtained by get_user_pages() is valid only within the 
> context of the IOCtl call?  That once the driver returns from the IOCtl, the mapping 
> should no longer be used?

Yes, we expect that all the pages which get_user_pages() pinned will become
unpinned within the context of the syscall which pinned the pages.  Or
shortly after, in the case of async I/O.

This is because there is no file descriptor or anything else associated
with the pages which permits the kernel to clean stuff up on unclean
application exit.  Also there are the obvious issues with permitting
pinning of unbounded amounts of memory.


