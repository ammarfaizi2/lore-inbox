Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261969AbTFBGvZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jun 2003 02:51:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261970AbTFBGvY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jun 2003 02:51:24 -0400
Received: from web10708.mail.yahoo.com ([216.136.130.216]:52923 "HELO
	web10708.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261969AbTFBGvW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jun 2003 02:51:22 -0400
Message-ID: <20030602070446.39795.qmail@web10708.mail.yahoo.com>
Date: Mon, 2 Jun 2003 00:04:46 -0700 (PDT)
From: BalaKrishna Mallipeddi <bkmallipeddi@yahoo.com>
Subject: Problem : While adding a new system call to Montavista Linux on PPC architecture
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
    While adding a new System call in Montavista linux
on ppc architecture  i am getting error:
      
I implemented the system call and compiled the kernel.
The kernel is compiled succesfully. While testing the
system call by writing a user program i am getting
error as ollows:

test_syscall.c: In function `rfs_open':
test_syscall.c:4: `__NR_rfs_open' undeclared (first
use in this function)
test_syscall.c:4: (Each undeclared identifier is
reported only once
test_syscall.c:4: for each function it appears in.)


How I implemented the system call is as follows:
All the paths i have given is from the montavista
Linux source tree.
1) Call Implementation:
    I coded my system call in the directory "kernel"  
 of the Linux source tree with the name "rfs_open.c". 
 
The system call is as follows:

    #include <linux/rfs_open.h>
                                                      
                            asmlinkage int
sys_rfs_open(void)
    {
        printk("I am rfs_open\n");
        return 0;
    }

2) Added a library function:
    I added my library function in the directory
"include/linux" with the name "rfs_open.h". The
function is as follows:
    
    #ifndef _LINUX_RFS_OPEN_H
    #define _LINUX_RFS_OPEN_H
                                                      
                         
    #include <linux/linkage.h>
    #include <linux/unistd.h>
                                                      
                         
        _syscall0(int,rfs_open);
                                                      
                         
    #endif

3) Got the system call number:
   I assigned a number to my system call in the file
unistd.h in the directory "include/asm", where "asm"
links to "asm-ppc". The line added in unistd.h is as
follows:
     #define __NR_rfs_open           208

4) Created entry in the System call table:
   I created an entry in the System Call table which
is in the file misc.S( for i386 architecture this
System call table is in entry.S) in the directory
"arch/ppc/kernel/misc.S" The line added in misc.S is
as follows:
    .long sys_rfs_open

5)  Updated the Makefile for my system call to be
compiled and linked in to the kernel. After updating 
it is as follows:
  export-objs = signal.o sys.o kmod.o context.o
ksyms.o pm.o exec_domain.o \
  printk.o cpufreq.o trace.o rfs_open.o 
                                                      
                         
  obj-y     = sched.o fork.o exec_domain.o panic.o
printk.o \
  module.o exit.o itimer.o info.o time.o softirq.o
resource.o \
  sysctl.o acct.o capability.o ptrace.o timer.o user.o
\
  signal.o sys.o kmod.o context.o rfs_open.o          
  
6) I compiled the kernel  and it is successfully
compiled.

7) My system call testing program looks as follows:

   #include <sys/syscall.h>
   #include <stdio.h>
   #include <errno.h>
   _syscall0(int,rfs_open);

   int main()
   {
        rfs_open();
        return(0);
   }

   I am greatful if any one help me.

Thanks & regards
BalaKrishna Mallipeddi.

=====
BalaKrishna Mallipeddi
Member Technical Staff Software
Innomedia Technologies Pvt. Ltd.,
#3278, 12th Main, HAL 2nd stage,
Bangalore-560008,
INDIA
Phone : 5278389 + 123

__________________________________
Do you Yahoo!?
Yahoo! Calendar - Free online calendar with sync to Outlook(TM).
http://calendar.yahoo.com
