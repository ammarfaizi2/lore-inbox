Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261589AbTEQPxV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 May 2003 11:53:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261603AbTEQPxV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 May 2003 11:53:21 -0400
Received: from phoenix.infradead.org ([195.224.96.167]:26377 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S261589AbTEQPxV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 May 2003 11:53:21 -0400
Date: Sat, 17 May 2003 17:06:13 +0100
From: Christoph Hellwig <hch@infradead.org>
To: "Paul E. McKenney" <paulmck@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, akpm@digeo.com,
       mjbligh@us.ibm.com
Subject: Re: [RFC][PATCH] vm_operation to avoid pagefault/inval race
Message-ID: <20030517170613.A11288@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	"Paul E. McKenney" <paulmck@us.ibm.com>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, akpm@digeo.com,
	mjbligh@us.ibm.com
References: <20030513135326.D2929@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030513135326.D2929@us.ibm.com>; from paulmck@us.ibm.com on Tue, May 13, 2003 at 01:53:26PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 13, 2003 at 01:53:26PM -0700, Paul E. McKenney wrote:
> This patch adds a vm_operations_struct function pointer that allows
> networked and distributed filesystems to avoid a race between a
> pagefault on an mmap and an invalidation request from some other
> node.  The race goes as follows:

The race is real although currenly no in-tree filesystem is affected.
The patch is uglyh as hell, though.  The right fix is to change the
->nopage method to cover what do_no_page is currently, change anonymous
vmas to have vm_ops as well and set ->nopage to do_anonymous_page.

The gets of the current do_no_page become a new helper (__finish_nopage?)
and EXPORT_SYMBOL_GPL()ed.  It would also be nice if you could point to
a filesystem that actually needs this, but if you can get rid of the
do_anonymous_page special casing a patch might even be acceptable without it.

