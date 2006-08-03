Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932319AbWHCGwd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932319AbWHCGwd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 02:52:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932320AbWHCGwd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 02:52:33 -0400
Received: from smtp.osdl.org ([65.172.181.4]:39129 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932319AbWHCGwc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 02:52:32 -0400
Date: Wed, 2 Aug 2006 23:52:19 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jay Lan <jlan@engr.sgi.com>
Cc: linux-kernel@vger.kernel.org, nagar@watson.ibm.com, balbir@in.ibm.com,
       jes@sgi.com, csturtiv@sgi.com, tee@sgi.com,
       guillaume.thouvenin@bull.net
Subject: Re: [patch 1/3] basic accounting over taskstats
Message-Id: <20060802235219.25a072e7.akpm@osdl.org>
In-Reply-To: <44D179A5.4000606@engr.sgi.com>
References: <44D179A5.4000606@engr.sgi.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 02 Aug 2006 21:20:53 -0700
Jay Lan <jlan@engr.sgi.com> wrote:

> This patch is to replace the "[patch 1/3] add basic accounting
> fields to taskstats" posted on 7/31.
> 
> This patch adds some basic accounting fields to the taskstats
> struct, add a new kernel/tsacct.c to handle basic accounting
> data handling upon exit. A handle is added to taskstats.c
> to invoke the basic accounting data handling.
> 

> +#define TS_COMM_LEN		16	/* should sync up with TASK_COMM_LEN
> +					 * in linux/sched.h */

There was a proposal recently to increase TASK_COMM_LENGTH from 16 to 20 so
that it was long enough to hold an entire IEEE(?) UUID so that the
operator can easily match up a kernel thread with the storage device which
it manages.

I don't know if/when that change will happen, but the message is that
TASK_COMM_LENGTH may increase.

> +	BUILD_BUG_ON(TS_COMM_LEN < TASK_COMM_LEN);

And if it does, we'll need to increase TS_COMM_LEN as well.  That will
amount to an non-compatible change to the interface which you are
proposing.   We want to avoid that.

Hence I'd propose that you increase TS_COMM_LEN to 32 or something and if
TASK_COMM_LEN later becomes really big, we might just choose to truncate
it.

Or we remove this field altogether, perhaps.  The same info is available
from /proc/pid/stat anyway.  Is it really needed?

