Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261899AbUKVCyz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261899AbUKVCyz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Nov 2004 21:54:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261901AbUKVCyz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Nov 2004 21:54:55 -0500
Received: from fw.osdl.org ([65.172.181.6]:30667 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261899AbUKVCyy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Nov 2004 21:54:54 -0500
Date: Sun, 21 Nov 2004 18:54:39 -0800
From: Andrew Morton <akpm@osdl.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] del_timer() vs. mod_timer() SMP race
Message-Id: <20041121185439.7fcfe514.akpm@osdl.org>
In-Reply-To: <1101091445.13612.31.camel@gaston>
References: <1101091445.13612.31.camel@gaston>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
>
> --- linux-work.orig/kernel/timer.c	2004-11-22 11:50:59.000000000 +1100
>  +++ linux-work/kernel/timer.c	2004-11-22 13:35:38.928448032 +1100
>  @@ -308,6 +308,7 @@
>   		goto repeat;
>   	}
>   	list_del(&timer->entry);
>  +	smp_wmb();

Pretty please, always add a comment when putting an open-coded barrier into
the kernel.  Otherwise people cannot tell why it is there.

