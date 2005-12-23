Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030439AbVLWHul@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030439AbVLWHul (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Dec 2005 02:50:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030448AbVLWHul
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Dec 2005 02:50:41 -0500
Received: from [210.76.108.235] ([210.76.108.235]:22276 "EHLO in")
	by vger.kernel.org with ESMTP id S1030439AbVLWHul (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Dec 2005 02:50:41 -0500
Message-ID: <43ABAC48.20004@ccoss.com.cn>
Date: Fri, 23 Dec 2005 15:50:32 +0800
From: liyu <liyu@ccoss.com.cn>
User-Agent: Mozilla Thunderbird 1.0.6 (Windows/20050716)
X-Accept-Language: zh-cn,zh
MIME-Version: 1.0
To: Al Viro <viro@ftp.linux.org.uk>
CC: linux-kernel@vger.kernel.org
Subject: Re: [WTF?] sys_tas() on m32r
References: <20051223061556.GR27946@ftp.linux.org.uk>
In-Reply-To: <20051223061556.GR27946@ftp.linux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Al Viro 写道:

>asmlinkage int sys_tas(int *addr)
>{
>        int oldval;
>        unsigned long flags;
>
>        if (!access_ok(VERIFY_WRITE, addr, sizeof (int)))
>                return -EFAULT;
>        local_irq_save(flags);
>        oldval = *addr;
>        if (!oldval)
>                *addr = 1;
>        local_irq_restore(flags);
>        return oldval;
>}
>in arch/m32r/kernel/sys_m32r.c.  Trivial oops *AND* ability to trigger
>IO with interrupts disabled.
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>
>  
>
The memory that parameter addr pointer is in user-space.
To access these memory, you should use function like copy_from_user().

-liyu




