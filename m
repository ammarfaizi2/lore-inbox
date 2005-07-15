Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263274AbVGOL6y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263274AbVGOL6y (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Jul 2005 07:58:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261888AbVGOL6x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Jul 2005 07:58:53 -0400
Received: from [202.125.86.130] ([202.125.86.130]:5347 "EHLO
	ns2.astrainfonets.net") by vger.kernel.org with ESMTP
	id S263280AbVGOL6C convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Jul 2005 07:58:02 -0400
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: FC3 module sys_print how...
X-MimeOLE: Produced By Microsoft Exchange V6.5.6944.0
Date: Fri, 15 Jul 2005 17:09:23 +0530
Message-ID: <4EE0CBA31942E547B99B3D4BFAB34811610F7E@mail.esn.co.in>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: FC3 module sys_print how...
Thread-Index: AcWJNE4MDjTFYP4ARAO7LQdsIq6r3g==
From: "Mukund JB." <mukundjb@esntechnologies.co.in>
To: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Dear Linux-lovers.

 

I am trying to build a 2.6.10 linux kernel module to print messages to a
file. I have done this 2.4 and I was successful but I am failing here.

 

I am using the sys_open, sys_write calls to do so.

I am getting a compilation warning and I find no .ko file created
finally instead I find an .o.ko file.

 

*** WARNIG: "sys_write" [/home/cf.o.ko] undefined!

Below is the module code. Please suggest me what could be the problem:-

 

 

#include <linux/kernel.h>

#include <linux/module.h>

#include <linux/moduleparam.h>

#include <asm/fcntl.h>        /* for O_WRONLY */

#include <linux/syscalls.h>   /* for sys_ functions */

#include <asm/uaccess.h>      /* for set_fs(), get_fs() etc. */

#include <linux/string.h>     /* for string length */

#include <linux/slab.h>       /* for kmalloc */

 

MODULE_LICENSE("GPL");

/*

#define DBG

#define PRINTK(fmt,arg...) printk("DBG INFO <%s> | "
fmt,__FUNCTION__,##arg)

#else

#define PRINTK(fmt,arg...) while(0)

#endif

*/

 

typedef struct tagWRITE_TEST

{

      unsigned long fd;

      unsigned long x;

      

}WRITE_TEST, *PWRITE_TEST;

 

PWRITE_TEST ptest;

 

void SysPrint(char * pString, ...)

{

      static char buff[1024];

      va_list ap;

 

      va_start(ap,pString);

      vsprintf((char *)buff, pString, ap);

      va_end(ap);

      

      sys_write(ptest->fd,(char *)buff,(size_t)strlen(buff));

}

 

int init_module(void)

{

      

      printk("<%s> invoked!\n",__FUNCTION__);

      printk("File Creation Testing in Kernel Module!\n");

 

      set_fs(get_ds());

      

      /* allocate the memory for structre */

      ptest = (PWRITE_TEST)kmalloc(sizeof(WRITE_TEST),GFP_KERNEL);

      if(ptest == NULL)

      {

            printk("Structure Memory Allocation Fails!\n");

            return -ENOMEM;

      }

      

      ptest->fd = sys_open("srcdebug.txt", O_CREAT | O_WRONLY, 644);

      if (ptest->fd == 0)

      {

            SysPrint("File Creation Error!!!\n");

            return 1;

      }

      

      SysPrint("File Creation Testing in Kernel Module!\n");

      SysPrint("Srinivas Testing the File Creation\n");

      sys_close(ptest->fd);

      

      return 0;

}

 

void cleanup_module(void)

{

      printk("Good bye!\n");

 

      /* free the allocated memory */

      kfree(ptest);

}

 

Regards,

Mukund jampala

 


