Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264263AbUD0SY2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264263AbUD0SY2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Apr 2004 14:24:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264266AbUD0SUw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Apr 2004 14:20:52 -0400
Received: from dbl.q-ag.de ([213.172.117.3]:42116 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S264262AbUD0SJ4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Apr 2004 14:09:56 -0400
Message-ID: <408EA1DF.6050303@colorfullife.com>
Date: Tue, 27 Apr 2004 20:09:35 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.4.1) Gecko/20031114
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Jakub Jelinek <jakub@redhat.com>
Subject: Re: [PATCH] per-user signal pending and message queue limits
References: <20040419212810.GB10956@logos.cnet> <20040419224940.GY31589@devserv.devel.redhat.com> <20040420141319.GB13259@logos.cnet> <20040420130439.23fae566.akpm@osdl.org> <20040420231351.GB13826@logos.cnet> <20040420163443.7347da48.akpm@osdl.org> <20040421203456.GC16891@logos.cnet> <40875944.4060405@colorfullife.com> <20040427145424.GA10530@logos.cnet>
In-Reply-To: <20040427145424.GA10530@logos.cnet>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Tosatti wrote:

>@@ -849,6 +892,10 @@ asmlinkage long sys_mq_timedsend(mqd_t m
> 		goto out_fput;
> 	}
> 
>+	if(current->user->msg_queues + msg_len
>+		  >= current->rlim[RLIMIT_MSGQUEUE].rlim_cur)
>+		goto out_fput;
>+
>
I don't like that:
The opengroup manpage doesn't mention out of memory as an error code for 
mq_send(). I'd prefer if mq_open would check that 
->mq_maxmsg*->mq_msgsize is below the limit and reserve the memory, 
without further checks at send/receive time.

--
    Manfred

