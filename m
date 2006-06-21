Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751165AbWFUGFg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751165AbWFUGFg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 02:05:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751184AbWFUGFg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 02:05:36 -0400
Received: from terminus.zytor.com ([192.83.249.54]:39308 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1751165AbWFUGFg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 02:05:36 -0400
Message-ID: <4498E1AB.5050107@zytor.com>
Date: Tue, 20 Jun 2006 23:05:31 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Masatake YAMATO <jet@gyve.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: [patch] sharing maximum errno symbol used in __syscall_return
 (i386)
References: <20060620.184010.225581173.jet@gyve.org>	<4498C95A.3090909@zytor.com> <20060621.150212.138089156.jet@gyve.org>
In-Reply-To: <20060621.150212.138089156.jet@gyve.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Masatake YAMATO wrote:
>>> Hi,
>>>
>>> __syscall_return in unistd.h is maintained?
>>>
>>> In the macro the value returned from system call is
>>> compared with the maximum error number defined in a header file 
>>> to know the call is successful or not. However, the maximum error number 
>>> is hard-coded and is not updated.
>>>
>> And it's wrong, anyway.  It has long been agreed that the maximum errno 
>> value, for any architecture, is 4095.
> 
> So we should do just:
> 
> 
>    #define GENERIC_ERRNO_MAX 4095
> 
> Here my patch is proved to be useful for maintaining __syscall_return:-P
>  

Well, most of the various macros in unistd.h really should go too, since 
they're mostly underutilized and definitely ill-maintained.

The only one that I know of which is still used by the kernel itself is 
execve.  If so, perhaps we should just have an open-coded execve.

	-hpa
