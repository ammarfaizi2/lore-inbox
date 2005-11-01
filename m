Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750918AbVKAVcw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750918AbVKAVcw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 16:32:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751265AbVKAVcw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 16:32:52 -0500
Received: from ns.dynamicweb.hu ([195.228.155.139]:9146 "EHLO dynamicweb.hu")
	by vger.kernel.org with ESMTP id S1750918AbVKAVcv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 16:32:51 -0500
Message-ID: <03c501c5df2c$9a19e2f0$0400a8c0@dcccs>
From: "JaniD++" <djani22@dynamicweb.hu>
To: "Paul Jackson" <pj@sgi.com>
Cc: <linux-kernel@vger.kernel.org>
References: <035101c5df17$223eccb0$0400a8c0@dcccs> <20051101123648.5743a5cf.pj@sgi.com>
Subject: Re: cpuset - question
Date: Tue, 1 Nov 2005 22:38:28 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1437
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2800.1441
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

----- Original Message ----- 
From: "Paul Jackson" <pj@sgi.com>
To: "JaniD++" <djani22@dynamicweb.hu>
Cc: <linux-kernel@vger.kernel.org>
Sent: Tuesday, November 01, 2005 9:36 PM
Subject: Re: cpuset - question


> JaniD++ wrote:
> > [root@dy-xeon-1 cpus_0]# /bin/echo 1 > mems
> > /bin/echo: write error: Numerical result out of range
> > [root@dy-xeon-1 cpus_0]# echo 1 >mems
> > [root@dy-xeon-1 cpus_0]# cat mems
> >
> > [root@dy-xeon-1 cpus_0]# /bin/echo $$ > tasks
> > /bin/echo: write error: No space left on device
>
> I'm guessing you are on a multi-processor, with a single
> memory node, not a NUMA system with multiple memory nodes.
>
> Or, at least, your kernel was compiled for that (with the
> CONFIG_NUMA option disabled).

Yes, this option is disabled.
This is a dual-xeon server with HT.
With HT looks 4 CPU.

In this config i need NUMA option enabled to use cpusets?

I only need to move my 4 gnbd-client process to 4 cpuset, but i don't want
to touch the memory.
This is possible, or need the CONFIG_NUMA=y option?

Thanks

Janos

>
> The first echo above failed because you tried to set bit 1
> in mems, but only bit 0 is valid (only one memory node).
>
> The second echo failed too, but your shells (like most
> shells) builtin echo didn't display the error.
>
> The 'cat mems' command showed that mems was not yet set,
> which is indeed the case.
>
> The third and final echo above, into 'tasks' failed because
> you can't attach a task to a cpuset that has no memory specified.
>
> If you had done '/bin/echo 0 > mems', it would have worked
> much better.
>
> -- 
>                   I won't rest till it's the best ...
>                   Programmer, Linux Scalability
>                   Paul Jackson <pj@sgi.com> 1.925.600.0401
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

