Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261310AbTINTtC (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Sep 2003 15:49:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261298AbTINTtC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Sep 2003 15:49:02 -0400
Received: from dbl.q-ag.de ([80.146.160.66]:58271 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S261310AbTINTtA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Sep 2003 15:49:00 -0400
Message-ID: <3F64C627.8060708@colorfullife.com>
Date: Sun, 14 Sep 2003 21:48:55 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030701
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] add likely around access_ok for uaccess
References: <3F644E36.5010402@colorfullife.com> <20030914123024.4a261cd3.akpm@osdl.org> <3F64C55A.10306@colorfullife.com>
In-Reply-To: <3F64C55A.10306@colorfullife.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Manfred Spraul wrote:

> Andrew Morton wrote:
>
>> +#define access_ok(type,addr,size) (likely(__range_ok(addr,size) == 0))
>>  
>>
> I don't know. What happens if access_ok is used outside of an if 
> statement?
> One example is
>
> int get_compat_timespec(struct timespec *ts, struct compat_timespec *cts)
> {
>        return (verify_area(VERIFY_READ, cts, sizeof(*cts)) ||
>                        __get_user(ts->tv_sec, &cts->tv_sec) ||
>                        __get_user(ts->tv_nsec, &cts->tv_nsec)) ? 
> -EFAULT : 0;
> }

Duh. Reading is difficult.
The functions with access_ok are get_compat_itimerval and 
put_compat_itimerval.

--
    Manfred

