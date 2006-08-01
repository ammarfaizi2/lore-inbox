Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751570AbWHAEBM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751570AbWHAEBM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 00:01:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751571AbWHAEBM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 00:01:12 -0400
Received: from smtp.osdl.org ([65.172.181.4]:50304 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751568AbWHAEBL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 00:01:11 -0400
Date: Mon, 31 Jul 2006 21:01:07 -0700
From: Andrew Morton <akpm@osdl.org>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: linux-kernel@vger.kernel.org, Jay Lan <jlan@engr.sgi.com>
Subject: Re: [PATCH] task_struct: remove writeonly counters
Message-Id: <20060731210107.89cab506.akpm@osdl.org>
In-Reply-To: <20060801022951.GB7006@martell.zuzino.mipt.ru>
References: <20060801022951.GB7006@martell.zuzino.mipt.ru>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Aug 2006 06:29:51 +0400
Alexey Dobriyan <adobriyan@gmail.com> wrote:

> ...
>
> +++ b/include/linux/sched.h
> @@ -962,8 +962,6 @@ #endif
>   * to a stack based synchronous wait) if its doing sync IO.
>   */
>  	wait_queue_t *io_wait;
> -/* i/o counters(bytes read/written, #syscalls */
> -	u64 rchar, wchar, syscr, syscw;

This is kinda funny.  These fields were added a year and a half ago, with
the intention that the info be made available to userspace.  But then
things got horridly stuck.  It's only in the past couple of weeks that we've
gained appropriate reporting-to-userspace infrastructure to be able to use
these fields.

And lo, on the very day when you propose removing these fields, Jay posts a
new patchset ("add CSA accounting to taskstats") which finally gets around to
using them.

So..  we should keep these fields for now - we can perhaps remove them (in
less than 1.5 years) if for some reason the CSA patches crash and burn (I
don't think they will).

