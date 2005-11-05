Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751280AbVKEIih@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751280AbVKEIih (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Nov 2005 03:38:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751283AbVKEIih
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Nov 2005 03:38:37 -0500
Received: from send.forptr.21cn.com ([202.105.45.51]:17305 "HELO 21cn.com")
	by vger.kernel.org with SMTP id S1751280AbVKEIig (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Nov 2005 03:38:36 -0500
Message-ID: <436C6FF7.4060206@21cn.com>
Date: Sat, 05 Nov 2005 16:40:23 +0800
From: Yan Zheng <yanzheng@21cn.com>
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Question about the usage of kernel_thread
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AIMC-AUTH: yanzheng
X-AIMC-MAILFROM: yanzheng@21cn.com
X-AIMC-Msg-ID: DE6bT8OB
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

In LKD2, Robert say:
Linux delegates several tasks to kernel threads, most notably the pdflush task and the ksoftirqd task. These threads are created on system boot by other kernel threads. Indeed, a kernel thread can be created only by another kernel thread. 


But I found that kernel_thread(...) are used wildly like:

#include <linux/kernel.h>
#include <linux/module.h>

static int noop(void *dummy)
{
        printk("current->mm = %p\n", current->mm);
        return 0;
}

static int test_init(void)
{
        kernel_thread(noop, NULL, CLONE_KERNEL | SIGCHLD);
        return 0;
}

static void test_exit(void) {}
module_init(test_init);
module_exit(test_exit); 


In this circumstances, The thread created by kernel_thread has "current->mm != NULL".

My question is:
The new thread is truely kernel thread ? The usage of kernel_thread(...) like this is correct?

Thanks advance.
Best Regards


