Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751105AbWBJFTv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751105AbWBJFTv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 00:19:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751107AbWBJFTu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 00:19:50 -0500
Received: from smtp.osdl.org ([65.172.181.4]:32668 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751105AbWBJFTu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 00:19:50 -0500
Date: Thu, 9 Feb 2006 21:19:16 -0800
From: Andrew Morton <akpm@osdl.org>
To: Christoph Lameter <clameter@engr.sgi.com>
Cc: ak@suse.de, pj@sgi.com, linux-kernel@vger.kernel.org
Subject: Re: Terminate process that fails on a constrained allocation V3
Message-Id: <20060209211916.0b33db4b.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.62.0602091152300.9941@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.62.0602091152300.9941@schroedinger.engr.sgi.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter <clameter@engr.sgi.com> wrote:
>
> Some allocations are restricted to a limited set of nodes (due to memory
>  policies or cpuset constraints). If the page allocator is not able to find
>  enough memory then that does not mean that overall system memory is low.
> 
>  In particular going postal and more or less randomly shooting at processes
>  is not likely going to help the situation but may just lead to suicide (the
>  whole system coming down).
> 
>  It is better to signal to the process that no memory exists given the
>  constraints that the process (or the configuration of the process) has
>  placed on the allocation behavior. The process may be killed but then the
>  sysadmin or developer can investigate the situation. The solution is similar
>  to what we do when running out of hugepages.
> 
>  This patch adds a check before we kill processes. At that
>  point performance considerations do not matter much so we just scan the zonelist
>  and reconstruct a list of nodes. If the list of nodes does not contain all
>  online nodes then this is a constrained allocation and we should kill the
>  currnet process.

Looks sane, thanks.  I made constrained_alloc() inline, to give the
compiler the best-possible chance of eliminating the impossible-on-UMA
switch cases.

