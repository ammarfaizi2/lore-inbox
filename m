Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267791AbTBRNdW>; Tue, 18 Feb 2003 08:33:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267792AbTBRNdW>; Tue, 18 Feb 2003 08:33:22 -0500
Received: from web21206.mail.yahoo.com ([216.136.175.8]:20879 "HELO
	web21206.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S267791AbTBRNdU>; Tue, 18 Feb 2003 08:33:20 -0500
Message-ID: <20030218134315.91052.qmail@web21206.mail.yahoo.com>
Date: Tue, 18 Feb 2003 05:43:15 -0800 (PST)
From: Srinivas Chinta <chintasrinivas_tech@yahoo.com>
Subject: Re: Help !! calling function in module from a user program 
To: Sudharsan Vijayaraghavan <svijayar@cisco.com>
In-Reply-To: <4.3.2.7.2.20030218181634.01fb5428@desh>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-1132932921-1045575795=:90960"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--0-1132932921-1045575795=:90960
Content-Type: text/plain; charset=us-ascii
Content-Id: 
Content-Disposition: inline

Hi,
One way of doing this is , by hooking up your function
inside the module as a system call.
Here i'm sending two files, module.c and user_space.c.
first do "insmod module.o" and then run
"./user_space".
As i'm also a newbee, i'm not aware of the
disadvantages of this approach.

thanks,
Srinivasu Chinta.

--- Sudharsan Vijayaraghavan <svijayar@cisco.com>
wrote:
> Hi,
> 
> Am a new bee to linux internals.
> I am trying to make a simple program witch will call
> a function from a 
> module. I made a module compiled it and INSMOD-it
> into kernel, that works 
> fine. I would like to call from my user program a
> function defined in my 
> kernel module.
> 
> Please suggest any method thro' which this could be
> accomplished.
> The only way i did it was by running my new module
> as insmod mymodule.o and 
> get my job done.
> 
> Thanks,
> Sudharsan.
> 
> -
> To unsubscribe from this list: send the line
> "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at 
> http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


__________________________________________________
Do you Yahoo!?
Yahoo! Shopping - Send Flowers for Valentine's Day
http://shopping.yahoo.com
--0-1132932921-1045575795=:90960
Content-Type: text/plain; name="module.c"
Content-Description: module.c
Content-Disposition: inline; filename="module.c"

#define MODULE
#define __KERNEL__
#include <linux/module.h>
#include <linux/kernel.h>

extern void *sys_call_table[];
void * org_func;

static void my_func()
{
        printk("Executing my_func...!");
}
int init_module(void)
{
        printk("init_module ...!");
        org_func = sys_call_table[250];
        sys_call_table[250] = my_func;
        return 0;
}
void cleanup_module()
{
        sys_call_table[250] = org_func;
        printk("cleaning up...!");
}

--0-1132932921-1045575795=:90960
Content-Type: text/plain; name="user_space.c"
Content-Description: user_space.c
Content-Disposition: inline; filename="user_space.c"

#include <stdio.h>
#include <errno.h>
#include <asm/unistd.h>
#define __NR_my_func 250

_syscall0(void, my_func);

main()
{
        my_func();
}

--0-1132932921-1045575795=:90960--
