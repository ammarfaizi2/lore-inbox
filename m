Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262535AbVAJWqV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262535AbVAJWqV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 17:46:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262624AbVAJWmv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 17:42:51 -0500
Received: from wproxy.gmail.com ([64.233.184.195]:12706 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262592AbVAJWkZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 17:40:25 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=C2idlTQ0/v53hDy988juY9j0tnvIQePDcTS19Ii7wEoJbyoiJglEqXCFwsR0seBgNOfvIX/ubqaOvHfOjKXvJ1qv2nDb1JePE9Y0jObd92kTJT8XzN1qYFhydR3Ys7C4PXyrflqdEHHx0S3B1U3mWvn+9d9Dt6iDTPazjm/4eOw=
Message-ID: <4d6522b9050110144017d0c075@mail.gmail.com>
Date: Tue, 11 Jan 2005 00:40:24 +0200
From: Edjard Souza Mota <edjard@gmail.com>
Reply-To: Edjard Souza Mota <edjard@gmail.com>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Subject: Re: User space out of memory approach
Cc: Mauricio Lin <mauriciolin@gmail.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20050110192012.GA18531@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <3f250c71050110134337c08ef0@mail.gmail.com>
	 <20050110192012.GA18531@logos.cnet>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I guess it the idea was not fully and well explained. It is not the OOM Killer
itself that was moved to user space but rather its ranking algorithm.
Ranking is not an specific functionality of kernel space. Kernel only need
to know which process whould be killed.

In that sense the approach is different and might be worth testing, mainly for
cases where we want to allow better policies of ranking. For example, an
embedded device with few resources and important different running applications:
whic one is the best? To my understanding the current ranking policy
does not necessarily chooses the best one to be killed.

br

Edjard


On Mon, 10 Jan 2005 17:20:13 -0200, Marcelo Tosatti
<marcelo.tosatti@cyclades.com> wrote:
> On Mon, Jan 10, 2005 at 05:43:23PM -0400, Mauricio Lin wrote:
> > Hi all,
> >
> > We have done a comparison between the kernel version and user space
> > version and apparently the behavior is similar. You can also get this
> > patch and module to test it and compare with kernel OOM Killer. Here
> > goes a patch and a module that moves the kernel space OOM Killer
> > algorithm to user space. Let us know about your ideas.
> 
> No comments on the code itself - It is interesting to have certain pids "not selectable" by
> the OOM killer. Patches which have similar funcionality have been floating around.
> 
> The userspace OOM killer is dangerous though. You have to guarantee that allocations
> will NOT happen until the OOM killer is executed and the killed process is dead and
> has its pages freed - allocations under OOM can cause deadlocks.
> 
> "OOM-killer-in-userspace" is unreliable, not sure if its worth the effort making
> it reliable (mlock it, flagged as PF_MEMALLOC, etc).
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


-- 
"In a world without fences ... who needs Gates?"
