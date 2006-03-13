Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932324AbWCMKIh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932324AbWCMKIh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 05:08:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932333AbWCMKIh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 05:08:37 -0500
Received: from sainfoin.extra.cea.fr ([132.166.172.103]:35275 "EHLO
	sainfoin.extra.cea.fr") by vger.kernel.org with ESMTP
	id S932324AbWCMKIg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 05:08:36 -0500
Message-Id: <200603131007.LAA10812@styx.bruyeres.cea.fr>
Date: Mon, 13 Mar 2006 11:07:52 +0100
From: Aurelien Degremont <aurelien.degremont@cea.fr>
User-Agent: Mozilla Thunderbird 1.0.6-1.4.1 (X11/20050719)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Trond Myklebust <trond.myklebust@fys.uio.no>
CC: Jacques-Charles Lafoucriere <jc.lafoucriere@cea.fr>,
       Bruno Faccini <bruno.faccini@bull.net>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix deadlock in RPC scheduling code.
References: <200603091035.LAA04829@styx.bruyeres.cea.fr>	 <1141915219.8293.5.camel@lade.trondhjem.org>	 <200603101510.QAA17788@styx.bruyeres.cea.fr> <1142004255.8041.26.camel@lade.trondhjem.org>
In-Reply-To: <1142004255.8041.26.camel@lade.trondhjem.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trond Myklebust wrote:
> Yes. The RPC_TASK_QUEUED bit can only be cleared when both the
> RPC_TASK_WAKEUP bit _and_ the queue spinlock are held.
> If you are holding either one of those two, then it is safe to test for
> RPC_IS_QUEUED(). If the latter is true, then it is also safe to
> dereference the value of task->u.tk_wait.rpc_waitq.

Hmmm... With those constraints, it seems difficult to be able to modify 
the current rpc_wake_up_task() function...

But, are you sure the patch you provided is sufficient to remove the 
potential deadlock we faced ? I do not see how, could you explain ?

-- 
Aurelien Degremont

