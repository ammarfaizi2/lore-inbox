Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261445AbVGLOGT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261445AbVGLOGT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 10:06:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261446AbVGLOEO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 10:04:14 -0400
Received: from zproxy.gmail.com ([64.233.162.194]:7850 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261458AbVGLOD1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 10:03:27 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=kIkQOAdWot5tyg6om/nlHbzL+HLcagHkd2TNvC0BgyNPhSt+Mz+coSNFtq7PHR5OJ7UBouGWO3XmhDg62vw6a2H7lpPaqLcxoKuR4mkxLHLFNBii96Q8dLj1c2SfnwMAATcq0dkmoI2koHFWBfq6j0TjKh+8yVLOXt0GDm9MUMs=
Message-ID: <42D3CEEC.90603@gmail.com>
Date: Tue, 12 Jul 2005 16:08:44 +0200
From: Mateusz Berezecki <mateuszb@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050704)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Steven Rostedt <rostedt@goodmis.org>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: Re: "scheduling while atomic" ?
References: <42D3C37C.6040401@gmail.com> <1121175049.6917.19.camel@localhost.localdomain>
In-Reply-To: <1121175049.6917.19.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>When you say enable a lock, do you mean that you grabbed a lock?  Now if
>you grabbed a spinlock, it is really bad to then call schedule, since a
>another process that will grab that same spinlock will deadlock the CPU
>(on an SMP system). Since you are using locks (I'm also assuming that
>you are using spinlocks) I assume that you will be running this on a
>CONFIG_PREEMPT or SMP system.
>
>So the fix will be to release the lock before calling something that
>will schedule, and regrab it afterwards.
>  
>
Sorry for not being too precise. Yes, your assumptions were correct ;-)
I grab a lock using

spin_lock(&ieee->lock);

and release it using

spin_unlock(&ieee->lock);

there is quite a lot of debugging printk's inbetween. Can this be a cause ?

