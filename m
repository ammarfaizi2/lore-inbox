Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263788AbUE2Cmm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263788AbUE2Cmm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 May 2004 22:42:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263789AbUE2Cmm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 May 2004 22:42:42 -0400
Received: from fw.osdl.org ([65.172.181.6]:17619 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263788AbUE2Cmf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 May 2004 22:42:35 -0400
Date: Fri, 28 May 2004 19:38:55 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: vimpagliazzo@libero.it
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: multiple printk problem
Message-Id: <20040528193855.27231ea1.rddunlap@osdl.org>
In-Reply-To: <20040528165600.1971fdc0.rddunlap@osdl.org>
References: <20040528165600.1971fdc0.rddunlap@osdl.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.8a (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


| Hi, I'm quite new to kernel module programming,
| I was wondering why multiple consecutive calls to printk will not be 
| correctly logged by the system logger (linux-2.4.25 with metalog without 
| buffering in my case).
| 
| Consider for example the following example, only the first message can 
| be found in logs:
| 
|     #include <linux/version.h>
|     #include <linux/init.h>
|     #include <linux/module.h>
|     #include <linux/kernel.h>
| 
| 
|     MODULE_AUTHOR ("Vito Impagliazzo <vimpagliazzo@libero.it>");
|     MODULE_DESCRIPTION ("Hello World");
|     MODULE_LICENSE("Dual BSD/GPL");
| 
|     static int hello_init(void)
|     {
|         printf(KERN_ALERT "1\n");
|         printf(KERN_ALERT "2\n");
|         printf(KERN_ALERT "3\n");
|         return 0;
|     }
| 
|     static void hello_exit(void)
|     {
|         printk(KERN_ALERT "Goodbye, cruel world\n");
|     }
| 
| module_init(hello_init);
| module_exit(hello_exit);

Hi,

Your module works fine if you change "printf" to "printk".

If you still fail to see all 3 messages, it's a metalog
problem and not a kernel problem.
You should be able to contact them at
	http://sourceforge.net/projects/metalog/

--
~Randy
