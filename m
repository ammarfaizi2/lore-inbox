Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262350AbVCBQis@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262350AbVCBQis (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 11:38:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262351AbVCBQis
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 11:38:48 -0500
Received: from fire.osdl.org ([65.172.181.4]:17844 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262350AbVCBQg4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 11:36:56 -0500
Message-ID: <4225EBD4.8090302@osdl.org>
Date: Wed, 02 Mar 2005 08:37:40 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
Organization: OSDL
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: sounak chakraborty <sounakrin@yahoo.co.in>
CC: linux-kernel@vger.kernel.org
Subject: Re: compilation problem of modules
References: <20050302145907.17666.qmail@web53306.mail.yahoo.com>
In-Reply-To: <20050302145907.17666.qmail@web53306.mail.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

sounak chakraborty wrote:
> the code of the module that i written is as follows:
> #define MODULE
> #include <linux/module.h>
> #include <linux/proc_fs.h>
> #define MODULE_NAME "manti"
> struct manti
> {
>       char mm[20];
>  };
> static struct proc_dir_entry *example_dir;
> struct manti m1;
> int init_module(void)
> {
>   example_dir=proc_mkdir(MODULE_NAME,NULL);
>  if(example_dir==NULL)
>   {
>      printk("<1> error in creation of proc file\n");
>     }
>   else
>    printk("<1>success in creation of proc dir\n");
>   }
> void cleanup_module(void)
> {
>    remove_proc_entry(MODULE_NAME,NULL);
>   printk("<1>proc entry removed\n");
>  }
> 
> here iam just making one directory in the proc file
> named manti
> i am trying to  compile it like
> gcc -c proc.c 
> where the kernel version is 2.4.20-8
> 
> but i am getting following errors 
> 
> In file included from proc.c:5:
> /usr/include/linux/proc_fs.h:47: parse error before
> "off_t"
> /usr/include/linux/proc_fs.h:51: parse error before
> "off_t"
> /usr/include/linux/proc_fs.h:57: parse error before
> "mode_t"
> /usr/include/linux/proc_fs.h:59: parse error before
> "uid"
> /usr/include/linux/proc_fs.h:60: parse error before
> "gid"
> /usr/include/linux/proc_fs.h:70: parse error before
> "count"
> /usr/include/linux/proc_fs.h:72: parse error before
> "rdev"
> /usr/include/linux/proc_fs.h:176: parse error before
> "mode_t"
> /usr/include/linux/proc_fs.h: In function
> `proc_net_create':
> /usr/include/linux/proc_fs.h:177: `NULL' undeclared
> (first use in this function)
> /usr/include/linux/proc_fs.h:177: (Each undeclared
> identifier is reported only once
> /usr/include/linux/proc_fs.h:177: for each function it
> appears in.)
> /usr/include/linux/proc_fs.h: At top level:
> /usr/include/linux/proc_fs.h:181: parse error before
> "mode_t"
> /usr/include/linux/proc_fs.h: In function
> `create_proc_entry':
> /usr/include/linux/proc_fs.h:181: `NULL' undeclared
> (first use in this function)
> /usr/include/linux/proc_fs.h: In function
> `proc_symlink':
> /usr/include/linux/proc_fs.h:185: `NULL' undeclared
> (first use in this function)
> /usr/include/linux/proc_fs.h: At top level:
> /usr/include/linux/proc_fs.h:186: parse error before
> "mode_t"
> /usr/include/linux/proc_fs.h: In function
> `proc_mknod':
> /usr/include/linux/proc_fs.h:187: `NULL' undeclared
> (first use in this function)
> /usr/include/linux/proc_fs.h: In function
> `proc_mkdir':
> /usr/include/linux/proc_fs.h:189: `NULL' undeclared
> (first use in this function)
> /usr/include/linux/proc_fs.h: At top level:
> /usr/include/linux/proc_fs.h:192: parse error before
> "mode_t"
> /usr/include/linux/proc_fs.h:193: parse error before
> "off_t"
> /usr/include/linux/proc_fs.h:193:
> `create_proc_read_entry' declared as function
> returning a function
> /usr/include/linux/proc_fs.h:196: parse error before
> "mode_t"
> /usr/include/linux/proc_fs.h: In function
> `create_proc_info_entry':
> /usr/include/linux/proc_fs.h:197: `NULL' undeclared
> (first use in this function)
> /usr/include/linux/proc_fs.h: At top level:
> /usr/include/linux/proc_fs.h:203: `NULL' used prior to
> declaration
> proc.c: In function `init_module':
> proc.c:16: `NULL' has an incomplete type
> proc.c:17: invalid operands to binary ==
> proc.c: In function `cleanup_module':
> proc.c:26: `NULL' has an incomplete type
> 
> 
> 
> how to solve it 
> plz help me
> is my compilation method is wrong or something else 

compile/build is wrong.
a minimum 2.4 kernel build needs at least:

gcc -c -D__KERNEL__ -DMODULE -O2 -nostdinc proc.c

and probably a few other flags/options.

-- 
~Randy
