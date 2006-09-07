Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751445AbWIGKBW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751445AbWIGKBW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Sep 2006 06:01:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751481AbWIGKBW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Sep 2006 06:01:22 -0400
Received: from wx-out-0506.google.com ([66.249.82.225]:12812 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751445AbWIGKBU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Sep 2006 06:01:20 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=hHlJFkVK8J/lA28E8fqZoxE5bgRJnZF9AROAPLIS3P/EraLY5jJHk0aHOh95AeVqtN+ZI6m11PoNdua1Pn+m5o+O0xejenENZpaRBHs83B0x70jdjuD6IPSj6oPVn8647djh/EdgCpr0ykA/eN0jy6rH06+AcbU7qvKe9i4vgr8=
Message-ID: <44FFEDE5.3040902@gmail.com>
Date: Thu, 07 Sep 2006 12:01:09 +0200
From: Tejun Heo <htejun@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060713)
MIME-Version: 1.0
To: Bo Yang <struggle@mail.nankai.edu.cn>
CC: linux-kernel@vger.kernel.org
Subject: Re: sleep for ever ?
References: <357552113.05297@mail.nankai.edu.cn>
In-Reply-To: <357552113.05297@mail.nankai.edu.cn>
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, there.

Bo Yang wrote:
> Hi ,
>     Take a look at following code :
> 
> DECLARE_WAITQUEUE(wait, current);
> 
> add_wait_queue(q, &wait);
> while (!condition) {
>         /* if there is an interrupt here , and the interrupt
>            is just the one the sleeping process wait
>            for , is this process sleep for the interrupt
>            for ever ?*/
>         set_current_state(TASK_INTERRUPTIBLE);
>         if (signal_pending(current))
>                 /* handle signal */
>         schedule();
> }
> set_current_state(TASK_RUNNING);
> remove_wait_queue(q, &wait);
> 
> Suppose the process just want to sleep for an hardware
> event , but before the set_current_state() call , the event
> come , is the process sleep for ever ?

I guess you already know it but please try not to post the same message
multiple times.

And, yes, you're responsible to set task state *before* testing for the
sleeping condition and sleep.  In the above code, you can lose the wake
up event and thus sleep indefinitely.

-- 
tejun
