Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261931AbUKUIuN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261931AbUKUIuN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Nov 2004 03:50:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261927AbUKUIuN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Nov 2004 03:50:13 -0500
Received: from web50506.mail.yahoo.com ([206.190.38.82]:34485 "HELO
	web50506.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261936AbUKUIsP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Nov 2004 03:48:15 -0500
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  b=IBMTpwrJg+oLb5yn6ukC0tUe2b884RXf2WAwUQE0T2tpQMS+/iX8GNKK5vuwcQlUj9dZSvFja55I4XyPQIeq0Qc5eE4cFczlGoIvcmiPe+dWqiSmizIVdM/p6nIPeRcyDFTuO4nSGuu9U6xcs3ETFoLwTVnosxz4cfMKvkavzUc=  ;
Message-ID: <20041121084814.28257.qmail@web50506.mail.yahoo.com>
Date: Sun, 21 Nov 2004 00:48:14 -0800 (PST)
From: lan mu <mu8lan2003@yahoo.com>
Subject: how to read the big buffer from kernel space to user applcation via mmap?
To: linux-kernel@vger.kernel.org
Cc: mu8lan2003@yahoo.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi driver experts,

I'm trying to use the mmap to let user application
read data from kernel buffer.

I have 700000 bytes data in the kernel buffer and user
application need to get it via mmap.

In driver code:
===============
I have alallocated 700000 bytes buffer and write
drive_mmap as the following:

char *kmalloc_area;

xxx_mmap(structile *file,
        struct vmarea_struct *vma
{
int i;
        vma->vm_flags |= VM_SHARED;
                                                      
                                              
        remap_page_range(vma->vm_start,
                virt_to_phys(kmalloc_area),
                700000,
                PAGE_SHARED);
        return 0;
}

and in the driver ininitunction:
=================================

kkmalloc_area=kmalloc(700000,GFP_KERNEL);
/* set first 100 bytes as 0x8 for testing */
    for (i=0; i<100; i++)
        kmalloc_area[i] = 0x8;

I have other routine to to mmap

static int xxx_mmap_buffers(void)
{
  ststructage *page;
  int i;
                                                      
                                             
        page = vivirto_page(kmalloc_area);
        memap_reserve(page);
        return 1;
}

in user application:
=====================
char *adaddr
 
addr = mmap(0, 700000, PROT_READ|PROT_WRITE,
MAP_SHARED, fd, 0);

   if (adaddr=  MAP_FAILED)
        printf"****oops! error-->%d\n", ererrno;
                                                      
                        
    printf"****adaddr>0x%x\n", adaddr);
                                                      
                        
     for (i=0; i<100; i++)
         printfuser addr[%d] --> 0x%x\n", i, addr[i]);

at the end of user app function
===============================
                                                      
                                             
xxx_mmap_buffers()

     
Now I have 2 two issues:
1. since I set first 100 bytes to 0x8 in the kernel
buffer, I should read back when I run user app, but
after mmap all '0x0' in the first 100 bytes, can
someone tell me why and what's wrong?

2. Since my buffer is big, what I should to do to get
the right buffer pointer in user app function to read
ALL data back from the kernel space? can anyone give
me a real example?

Many thanks for your help!

-Lan


		
__________________________________ 
Do you Yahoo!? 
The all-new My Yahoo! - Get yours free! 
http://my.yahoo.com 
 

