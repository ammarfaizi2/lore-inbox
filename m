Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261262AbTJCVkZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Oct 2003 17:40:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261263AbTJCVkZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Oct 2003 17:40:25 -0400
Received: from fw.osdl.org ([65.172.181.6]:53978 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261262AbTJCVkW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Oct 2003 17:40:22 -0400
Date: Fri, 3 Oct 2003 14:40:10 -0700
From: Andrew Morton <akpm@osdl.org>
To: Daniel McNeil <daniel@osdl.org>
Cc: suparna@in.ibm.com, linux-aio@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: PATCH 2.6.0-test6-mm2] aio ref count during retry
Message-Id: <20031003144010.3445ec1f.akpm@osdl.org>
In-Reply-To: <1065215946.1862.164.camel@ibm-c.pdx.osdl.net>
References: <1064596018.1950.10.camel@ibm-c.pdx.osdl.net>
	<1064620762.2115.29.camel@ibm-c.pdx.osdl.net>
	<20030929040935.GA3637@in.ibm.com>
	<20030929131057.GA4630@in.ibm.com>
	<1064876358.23108.41.camel@ibm-c.pdx.osdl.net>
	<20030930040020.GA3435@in.ibm.com>
	<1064964169.1922.16.camel@ibm-c.pdx.osdl.net>
	<20031001084639.GA4188@in.ibm.com>
	<1065215946.1862.164.camel@ibm-c.pdx.osdl.net>
X-Mailer: Sylpheed version 0.9.6 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel McNeil <daniel@osdl.org> wrote:
>
> Here is the patch for AIO retry to hold an extra ref count.
> The patch is small, but I wanted to make sure it was safe.
> I spent time looking over the retry code and this patch looks
> ok to me.  It is potentially calling put_ioctx() while holding
> ctx->ctx_lock, I do not think that will cause any problems.
> This should never be the last reference on the ioctx anyway,
> since the loop is checking list_empty(&ctx->run_list).

So...  if the refcount is never zero in there, why are you changing it to
take an additional reference?

