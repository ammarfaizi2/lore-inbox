Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262732AbUC2IJc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Mar 2004 03:09:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262733AbUC2IJc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Mar 2004 03:09:32 -0500
Received: from pr-117-210.ains.net.au ([202.147.117.210]:28867 "EHLO
	mail.ocs.com.au") by vger.kernel.org with ESMTP id S262732AbUC2IJa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Mar 2004 03:09:30 -0500
X-Mailer: exmh version 2.6.3_20040314 03/14/2004 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] 2.6.5-rc2 __WAITQUEUE_INITIALIZER 
In-reply-to: Your message of "Sun, 28 Mar 2004 22:53:22 PST."
             <20040328225322.05ac9f7b.akpm@osdl.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 29 Mar 2004 18:09:06 +1000
Message-ID: <2289.1080547746@ocs3.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 28 Mar 2004 22:53:22 -0800, 
Andrew Morton <akpm@osdl.org> wrote:
>Keith Owens <kaos@ocs.com.au> wrote:
>>
>> When struct __wait_queue is on stack or you reuse an existing
>> waitqueue, you get garbage in the flags.
>> 
>> Index: 5-rc2.1/include/linux/wait.h
>> --- 5-rc2.1/include/linux/wait.h Thu, 18 Dec 2003 16:46:13 +1100 kaos (linux-2.6/m/c/34_wait.h 1.1 644)
>> +++ 5-rc2.1(w)/include/linux/wait.h Mon, 29 Mar 2004 15:36:39 +1000 kaos (linux-2.6/m/c/34_wait.h 1.1 644)
>> @@ -40,6 +40,7 @@ typedef struct __wait_queue_head wait_qu
>>   */
>>  
>>  #define __WAITQUEUE_INITIALIZER(name, tsk) {				\
>> +	.flags		= 0,						\
>>  	.task		= tsk,						\
>>  	.func		= default_wake_function,			\
>>  	.task_list	= { NULL, NULL } }
>
>The compiler will do this for us?

I thought I had a test case where the flags were not being set to 0,
but cannot reproduce it.  Ignore this patch unless I get some real
evidence.

