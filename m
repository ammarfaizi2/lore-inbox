Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751408AbWBVUGh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751408AbWBVUGh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 15:06:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751411AbWBVUGh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 15:06:37 -0500
Received: from smtp.osdl.org ([65.172.181.4]:22193 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751408AbWBVUGg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 15:06:36 -0500
Date: Wed, 22 Feb 2006 12:05:47 -0800
From: Andrew Morton <akpm@osdl.org>
To: Robin Holt <holt@sgi.com>
Cc: john@johnmccutchan.com, holt@sgi.com, linux-kernel@vger.kernel.org,
       rml@novell.com, arnd@arndb.de, hch@lst.de
Subject: Re: udevd is killing file write performance.
Message-Id: <20060222120547.2ae23a16.akpm@osdl.org>
In-Reply-To: <20060222175030.GB30556@lnx-holt.americas.sgi.com>
References: <20060222134250.GE20786@lnx-holt.americas.sgi.com>
	<1140626903.13461.5.camel@localhost.localdomain>
	<20060222175030.GB30556@lnx-holt.americas.sgi.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robin Holt <holt@sgi.com> wrote:
>
> Let me reiterate, I know _VERY_ little about filesystems.  Can the
>  dentry->d_lock be changed to a read/write lock?

Well, it could, but I suspect that won't help - the hold times in there
will be very short so the problem is more likely acquisition frequency.

However it's a bit strange that this function is the bottleneck.  If their
workload is doing large numbers of reads or writes from large numbers of
processes against the same file then they should be hitting heavy
contention on other locks, such as i_sem and/or tree_lock and/or lru_lock
and others.

Can you tell us more about the kernel-visible behaviour of this app?
