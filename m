Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262061AbTCRA1Q>; Mon, 17 Mar 2003 19:27:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262062AbTCRA1P>; Mon, 17 Mar 2003 19:27:15 -0500
Received: from packet.digeo.com ([12.110.80.53]:57472 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S262061AbTCRA1O>;
	Mon, 17 Mar 2003 19:27:14 -0500
Date: Mon, 17 Mar 2003 16:05:56 -0800
From: Andrew Morton <akpm@digeo.com>
To: Nigel Cunningham <ncunningham@clear.net.nz>
Cc: pavel@ucw.cz, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Don't refill pcp lists during SWSUSP.
Message-Id: <20030317160556.4efc880f.akpm@digeo.com>
In-Reply-To: <1047945372.1714.19.camel@laptop-linux.cunninghams>
References: <1047945372.1714.19.camel@laptop-linux.cunninghams>
X-Mailer: Sylpheed version 0.8.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 18 Mar 2003 00:11:44.0721 (UTC) FILETIME=[F59C2410:01C2ECE2]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nigel Cunningham <ncunningham@clear.net.nz> wrote:
>
> +extern unsigned int suspend_task;


Please do:

#ifdef CONFIG_SOFTWARE_SUSPEND
unsigned int suspend_task;
#else
#define suspend_task 0
#endif

so the compiler can remove the few fast-path instructions which you have
added.

>  	
> +	suspend_task = current->pid;
> +

Zero is a valid PID (the idle task...).  It might be clearer to make
suspend_task a task_struct*.

