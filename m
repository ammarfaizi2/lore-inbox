Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265657AbSLXQDJ>; Tue, 24 Dec 2002 11:03:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265681AbSLXQDJ>; Tue, 24 Dec 2002 11:03:09 -0500
Received: from NODE1.HOSTING-NETWORK.COM ([64.127.133.1]:19467 "HELO
	unix201.hosting-network.com") by vger.kernel.org with SMTP
	id <S265657AbSLXQDI>; Tue, 24 Dec 2002 11:03:08 -0500
X-Comments: BlackMail headers - Mail to abuse@featureprice.com to report spam.
X-Authenticated-Connect: 63.198.195.76
X-Authenticated-Timestamp: 11:11:32(EST) on December 24, 2002
X-HELO-From: actiswitch.com
X-Mail-From: <list@actiswitch.com>
X-Sender-IP-Address: 63.198.195.76
Message-ID: <3E088959.60000@actiswitch.com>
Date: Tue, 24 Dec 2002 08:20:41 -0800
From: Dhirendra Pal Singh <list@actiswitch.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020830
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Problem in EXPORT_SYMBOL.. Please Help!
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All
I am trying to resolve the problem of EXPORT_SYMBOL. I have raised this 
question on newbies kernel list but no one replied. Hence I am posting 
it here.
I am using kernel 2.4.18-14. Below is the listing of a simple test code.

**************************************
/*main.c*/

#include <linux/kernel.h>
#include <linux/module.h>

#if CONFIG_MODVERSION == 1
#define MODERVSION
#include <linux/modversions.h>
#endif

int print_func()
{
	printk("Entry point.\n");
	return 0;
}

EXPORT_SYMBOL(print_func);

int init_module()
{
	print_func();
	return 0;
}

void cleanup()
{
	printk("End of story.\n");
}

********************************************

********************************************
/*Makefile*/

export-objs	:= main.o
CC=gcc
MAKE = make
KERNELDIR = /usr/src/linux-2.4.18-14
MODCFLAGS := --save-temps -Wall -D__KERNEL__ -DMODULE -DLINUX -DMODVERSIONS

main.o:		main.c 
		$(CC) $(MODCFLAGS) -I$(KERNELDIR)/include -c main.c

clean:
	rm -fr *.o *.i *.s

***********************************************

And on compiling the error is as follows...

gcc --save-temps -Wall -D__KERNEL__ -DMODULE -DLINUX -DMODVERSIONS -I/usr/src/linux-2.4.18-14/include -c main.c
main.c:15: parse error before "this_object_must_be_defined_as_export_objs_in_the_Makefile"
main.c:15: warning: type defaults to `int' in declaration of `this_object_must_be_defined_as_export_objs_in_the_Makefile'
main.c:15: warning: data definition has no type or storage class

The error says export_ojbs must be defined. As you can see I have already defined them in the Makefile. 

Pleaes help. I am kind of stucked in my project.

Thanks in advance..
Dp

make: *** [main.o] Error 1




