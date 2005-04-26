Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261484AbVDZMFE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261484AbVDZMFE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 08:05:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261488AbVDZMFE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 08:05:04 -0400
Received: from fire.osdl.org ([65.172.181.4]:12006 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261484AbVDZMFB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 08:05:01 -0400
Date: Tue, 26 Apr 2005 05:04:29 -0700
From: Andrew Morton <akpm@osdl.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: axboe@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [patch] optimise loop driver a bit
Message-Id: <20050426050429.69137417.akpm@osdl.org>
In-Reply-To: <426C6AF2.9090406@yahoo.com.au>
References: <426C6AF2.9090406@yahoo.com.au>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin <nickpiggin@yahoo.com.au> wrote:
>
> Looks like locking can be optimised quite a lot.

So I've peered suspiciously at the ->lo_pending handling for some time and
am unconvinced.  Are you sure that the error path in loop_make_request() is
correct?  The old code decremented the pending count in there.

Why do we need that nasty-looking `pending' local in loop_thread()?
