Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750766AbWBIXHf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750766AbWBIXHf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Feb 2006 18:07:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750783AbWBIXHf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Feb 2006 18:07:35 -0500
Received: from smtpout.mac.com ([17.250.248.46]:62681 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S1750766AbWBIXHf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Feb 2006 18:07:35 -0500
In-Reply-To: <20060209192510.32377.qmail@web50307.mail.yahoo.com>
References: <20060209192510.32377.qmail@web50307.mail.yahoo.com>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <383FCBAC-AB8E-4DFA-8716-D7BBF6409FDA@mac.com>
Cc: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: How to call a function in a module from the kernel code !!! (Linux kernel)
Date: Thu, 9 Feb 2006 18:07:32 -0500
To: omkar lagu <omkarlagu@yahoo.com>
X-Mailer: Apple Mail (2.746.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Feb 09, 2006, at 14:25, omkar lagu wrote:
> hello sir,
>
> we wanted to call a function in our module ll from shm.c file  
> (which is in the kernel)
>
> so we declared function pointer in shm.c
> unsigned long long (*ptr1)(int)
>
> we declared it as extern in shm.h
> extern unsigned long long (*ptr1)(int)
>
> then we declared also in our module  (ll)
> extern unsigned long long (*ptr1)(int)
>
> we initialized it to ptr1 = commun; in init module of ll.c where  
> commun is we wanted to call from the kernel
>
> but it gave an error as undefined refernce to ptr1 when we inserted  
> our module..
>
> can you help on this thing or can you give us a example regarding  
> how it is done ??

It would help a lot if you could post a link to your source code.   
Let me point out (in case you don't know this already) that if you do  
what you describe and distribute the result, you are automatically  
licensing your ll.c file under the GPLv2.  By distributing a  
derivative of both the Linux kernel and your proprietary module (You  
are taking Linux kernel sources and modifying them explicitly for  
your module), the result must be GPL.  Also, I think what you are  
describing is basically impossible.  I believe what you want to do is  
this:

/* in shm.c */
unsigned long long (*ptr1)(int);
EXPORT_SYMBOL(ptr1);

However this makes it impossible to reliably remove your module,  
because a process could race entering the function as the module  
loader is trying to remove the module.

Cheers,
Kyle Moffett

--
There are two ways of constructing a software design. One way is to  
make it so simple that there are obviously no deficiencies. And the  
other way is to make it so complicated that there are no obvious  
deficiencies.  The first method is far more difficult.
   -- C.A.R. Hoare


