Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268501AbUHQWru@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268501AbUHQWru (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 18:47:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268498AbUHQWrt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 18:47:49 -0400
Received: from fw.osdl.org ([65.172.181.6]:57784 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268524AbUHQWqe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 18:46:34 -0400
Date: Tue, 17 Aug 2004 15:50:04 -0700
From: Andrew Morton <akpm@osdl.org>
To: Kurt Garloff <garloff@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bio_uncopy_user mem leak
Message-Id: <20040817155004.70ac4d9e.akpm@osdl.org>
In-Reply-To: <20040817155918.GA5312@tpkurt.garloff.de>
References: <20040817155918.GA5312@tpkurt.garloff.de>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kurt Garloff <garloff@suse.de> wrote:
>
> When using bounce buffers for SG_IO commands with unaligned 
> buffers in blk_rq_map_user(), we should free the pages from
> blk_rq_unmap_user() which calls bio_uncopy_user() for the 
> non-BIO_USER_MAPPED case. That function failed to free the
> pages for write requests.
> 
> So we leaked pages and you machine would go OOM. Rebooting 
> helped ;-)

Eureka.  Thanks.

This really should trigger a 2.6.8.2.  We'll see.

