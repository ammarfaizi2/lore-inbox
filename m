Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314799AbSD2FUO>; Mon, 29 Apr 2002 01:20:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314800AbSD2FUN>; Mon, 29 Apr 2002 01:20:13 -0400
Received: from mx2.ews.uiuc.edu ([130.126.161.238]:17859 "EHLO
	mx2.ews.uiuc.edu") by vger.kernel.org with ESMTP id <S314799AbSD2FUM>;
	Mon, 29 Apr 2002 01:20:12 -0400
Message-ID: <001001c1ef3d$890a6d50$e6f7ae80@ad.uiuc.edu>
From: "Wanghong Yuan" <wyuan1@ews.uiuc.edu>
To: <linux-kernel@vger.kernel.org>
In-Reply-To: <20020427.194302.02285733.davem@redhat.com><467685860.avixxmail@nexxnet.epcnet.de> <20020428.204911.63038910.davem@redhat.com>
Subject: How to enable printk
Date: Mon, 29 Apr 2002 00:20:11 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4910.0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

It may be a simple question. But I cannot see the result of printk in
console like the following. Do i need to enable it somewhere? Thanks

/*-O2 -Wall -DMODULE -D__KERNEL__ -DLINUX -c testsys.c */

#include <linux/sys.h>
#include <linux/mm.h>
#include <linux/module.h>
#include <linux/kernel.h>
#include <linux/sched.h>
#include <sys/syscall.h>
#include <asm/uaccess.h>


/* The system call number we attempt to install ourselves as. */
static int syscall_num = 165;

asmlinkage int sys_test(int pid, int period, int cycles, int* ptr)

{

 put_user(current->pid, ptr);
 return pid-10000;

}

extern int sys_call_table[];

#ifdef MODULE
int init_module(void)
{
  printk("yes\n");
  sys_call_table[syscall_num] = (int)sys_test;
  return 0;
}

void cleanup_module(void)
{
  sys_call_table[syscall_num] = 0;
}

#endif /* MODULE */


