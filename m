Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261231AbTILVzW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Sep 2003 17:55:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261766AbTILVzW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Sep 2003 17:55:22 -0400
Received: from [65.248.4.67] ([65.248.4.67]:57761 "EHLO verdesmares.com")
	by vger.kernel.org with ESMTP id S261231AbTILVzP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Sep 2003 17:55:15 -0400
Message-ID: <002b01c37956$d88d67c0$f8e4a7c8@bsb.virtua.com.br>
From: "Breno" <brenosp@brasilsec.com.br>
To: "Kernel List" <linux-kernel@vger.kernel.org>
Subject: stack overflow
Date: Fri, 12 Sep 2003 18:53:58 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-XTmail: http://www.verdesmares.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi ... this is my idea to check a stack overflow. What do you think ?


#define STACK_LIMIT (1024*8192)/PAGE_SIZE

int check_stack_overflow(struct task_struct *tsk)
{

    unsigned long stack_size,stack_addr,stack_ptr;
    int i;

         if(tsk->mm != NULL)
         {
                  stack_addr = tsk->mm->start_stack;

                  stack_ptr = tsk->thread.esp;

                  for(i=0; i < stack_ptr; i++)
                  stack_addr++;

                  stack_size = (stack_addr - stack_ptr)/PAGE_SIZE;

                  if(stack_size > ( STACK_LIMIT - 1))
                  {
                               printk(KERN_CRIT"Process %s : pid %d -
                                Can cause stack
overflow\n",tsk->comm,tsk->pid);
                               return 0;
                  }
         }
return 0;
}

att,
Breno


