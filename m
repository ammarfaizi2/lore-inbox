Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261330AbULMUcQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261330AbULMUcQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Dec 2004 15:32:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262323AbULMUa3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Dec 2004 15:30:29 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:13714 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261635AbULMUUW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Dec 2004 15:20:22 -0500
Date: Mon, 13 Dec 2004 21:19:41 +0100
From: Jens Axboe <axboe@suse.de>
To: Ed L Cashin <ecashin@coraid.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ATA over Ethernet driver for 2.6.9 (with changes)
Message-ID: <20041213201941.GC3399@suse.de>
References: <87k6rmuqu4.fsf@coraid.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87k6rmuqu4.fsf@coraid.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 13 2004, Ed L Cashin wrote:
>   * use mempool allocation in make_request_fn

It's not good enough, if cannot use a higher allocation priority that
GFP_NOIO here - basically guarantee that your allocation will not block
on further io. Currently you have the very same deadlock as before, the
mempool does not help you since you call into the allocator and deadlock
before ever blocking on the mempool.

-- 
Jens Axboe

