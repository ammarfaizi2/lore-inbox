Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261636AbVBYVbn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261636AbVBYVbn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Feb 2005 16:31:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261667AbVBYVbn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Feb 2005 16:31:43 -0500
Received: from fire.osdl.org ([65.172.181.4]:2716 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261636AbVBYVbl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Feb 2005 16:31:41 -0500
Date: Fri, 25 Feb 2005 13:30:34 -0800
From: Andrew Morton <akpm@osdl.org>
To: Jay Lan <jlan@sgi.com>
Cc: kaigai@ak.jp.nec.com, lse-tech@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, guillaume.thouvenin@bull.net,
       tim@physik3.uni-rostock.de, erikj@subway.americas.sgi.com,
       limin@dbear.engr.sgi.com, jbarnes@sgi.com
Subject: Re: [Lse-tech] Re: A common layer for Accounting packages
Message-Id: <20050225133034.09da67f9.akpm@osdl.org>
In-Reply-To: <421F6139.5020207@sgi.com>
References: <42168D9E.1010900@sgi.com>
	<20050218171610.757ba9c9.akpm@osdl.org>
	<421993A2.4020308@ak.jp.nec.com>
	<421B955A.9060000@sgi.com>
	<421C2B99.2040600@ak.jp.nec.com>
	<421CEC38.7010008@sgi.com>
	<421EB299.4010906@ak.jp.nec.com>
	<20050224212839.7953167c.akpm@osdl.org>
	<421F6139.5020207@sgi.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jay Lan <jlan@sgi.com> wrote:
>
> Andrew Morton wrote:
>  > Kaigai Kohei <kaigai@ak.jp.nec.com> wrote:
>  > 
>  >>In my understanding, what Andrew Morton said is "If target functionality can
>  >> implement in user space only, then we should not modify the kernel-tree".
>  > 
>  > 
>  > fork, exec and exit upcalls sound pretty good to me.  As long as
>  > 
>  > a) they use the same common machinery and
>  > 
>  > b) they are next-to-zero cost if something is listening on the netlink
>  >    socket but no accounting daemon is running.
>  > 
>  > Question is: is this sufficient for CSA?
> 
>  Yes, fork, exec, and exit upcalls are sufficient for CSA.
> 
>  The framework i proposed earlier should satisfy your requirement a
>  and b, and provides upcalls needed by BSD, ELSA and CSA. Maybe i
>  misunderstood your concern of the 'very light weight' framework
>  i proposed besides being "overkill"?

"upcall" is poorly defined.

What I meant was that ELSA can perform its function when the kernel merely
sends asynchronous notifications of forks out to userspace via netlink.

Further, I'm wondering if CSA can perform its function with the same level
of kernel support, perhaps with the addition of netlink-based notification
of exec and exit as well.

The framework patch which you sent was designed to permit the addition of
more kernel accounting code, which is heading in the opposite direction.

In other words: given that ELSA can do its thing via existing accounting
interfaces and a fork notifier, why does CSA need to add lots more kernel
code?
