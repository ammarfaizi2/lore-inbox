Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262793AbVCWFUu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262793AbVCWFUu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 00:20:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262794AbVCWFUu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 00:20:50 -0500
Received: from lantana.tenet.res.in ([202.144.28.166]:61837 "EHLO
	lantana.cs.iitm.ernet.in") by vger.kernel.org with ESMTP
	id S262793AbVCWFUh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 00:20:37 -0500
Date: Wed, 23 Mar 2005 10:51:07 +0530 (IST)
From: Payasam Manohar <pmanohar@lantana.cs.iitm.ernet.in>
To: linux-kernel@vger.kernel.org
Subject: segmentation fault while loading modules
Message-ID: <Pine.LNX.4.60.0503231042480.21050@lantana.cs.iitm.ernet.in>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Mail-scanner Found to be clean
X-MailScanner-From: pmanohar@lantana.cs.iitm.ernet.in
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


hai,

   I have  a problem in loading a module ,it is giving segmentation fault,
when I do the /sbin/lsmod
  signal4 944 (initializing)

here signal4 is my module name.I am using 2.4.20-8 kernel.
And I am unable to remove this module also.

following is the code of my module

#include <bits/signum.h> /* signal number macros SIGHUP etc. */
#include <linux/kernel.h> /* printk level */
#include <linux/module.h> /* kernel version etc. */
#include <linux/sched.h> /* task_struct */

MODULE_LICENSE("GPL v2");
MODULE_DESCRIPTION("Signal to a user-space app from a kernel module");

int pid=0;
MODULE_PARM(pid,"i");

int
ksignal(int pid,int signum)
{
struct task_struct x;
struct task_struct *p;
/* run through the task list of linux until we find our pid */
//for (p = &init_task ; (p = next_task(p)) != &init_task ; ){
for (p = &x ; (p = next_task(p)) != &x ; ){
if(p->pid == pid){
printk("sending signal %d for pid %d\n",signum,(int)p->pid);
/* don't have a sig_info struct to send along - pass 0 */
return send_sig(signum,p,0);
}
}
/* did not find the requested pid */
return -1;
}

int
init_module(void)
{
/* send pid a SIGKILL */
ksignal(2345,SIGKILL);
return 0;
}

void
cleanup_module(void)
{
printk("out of here\n");
}
-----------------------
my makefile is:

TARGET  := signal4
WARN    := -W -Wall -Wstrict-prototypes -Wmissing-prototypes
INCLUDE := -isystem /lib/modules/2.4.20-8feb9.1/build/include
CFLAGS  := -O2 -DMODULE -D__KERNEL__ ${WARN} ${INCLUDE}
CC      := gcc

${TARGET}.o: ${TARGET}.c

.PHONY: clean


Any suggestions are welcome.





Thanks&Regards,
   P.Manohar.

