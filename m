Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264983AbUFAL1K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264983AbUFAL1K (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jun 2004 07:27:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264987AbUFAL1J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jun 2004 07:27:09 -0400
Received: from smtp-roam.Stanford.EDU ([171.64.10.152]:54197 "EHLO
	smtp-roam.Stanford.EDU") by vger.kernel.org with ESMTP
	id S264983AbUFAL06 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jun 2004 07:26:58 -0400
Message-ID: <40BC67F9.3000609@myrealbox.com>
Date: Tue, 01 Jun 2004 04:26:49 -0700
From: Andy Lutomirski <luto@myrealbox.com>
User-Agent: Mozilla Thunderbird 0.6 (Windows/20040502)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: luto@myrealbox.com
Subject: Re: 2.6.7-rc2-mm1
References: <20040601021539.413a7ad7.akpm@osdl.org>
In-Reply-To: <20040601021539.413a7ad7.akpm@osdl.org>
Content-Type: multipart/mixed;
 boundary="------------090300060001060401080107"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090300060001060401080107
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Andrew Morton wrote:

> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.7-rc2/2.6.7-rc2-mm1/
> 

This doesn't compile for me on x86 without local apic.  Something like this 
seems to fix it.  (Dunno if it's the right fix, and sorry about the 
attached patch -- I'm too tired to use a different mailer.)

--Andy

--------------090300060001060401080107
Content-Type: text/plain;
 name="nmifix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="nmifix.patch"

Signed-off-by: Andy Lutomirski <luto@myrealbox.com>

 sysctl.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

--- 2.6.7-rc2-mm1/kernel/sysctl.c~nmifix	2004-06-01 04:20:07.000000000 -0700
+++ 2.6.7-rc2-mm1/kernel/sysctl.c	2004-06-01 04:21:40.000000000 -0700
@@ -63,7 +63,7 @@
 extern int printk_ratelimit_jiffies;
 extern int printk_ratelimit_burst;
 
-#if defined(__i386__)
+#ifdef CONFIG_X86_LOCAL_APIC
 extern int unknown_nmi_panic;
 extern int proc_unknown_nmi_panic(ctl_table *, int, struct file *,
 				  void __user *, size_t *);
@@ -624,7 +624,7 @@
 		.mode		= 0444,
 		.proc_handler	= &proc_dointvec,
 	},
-#if defined(__i386__)
+#ifdef CONFIG_X86_LOCAL_APIC
 	{
 		.ctl_name       = KERN_UNKNOWN_NMI_PANIC,
 		.procname       = "unknown_nmi_panic",

--------------090300060001060401080107--
