Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269398AbUICQja@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269398AbUICQja (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 12:39:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269369AbUICQja
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 12:39:30 -0400
Received: from fw.osdl.org ([65.172.181.6]:54200 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S269416AbUICQjW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 12:39:22 -0400
Date: Fri, 3 Sep 2004 09:37:27 -0700
From: Andrew Morton <akpm@osdl.org>
To: Peter Osterlund <petero2@telia.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc1-mm3
Message-Id: <20040903093727.5810bb7d.akpm@osdl.org>
In-Reply-To: <m3brgncphy.fsf@telia.com>
References: <20040903014811.6247d47d.akpm@osdl.org>
	<m3brgncphy.fsf@telia.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Osterlund <petero2@telia.com> wrote:
>
> One problem that does remain though, is that when dumping huge amounts
>  of data to a CD or DVD disc (so that you get memory pressure), the
>  effective writing speed of other block devices (like IDE hard disks)
>  is reduced to the same speed as the packet device.
> 
>  I have posted a patch that fixes this problem by limiting the amount
>  of writeback data in the packet driver, but unfortunately it makes the
>  effective writing speed of the packet device suffer a lot. The proper
>  fix is probably to improve the filesystem and/or VM code to start I/O
>  operations in sequential order a lot more often than it currently
>  does.

If you decrease /proc/sys/vm/dirty_ratio and dirty_background_ratio to much
smaller levels, does that fix things up? 

If so, we might be able to put some sort of per-queue override into your
queue's backing_dev_info.
