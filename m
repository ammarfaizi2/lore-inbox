Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263947AbUDNIDE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 04:03:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263951AbUDNIDE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 04:03:04 -0400
Received: from fw.osdl.org ([65.172.181.6]:57992 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263947AbUDNIDA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 04:03:00 -0400
Date: Wed, 14 Apr 2004 01:02:40 -0700
From: Andrew Morton <akpm@osdl.org>
To: jgarzik@pobox.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] conditionalize some boring buffer_head checks
Message-Id: <20040414010240.0e9f4115.akpm@osdl.org>
In-Reply-To: <20040414005832.083de325.akpm@osdl.org>
References: <407CEB91.1080503@pobox.com>
	<20040414005832.083de325.akpm@osdl.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> wrote:
>
>  buffer_error() was always supposed to be temporary.  Once per month someone
>  reports the one in __find_get_block_slow(), but that's all.  The only
>  reason for keeping it around is as a debug aid to filesystem developers.
> 
>  We could make it a no-op if !CONFIG_BUFFER_DEBUG.

But even if we do that, the compiler cannot optimise away things like:

	if (atomic_read(&bh->b_count) == 0 &&
			!PageLocked(bh->b_page) &&
			!PageWriteback(bh->b_page))
		do {} while (0);

so if it offends you, go kill the thing outright.

