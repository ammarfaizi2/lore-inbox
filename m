Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267614AbUIFIWz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267614AbUIFIWz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Sep 2004 04:22:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267620AbUIFIWz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Sep 2004 04:22:55 -0400
Received: from asplinux.ru ([195.133.213.194]:33808 "EHLO relay.asplinux.ru")
	by vger.kernel.org with ESMTP id S267614AbUIFIWw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Sep 2004 04:22:52 -0400
Message-ID: <413C211D.9010301@sw.ru>
Date: Mon, 06 Sep 2004 12:34:37 +0400
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; ru-RU; rv:1.2.1) Gecko/20030426
X-Accept-Language: ru-ru, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] removes unnessary print of space
References: <413C0CC5.4000807@sw.ru> <20040906000826.73157de6.akpm@osdl.org>
In-Reply-To: <20040906000826.73157de6.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>This patch removes unnessary print of space in bust_spinlocks().
>> printk("") wakeups klogd as well,
> 
> Until some smarty comes along and optimises printk() to skip empty strings.
> 
> An explicit wake_up_klogd() thing might make sense, rather than relying
> upon side-effects.
yup, you are right. I was the easiest, but not the best.
I'll make a patch with wakeup_klogd.

>>no need to print a space and make a mess.
> Can't say that I've ever noticed that space.
We did. Many times.

I've noticed another thing. There is a default bust_spinlocks() in 
lib/bust_spinlocks.c. 4 architectures including x86 have their own 
copies of it, which are exactly the same as the default one.

So do we really need lib/bust_spinlocks.c or we can move a signle copy 
of this function to kernel/printk.c?

Kirill

