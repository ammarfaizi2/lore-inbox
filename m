Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267167AbUBSKLR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 05:11:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267175AbUBSKLQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 05:11:16 -0500
Received: from mail1.webmessenger.it ([193.70.193.50]:43431 "EHLO
	mail1c.webmessenger.it") by vger.kernel.org with ESMTP
	id S267167AbUBSKLL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 05:11:11 -0500
Message-ID: <40348BBA.9000206@libero.it>
Date: Thu, 19 Feb 2004 11:11:06 +0100
From: Vito Impagliazzo <vimpagliazzo@libero.it>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: multiple printk problem
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, I'm quite new to kernel module programming,
I was wondering why multiple consecutive calls to printk will not be 
correctly logged by the system logger (linux-2.4.25 with metalog without 
buffering in my case).

Consider for example the following example, only the first message can 
be found in logs:

    #include <linux/version.h>
    #include <linux/init.h>
    #include <linux/module.h>
    #include <linux/kernel.h>


    MODULE_AUTHOR ("Vito Impagliazzo <vimpagliazzo@libero.it>");
    MODULE_DESCRIPTION ("Hello World");
    MODULE_LICENSE("Dual BSD/GPL");

    static int hello_init(void)
    {
        printf(KERN_ALERT "1\n");
        printf(KERN_ALERT "2\n");
        printf(KERN_ALERT "3\n");
        return 0;
    }

    static void hello_exit(void)
    {
        printk(KERN_ALERT "Goodbye, cruel world\n");
    }

module_init(hello_init);
module_exit(hello_exit);

Thanks,
Vito Impagliazzo
