Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751242AbVLLMDk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751242AbVLLMDk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Dec 2005 07:03:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751243AbVLLMDk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Dec 2005 07:03:40 -0500
Received: from mail.tv-sign.ru ([213.234.233.51]:17339 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S1751242AbVLLMDj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Dec 2005 07:03:39 -0500
Message-ID: <439D78BE.5A06EAE3@tv-sign.ru>
Date: Mon, 12 Dec 2005 16:18:54 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Oren Laadan <orenl@cs.columbia.edu>
Cc: akpm@osdl.org, roland@redhat.com, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH ? 2/2] setpgid: should work for sub-threads
References: <200512110523.jBB5NVEr002551@shell0.pdx.osdl.net>
	 <439C605F.BA7C1D5B@tv-sign.ru> <Pine.LNX.4.63.0512111605430.31447@takamine.ncl.cs.columbia.edu>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oren Laadan wrote:
> 
> -void __set_special_pids(pid_t session, pid_t pgrp)
> +void __set_special_pids(struct task_struct *tsk, pid_t session, pid_t pgrp)
>   {
> -       struct task_struct *curr = current;

Do we need to add the new paramater? I think we can just do:

-       struct task_struct *curr = current;
+       struct task_struct *curr = current->group_leader;

and that's all. This function is called from daemonize() also,
but the kernel thread is a thread group leader always.

Oleg.
