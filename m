Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261551AbVDKOWR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261551AbVDKOWR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Apr 2005 10:22:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261562AbVDKOWR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Apr 2005 10:22:17 -0400
Received: from kalmia.hozed.org ([209.234.73.41]:32677 "EHLO kalmia.hozed.org")
	by vger.kernel.org with ESMTP id S261551AbVDKOWO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Apr 2005 10:22:14 -0400
Date: Mon, 11 Apr 2005 09:22:13 -0500
From: Troy Benjegerdes <hozer@hozed.org>
To: Roland Dreier <roland@topspin.com>
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: Re: [PATCH][RFC][0/4] InfiniBand userspace verbs implementation
Message-ID: <20050411142213.GC26127@kalmia.hozed.org>
References: <200544159.Ahk9l0puXy39U6u6@topspin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
In-Reply-To: <200544159.Ahk9l0puXy39U6u6@topspin.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> In particular, the memory pinning code in in uverbs_mem.c could stand
> a looking over.  In addition, a sanity check of the write()-based
> scheme for passing commands into the kernel in uverbs_main.c and
> uverbs_cmd.c is probably worthwhile.

How is memory pinning handled? (I haven't had time to read all the code,
so please excuse my ignorance of something obvious).

The old mellanox drivers used to have a hack to call 'sys_mlock', and
promiscuously lock memory any old userspace application asked for. What
is the API for the new uverbs memory registration, and how will things
like memory hotplug and NUMA page migration be able to unpin pages
locked by a user program?

I have applications that would benefit from being able to register 15GB
of memory on a machine with 16GB. Right now, MPI and other possible
users of infiniband in userspace have to play cacheing games and limit
what they can register. But locking all that memory without providing
the kernel a way to unlock it under memory pressure or for page
migration seems like a bad idea.
