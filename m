Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932512AbVHaMXP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932512AbVHaMXP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Aug 2005 08:23:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932513AbVHaMXP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Aug 2005 08:23:15 -0400
Received: from wproxy.gmail.com ([64.233.184.202]:28705 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932512AbVHaMXO convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Aug 2005 08:23:14 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=GzFcVXcIegByydbH/g+zdLyMHTVhm0nEqu9Qr0P9ExZZekwr5reTO7ebZ0pH3maYQ0GzHC+6tcTgTC3U/RLFOpzras5mtzg9xLljz8QCkv38DBo8nBOkRSCHROEpbu8tXx9/5ICRIi8BmH+ehgT/0Woy2ukbzD1gyJC9cKwG8Zs=
Message-ID: <1e33f57105083105237975882d@mail.gmail.com>
Date: Wed, 31 Aug 2005 17:53:09 +0530
From: Gaurav Dhiman <gaurav4lkg@gmail.com>
To: "liyu@WAN" <liyu@ccoss.com.cn>
Subject: Re: [Question] How get instruction pointer of user space ???
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <43157F88.60900@ccoss.com.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <43157F88.60900@ccoss.com.cn>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/31/05, liyu@WAN <liyu@ccoss.com.cn> wrote:
> Hi everyone:
> 
>     I am implemnting one ioctl() in one character device.
> 
>     That need know instruction pointer of user space. I am on i386
> platform.
> I can sure I am in process context. and enter kernel by system call way.
> 
>     As I known, in default case, each task have one kernel stack, its length
> is THREAD_SIZE(2 pages),  and current_thread_info() is at its top. the
> struct pt_regs is at bottom of this stack.
> 
>     so I write the code like here:
> 
>     pt_regs = ((struct pt_regs *)(THREAD_SIZE + current_thread_info()))+1;

try doing the following, I amnot sure of it, just try it.

pt_regs = (struct pt_regs *) (((int *)(THREAD_SIZE + current)) -
(sizeof(pt_regs) + 1));

>     return pt_regs->eip;
> 
>     but it do not work! even, I get segment fault and kernel Oops at
> sometime.
> 
>     Also, I am sure current_thread_info() return right value of current
> user task.
> 
>     Any idea on here?
> 
>     thanks
> 
> 
>                                                                    sailor.
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
