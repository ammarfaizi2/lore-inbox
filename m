Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269628AbUJLLJf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269628AbUJLLJf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 07:09:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269629AbUJLLJf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 07:09:35 -0400
Received: from mx1.redhat.com ([66.187.233.31]:7562 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S269628AbUJLLJa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 07:09:30 -0400
Message-ID: <416BBB55.6020509@redhat.com>
Date: Tue, 12 Oct 2004 07:09:09 -0400
From: Neil Horman <nhorman@redhat.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0; hi, Mom) Gecko/20020604 Netscape/7.01
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: suthambhara nagaraj <suthambhara@gmail.com>
CC: main kernel <linux-kernel@vger.kernel.org>
Subject: Re: kernel stack
References: <46561a79041011231549ea310a@mail.gmail.com>
In-Reply-To: <46561a79041011231549ea310a@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

suthambhara nagaraj wrote:
> Hi all,
> 
> I have not understood how the common kernel stack in the
> init_thread_union(2.6 ,init_task_union in case of 2.4) works for all
> the processes which run on the same processor. The scheduling is round
> robin and yet the things on the stack (saved during SAVE_ALL) have to
> be maintained after a switch without them getting erased. I am
> familiar with only the i386 arch implementation.
> 
> Please help
> 
There is no such thing as "the common kernel stack".  Each process 
(represented by a task_struct in the kernel) has its own private data 
space to be used as a kernel stack when that process traps into the 
kernel.  You can see where this per task_struct stack space is reserved 
in the definition of task_union.  init_[task|thread]_union just defines 
the first task union in the system.  Because of the way unions are laid 
out in memory, The kernel knows that when a process traps into kernel 
space, it just needs to round the current task pointer to the nearest 8k 
(prehaps 4k in 2.6) boundary, and thats the start of that processes 
kernel stack.  Thats how the SAVE_ALL command avoids trampling registers.

HTH
Neil
> regards,
> Suthambhara
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


-- 
/***************************************************
  *Neil Horman
  *Software Engineer
  *Red Hat, Inc.
  *nhorman@redhat.com
  *gpg keyid: 1024D / 0x92A74FA1
  *http://pgp.mit.edu
  ***************************************************/
