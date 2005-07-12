Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262359AbVGLXiF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262359AbVGLXiF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 19:38:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262457AbVGLXiF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 19:38:05 -0400
Received: from zproxy.gmail.com ([64.233.162.201]:42878 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262359AbVGLXhx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 19:37:53 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=h6pPBFcBtTp2M9ytiBZf+4Ob2QRCVkLc6MFxnDJBr6L1aD5mf3lhK9vE6+O+5AmQAHfKcuknHp3qAOrCZlKH2Zz2iWsaNtyu89g/vcsRJQEprNBcCKwY+u1ZHR0J0MmBnu8cG9KdMCRpo14CQkGnP/RQmfnDyZ8lv6ZH/DY6XaU=
Message-ID: <42D45438.6040409@gmail.com>
Date: Tue, 12 Jul 2005 19:37:28 -0400
From: Keenan Pepper <keenanpepper@gmail.com>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050602)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Lee Revell <rlrevell@joe-job.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: realtime-preempt + reiser4?
References: <42D4201A.9050303@gmail.com> <1121198723.10580.10.camel@mindpipe>
In-Reply-To: <1121198723.10580.10.camel@mindpipe>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Revell wrote:
> Maybe you could apply the broken out reiser4 patches from -mm and the
> realtime preempt patches.  Testing with PREEMPT_DESKTOP and latency
> tracing enabled will tell you whether reiser4 has any latency hot spots.

I'm trying this now and it's not exactly trivial; the patches conflict 
in some places so I had to fix by hand. Now I've got it almost compiled 
but it says:

fs/built-in.o: In function `kcond_wait':
: undefined reference to `there_is_no_init_MUTEX_LOCKED_for_RT_semaphores'
fs/built-in.o: In function `kcond_timedwait':
: undefined reference to `there_is_no_init_MUTEX_LOCKED_for_RT_semaphores'

I naively changed these two calls from

init_MUTEX_LOCKED(&name);

to

init_MUTEX(&name);
down(&name);

but I'm not sure if that's right. I guess I'll see when I try to boot it!

Keenan
