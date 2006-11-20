Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966758AbWKTVNv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966758AbWKTVNv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 16:13:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966763AbWKTVNv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 16:13:51 -0500
Received: from avexch1.qlogic.com ([198.70.193.115]:6265 "EHLO
	avexch1.qlogic.com") by vger.kernel.org with ESMTP id S966758AbWKTVNu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 16:13:50 -0500
Date: Mon, 20 Nov 2006 13:13:47 -0800
From: Andrew Vasquez <andrew.vasquez@qlogic.com>
To: Matthew Wilcox <matthew@wil.cx>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] Introduce mutex_lock_timeout
Message-ID: <20061120211347.GH11420@andrew-vasquezs-computer.local>
References: <20061109182721.GN16952@parisc-linux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061109182721.GN16952@parisc-linux.org>
Organization: QLogic Corporation
User-Agent: Mutt/1.5.12-2006-07-14
X-OriginalArrivalTime: 20 Nov 2006 21:13:49.0565 (UTC) FILETIME=[C5E89AD0:01C70CE8]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 09 Nov 2006, Matthew Wilcox wrote:

> We have a couple of places in the tree that really could do with a
> down_timeout() function.  I noticed it in qla2xxx and ACPI, but maybe
> there are others that don't have the courtesy of putting "I wish we had
> a down_timeout" comment beside their implementation.

I'm testing this with qla2xxx...  btw: there's a minor cut-n-paste
error in the x86_64 variant where you forgot a ',' (comma).

> diff --git a/include/asm-x86_64/mutex.h b/include/asm-x86_64/mutex.h
> index 16396b1..18668fa 100644
> --- a/include/asm-x86_64/mutex.h
> +++ b/include/asm-x86_64/mutex.h
> @@ -46,11 +46,11 @@ do {									\
>   * or anything the slow path function returns
>   */
>  static inline int
> -__mutex_fastpath_lock_retval(atomic_t *count,
> -			     int fastcall (*fail_fn)(atomic_t *))
> +__mutex_fastpath_lock_retval(atomic_t *count, long jiffies
> +			     int fastcall (*fail_fn)(atomic_t *, long))

should be:

	+__mutex_fastpath_lock_retval(atomic_t *count, long jiffies,
	+			     int fastcall (*fail_fn)(atomic_t *, long))
