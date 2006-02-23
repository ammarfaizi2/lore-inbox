Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751406AbWBWTEe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751406AbWBWTEe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 14:04:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751434AbWBWTEe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 14:04:34 -0500
Received: from smtp.osdl.org ([65.172.181.4]:63616 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751406AbWBWTEd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 14:04:33 -0500
Date: Thu, 23 Feb 2006 11:03:50 -0800
From: Andrew Morton <akpm@osdl.org>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: sekharan@us.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Register atomic_notifiers in atomic context
Message-Id: <20060223110350.49c8b869.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.44L0.0602231145300.5204-100000@iolanthe.rowland.org>
References: <20060222182601.1d628a01.akpm@osdl.org>
	<Pine.LNX.4.44L0.0602231145300.5204-100000@iolanthe.rowland.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Stern <stern@rowland.harvard.edu> wrote:
>
>  The calls to register_cpu_notifier are harder.  That chain really does 
>  need to be blocking

Why?

> which means we can't avoid calling down_write.  The 
>  only solution I can think of is to use down_write_trylock in the 
>  blocking_notifier_chain_register and unregister routines, even though 
>  doing that is a crock.
> 
>  Or else change __down_read and __down_write to use spin_lock_irqsave 
>  instead of spin_lock_irq.  What do you think would be best?

Nothing's pretty.  Perhaps look at system_state and not do any locking at all
in early boot?

>  > I'd suggest that in further development, you enable might_sleep() in early
>  > boot - that would have caught such things..
> 
>  Not a bad idea.  I presume that removing the "system_state == 
>  SYSTEM_RUNNING" test in __might_sleep will have that effect?

Yup.
