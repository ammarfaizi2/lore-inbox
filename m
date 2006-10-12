Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750988AbWJLVIy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750988AbWJLVIy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 17:08:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750992AbWJLVIx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 17:08:53 -0400
Received: from smtp.osdl.org ([65.172.181.4]:24754 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750988AbWJLVIx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 17:08:53 -0400
Date: Thu, 12 Oct 2006 14:08:30 -0700
From: Andrew Morton <akpm@osdl.org>
To: Akinobu Mita <akinobu.mita@gmail.com>
Cc: linux-kernel@vger.kernel.org, ak@suse.de, Don Mullis <dwm@meer.net>,
       Jens Axboe <axboe@suse.de>
Subject: Re: [patch 5/7] fault-injection capability for disk IO
Message-Id: <20061012140830.49ff6135.akpm@osdl.org>
In-Reply-To: <452df232.7451e919.6dde.ffff9127@mx.google.com>
References: <20061012074305.047696736@gmail.com>
	<452df232.7451e919.6dde.ffff9127@mx.google.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Oct 2006 16:43:10 +0900
Akinobu Mita <akinobu.mita@gmail.com> wrote:

> @@ -3134,6 +3174,9 @@ end_io:
>  		if (unlikely(test_bit(QUEUE_FLAG_DEAD, &q->queue_flags)))
>  			goto end_io;
>  
> +		if (should_fail_request(bio))
> +			goto end_io;
> +

hm, so we simulate IO errors by failing at make_request() time rather than
at end_that_request_last()-time, which is where IO errors would usually be
reported.

If we're testing the filesystem/VFS/etc layers then that's pretty much
equivalent.  But perhaps there's an argument for doing both.

Jens, could you have a think about it please?
