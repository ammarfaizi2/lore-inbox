Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262030AbTIWR6t (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Sep 2003 13:58:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262037AbTIWR6t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Sep 2003 13:58:49 -0400
Received: from rth.ninka.net ([216.101.162.244]:17829 "EHLO rth.ninka.net")
	by vger.kernel.org with ESMTP id S262030AbTIWR6s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Sep 2003 13:58:48 -0400
Date: Tue, 23 Sep 2003 10:58:41 -0700
From: "David S. Miller" <davem@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] softirq_pending()
Message-Id: <20030923105841.27809d11.davem@redhat.com>
In-Reply-To: <20030923144847.GA16139@lst.de>
References: <20030923144847.GA16139@lst.de>
X-Mailer: Sylpheed version 0.9.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Sep 2003 16:48:47 +0200
Christoph Hellwig <hch@lst.de> wrote:

> x86-64 currently ignores the cpu argument to softirq_pending() and
> always uses smp_processor_id().  And indeed that's the only possible
> argument.  So consolidate the old softirq_pending() and
> local_softirq_pending() into a single one.

The problem is that, on some of the platforms that don't ignore
the argument, the code generation is much better.

GCC doesn't consider smp_processor_id() like some const local
variable, so multiple invocations are assumed to return different
values because in many cases 'current_thread_info()' is obscured.

Your patch is going to make a lot of new code get generated on
x86 for example, so I don't think it should be applied even though
my own platforms are not effected by this issue.
