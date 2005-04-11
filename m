Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261821AbVDKP6s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261821AbVDKP6s (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Apr 2005 11:58:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261825AbVDKP6s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Apr 2005 11:58:48 -0400
Received: from webmail.topspin.com ([12.162.17.3]:23151 "EHLO
	exch-1.topspincom.com") by vger.kernel.org with ESMTP
	id S261821AbVDKP6j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Apr 2005 11:58:39 -0400
To: Troy Benjegerdes <hozer@hozed.org>
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: Re: [PATCH][RFC][0/4] InfiniBand userspace verbs implementation
X-Message-Flag: Warning: May contain useful information
References: <200544159.Ahk9l0puXy39U6u6@topspin.com>
	<20050411142213.GC26127@kalmia.hozed.org>
From: Roland Dreier <roland@topspin.com>
Date: Mon, 11 Apr 2005 08:34:19 -0700
In-Reply-To: <20050411142213.GC26127@kalmia.hozed.org> (Troy Benjegerdes's
 message of "Mon, 11 Apr 2005 09:22:13 -0500")
Message-ID: <52mzs51g5g.fsf@topspin.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 11 Apr 2005 15:34:19.0546 (UTC) FILETIME=[ED895FA0:01C53EAB]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Troy> How is memory pinning handled? (I haven't had time to read
    Troy> all the code, so please excuse my ignorance of something
    Troy> obvious).

The userspace library calls mlock() and then the kernel does
get_user_pages().

    Troy> The old mellanox drivers used to have a hack to call
    Troy> 'sys_mlock', and promiscuously lock memory any old userspace
    Troy> application asked for. What is the API for the new uverbs
    Troy> memory registration, and how will things like memory hotplug
    Troy> and NUMA page migration be able to unpin pages locked by a
    Troy> user program?

The API for uverbs memory registration is ibv_reg_mr(), and right now
the memory is pinned and that's it.

 - R.
