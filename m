Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932244AbWFSIAc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932244AbWFSIAc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 04:00:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932251AbWFSIAc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 04:00:32 -0400
Received: from smtp.osdl.org ([65.172.181.4]:17024 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932244AbWFSIAb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 04:00:31 -0400
Date: Mon, 19 Jun 2006 00:59:55 -0700
From: Andrew Morton <akpm@osdl.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: ccb@acm.org, linux-kernel@vger.kernel.org
Subject: Re: [patch] increase spinlock-debug looping timeouts from 1 sec to
 1 min
Message-Id: <20060619005955.b05840e8.akpm@osdl.org>
In-Reply-To: <20060619070229.GA8293@elte.hu>
References: <1150142023.3621.22.camel@cbox.memecycle.com>
	<20060617100710.ec05131f.akpm@osdl.org>
	<20060619070229.GA8293@elte.hu>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Jun 2006 09:02:29 +0200
Ingo Molnar <mingo@elte.hu> wrote:

> Subject: increase spinlock-debug looping timeouts from 1 sec to 1 min

But it's broken.  In the non-debug case we subtract RW_LOCK_BIAS so we know
that the writer will get the lock when all readers vacate.  But in the
CONFIG_DEBUG_SPINLOCK case we don't do that, with the result that taking a
write_lock can take over a second.

A much, much better fix (which involves visiting all architectures) would
be to subtract RW_LOCK_BIAS and _then_ wait for a second.

OK, it's only debug code.  But RH (for one) have decided to ship zillions
of kernels with this debug code turned on.
