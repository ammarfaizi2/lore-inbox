Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261184AbUEACTe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261184AbUEACTe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Apr 2004 22:19:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261615AbUEACTe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Apr 2004 22:19:34 -0400
Received: from fw.osdl.org ([65.172.181.6]:8083 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261184AbUEACTd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Apr 2004 22:19:33 -0400
Date: Fri, 30 Apr 2004 19:19:01 -0700
From: Andrew Morton <akpm@osdl.org>
To: vatsa@in.ibm.com
Cc: rusty@rustcorp.com.au, mingo@elte.hu, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix deadlock in __create_workqueue
Message-Id: <20040430191901.510ae947.akpm@osdl.org>
In-Reply-To: <20040430113751.GA18296@in.ibm.com>
References: <20040430113751.GA18296@in.ibm.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Srivatsa Vaddagiri <vatsa@in.ibm.com> wrote:
>
> Noticed a possible deadlock in __create_workqueue when CONFIG_HOTPLUG_CPU is
> set.  This can happen when create_workqueue_thread fails to create a worker
> thread. In that case, we call destroy_workqueue with cpu hotplug lock held.
> destroy_workqueue however also attempts to take the same lock.
> 
> Patch below address this deadlock as well as a kthread_stop race. 

Fixing a kthread_stop() race is a quite different thing from fixing a
create-workqueue() error-path deadlock and hence should be a separate
patch.

And the description of that separate patch should explain the race which
it is fixing!  Yes, the logic in worker_thread() is a bit dorky, but I
don't believe that there is a race in there.

I dropped that part of your patch.  Please resend, with justification, if
you disagree.

Thanks.
