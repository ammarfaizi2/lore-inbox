Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270617AbTHETjt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 15:39:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270645AbTHETjs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 15:39:48 -0400
Received: from nat9.steeleye.com ([65.114.3.137]:31492 "EHLO
	fenric.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S270617AbTHETib (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 15:38:31 -0400
Message-ID: <3F300760.8F703814@SteelEye.com>
Date: Tue, 05 Aug 2003 15:37:04 -0400
From: Paul Clements <Paul.Clements@SteelEye.com>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.2.13 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Lou Langholtz <ldl@aros.net>
CC: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] 2.6.0 NBD driver: remove send/recieve race for request
References: <3F2FE078.6020305@aros.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lou Langholtz wrote:
> 
> The following patch removes a race condition in the network block device
> driver in 2.6.0*. Without this patch, the reply receiving thread could
> end (and free up the memory for) the request structure before the
> request sending thread is completely done accessing it and would then
> access invalid memory.

Indeed, there is a race condition here. It's a very small window, but it
looks like it could possibly be trouble on SMP/preempt kernels.

This patch looks OK, but it appears to still leave the race window open
in the error case (it seems to fix the non-error case, though). We
probably could actually use the ref_count field of struct request to
better fix this problem. I'll take a look at doing this, and send a
patch out in a while.

Thanks,
Paul
