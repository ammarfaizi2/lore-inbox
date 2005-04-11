Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261847AbVDKQjC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261847AbVDKQjC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Apr 2005 12:39:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261833AbVDKQgb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Apr 2005 12:36:31 -0400
Received: from kalmia.hozed.org ([209.234.73.41]:2726 "EHLO kalmia.hozed.org")
	by vger.kernel.org with ESMTP id S261839AbVDKQdn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Apr 2005 12:33:43 -0400
Date: Mon, 11 Apr 2005 11:33:42 -0500
From: Troy Benjegerdes <hozer@hozed.org>
To: Roland Dreier <roland@topspin.com>
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: Re: [PATCH][RFC][0/4] InfiniBand userspace verbs implementation
Message-ID: <20050411163342.GE26127@kalmia.hozed.org>
References: <200544159.Ahk9l0puXy39U6u6@topspin.com> <20050411142213.GC26127@kalmia.hozed.org> <52mzs51g5g.fsf@topspin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
In-Reply-To: <52mzs51g5g.fsf@topspin.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 11, 2005 at 08:34:19AM -0700, Roland Dreier wrote:
>     Troy> How is memory pinning handled? (I haven't had time to read
>     Troy> all the code, so please excuse my ignorance of something
>     Troy> obvious).
> 
> The userspace library calls mlock() and then the kernel does
> get_user_pages().

Is there a check in the kernel that the memory is actually mlock()ed?

What if a malicious (or broken) application does ibv_reg_mr() but
doesn't lock the memory? Does the IB card get a physical address for a
page that might get swapped out?

>     Troy> The old mellanox drivers used to have a hack to call
>     Troy> 'sys_mlock', and promiscuously lock memory any old userspace
>     Troy> application asked for. What is the API for the new uverbs
>     Troy> memory registration, and how will things like memory hotplug
>     Troy> and NUMA page migration be able to unpin pages locked by a
>     Troy> user program?
> 
> The API for uverbs memory registration is ibv_reg_mr(), and right now
> the memory is pinned and that's it.
> 
>  - R.

