Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316322AbSFJVXv>; Mon, 10 Jun 2002 17:23:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316339AbSFJVXu>; Mon, 10 Jun 2002 17:23:50 -0400
Received: from ip68-9-71-221.ri.ri.cox.net ([68.9.71.221]:25691 "EHLO
	mail.blue-labs.org") by vger.kernel.org with ESMTP
	id <S316309AbSFJVXs>; Mon, 10 Jun 2002 17:23:48 -0400
Message-ID: <3D0518BF.4090404@blue-labs.org>
Date: Mon, 10 Jun 2002 17:23:11 -0400
From: David Ford <david+cert@blue-labs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0+) Gecko/20020501
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.4.19-pre10-ac2, compile warnings/failures
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Bmilter: Processing completed, Bmilter version 0.1.0 build 565; timestamp 2002-06-10 17:23:12, message serial number 4850
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

cpqphp.h: In function `cpq_get_latch_status':
cpqphp.h:698: warning: concatenation of string literals with 
__FUNCTION__ is deprecated
cpqphp.h: In function `wait_for_ctrl_irq':
cpqphp.h:736: warning: concatenation of string literals with 
__FUNCTION__ is deprecated
cpqphp.h:746: warning: concatenation of string literals with 
__FUNCTION__ is deprecated

cpqphp_nvram.c:163: warning: concatenation of string literals with 
__FUNCTION__ is deprecated

cpqphp_nvram.c:179:17: missing terminating " character
cpqphp_nvram.c: In function `access_EV':
cpqphp_nvram.c:180: parse error before "xorl"
cpqphp_nvram.c:184:28: missing terminating " character

People, please don't do things like:

   spin_lock_irqsave(&int15_lock, flags);
   __asm__ (
      "xorl   %%ebx,%%ebx
      xorl    %%edx,%%edx
      pushf
      push    %%cs
      cli
      call    *%6"

Patches keep going in to fix this.

Please do something like:

   spin_lock_irqsave(&int15_lock, flags);
   __asm__ (
      "xorl   %%ebx,%%ebx  \n"
      "xorl    %%edx,%%edx \n"
      "pushf               \n"
      "push    %%cs        \n"
      "cli                 \n"
      "call    *%6         \n"


i2o_core.c:3393:75: missing terminating " character
         printk(KERN_WARNING "i2o: Could not quiesce %s."  "
            Verify setup on next system power up.\n", c->name); 

Please write it like:

         printk(KERN_WARNING "i2o: Could not quiesce %s."  
            "Verify setup on next system power up.\n", c->name);

-d


