Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262668AbVAKKFr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262668AbVAKKFr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 05:05:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262670AbVAKKFr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 05:05:47 -0500
Received: from wproxy.gmail.com ([64.233.184.200]:55877 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262668AbVAKKFk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 05:05:40 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=KFeo/9+AmpeeQ7AMCptpbwgqvwUVCslHck3JrGGagNUvShSxgQdn9lyFbqHBPf6lZgYgnpZnLXAqCRcl0SszzblNwmprf3slTGfzYID6Uq55gsFsOki00NrqExRe8hR72/aB/0MJARfiWIGgkBT625oH3N8zaSWV7xQiklGLfJY=
Message-ID: <4d6522b905011102052e16092e@mail.gmail.com>
Date: Tue, 11 Jan 2005 12:05:40 +0200
From: Edjard Souza Mota <edjard@gmail.com>
Reply-To: Edjard Souza Mota <edjard@gmail.com>
To: Andrea Arcangeli <andrea@suse.de>
Subject: Re: User space out of memory approach
Cc: Thomas Gleixner <tglx@linutronix.de>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Mauricio Lin <mauriciolin@gmail.com>,
       LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
In-Reply-To: <20050111095616.GH26799@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <3f250c71050110134337c08ef0@mail.gmail.com>
	 <20050110192012.GA18531@logos.cnet>
	 <4d6522b9050110144017d0c075@mail.gmail.com>
	 <20050110200514.GA18796@logos.cnet>
	 <1105403747.17853.48.camel@tglx.tec.linutronix.de>
	 <4d6522b90501101803523eea79@mail.gmail.com>
	 <1105433093.17853.78.camel@tglx.tec.linutronix.de>
	 <4d6522b905011101202918f361@mail.gmail.com>
	 <1105435846.17853.85.camel@tglx.tec.linutronix.de>
	 <20050111095616.GH26799@dualathlon.random>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> Allowing userspace to tune is a great idea. However we cannot invoke
> userland at oom-time to make the decision, or it would be deadlock prone
> (userland may be swapped out or it might require minor allocations of
> memory, if we were to allow userspace to do the decision it would be
> required to be a mlockall userland and not allowed to do syscalls, and
> even then it could mess up with the stack or signal handlers).

Hmm, no it is not the case. The deamon application would start from the
boot. It only keeps the list of candidates whenever you're getting
close to red zone.
There is no deadlock.

Deamon just started at user space, and does only calculation. It doesn't
take decision at all. That OOM killer at kernel level who get the list
and chooses
who to shoot dead.

> So the safe thing to do is to assign different ratings to different userspace
> tasks. Of course this is inherited from the childs. That is a reasonable
> approach IMHO. Kurt wrote that patch, I only ported it to a more recent
> codebase.

Could be. Interesting idea. We shall keep thinking about it. Have you done
some experiment like that?

> 
> This way you can rate your important services and the not important
> ones.
> 
> Anyway as you've mentioned in a earlier email, there were more
> fundamental problems than the selection algorithm, the userspace rating
> was the lowest one in the prio list.
> 

Yes, agreed. Our point was just to re-organize current OOM killer to release the
kernel from doing rating, which is not its task any way.

br

Edjard
-- 
"In a world without fences ... who needs Gates?"
