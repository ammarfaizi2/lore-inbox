Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751438AbWCBK7u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751438AbWCBK7u (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 05:59:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751451AbWCBK7u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 05:59:50 -0500
Received: from uproxy.gmail.com ([66.249.92.194]:7605 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751438AbWCBK7t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 05:59:49 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:sender;
        b=qSRtM31v/Ot8GsT7n5ld+DoTikqM7P/5khuxuyRRjLecSpA5ZWK5M3gkslhzX42U9dvsr5d5FBFh+OMy1tnyqrh2ae9htzvQp8/eWJ4yG2O0eM3KCs90Cn2eXGOC4rKj5KGooABa0MiZfE3gcSMJM5aANsK3N0vwEpkhEGAKBAo=
Date: Thu, 2 Mar 2006 11:59:40 +0100
From: Frederik Deweerdt <deweerdt@free.fr>
To: Simon Derr <Simon.Derr@bull.net>
Cc: linux-kernel@vger.kernel.org, FACCINI BRUNO <Bruno.Faccini@bull.net>
Subject: Re: Deadlock in net/sunrpc/sched.c
Message-ID: <20060302105940.GA9521@silenus.home.res>
References: <Pine.LNX.4.61.0603021116030.15393@openx3.frec.bull.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0603021116030.15393@openx3.frec.bull.fr>
User-Agent: mutt-ng/devel-r781 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 02, 2006 at 11:38:10AM +0100, Simon Derr wrote:
> This happened with 2.6.12 but it seems that the code has not changed and 
> the issue is very probably still present in the current kernels.
Looks like it's fixed in 2.6.16-rc5, could you check agains the current
tree?

> +	spin_lock_bh(&queue->lock);
>  	if (rpc_start_wakeup(task)) {
>  		if (RPC_IS_QUEUED(task)) {
>  			struct rpc_wait_queue *queue = task->u.tk_wait.rpc_waitq;
>  
> -			spin_lock_bh(&queue->lock);
>  			__rpc_do_wake_up_task(task);
> -			spin_unlock_bh(&queue->lock);
>  		}
>  		rpc_finish_wakeup(task);
>  	}
> +	spin_unlock_bh(&queue->lock);

Hmm, not sure this will even compile...
Regards,
Frederik
