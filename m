Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262575AbVAPUdg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262575AbVAPUdg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jan 2005 15:33:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262577AbVAPUdg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jan 2005 15:33:36 -0500
Received: from fw.osdl.org ([65.172.181.6]:52693 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262575AbVAPUcl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jan 2005 15:32:41 -0500
Date: Sun, 16 Jan 2005 12:32:12 -0800
From: Andrew Morton <akpm@osdl.org>
To: Robert Wisniewski <bob@watson.ibm.com>
Cc: karim@opersys.com, hch@infradead.org, tglx@linutronix.de,
       linux-kernel@vger.kernel.org, bob@watson.ibm.com
Subject: Re: 2.6.11-rc1-mm1
Message-Id: <20050116123212.1b22495b.akpm@osdl.org>
In-Reply-To: <16874.50688.68959.36156@kix.watson.ibm.com>
References: <20050114002352.5a038710.akpm@osdl.org>
	<1105740276.8604.83.camel@tglx.tec.linutronix.de>
	<41E85123.7080005@opersys.com>
	<20050116162127.GC26144@infradead.org>
	<41EAC560.30202@opersys.com>
	<16874.50688.68959.36156@kix.watson.ibm.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Wisniewski <bob@watson.ibm.com> wrote:
>
> modify_val_spin()
>  {
>  	acquire_spin_lock()
>  	// calculate some_value based on global_val
>  	// for example c=global_val; if (c%0) some_value=10; else some_value=20;
>  	global_val = global_val + some_value
>  	release_spin_lock()
>  }
> 
>  modify_val_atomic()
>  {
>  	do
>  	// calculate some_value based on global_val
>  	// for example c=global_val; if (c%0) some_value=10; else some_value=20;
>  	global_val = global_val + some_value
>  	while (compare_and_store(global_val, , ))
>  }
> 
>  What's the difference.  The deal is if two processes execute this code
>  simultaneously and one gets interrupted in the middle of modify_val_spin,
>  then the other wastes its entire quantum spinning for the lock.  In the
>  modify_val_atomic if one process gets interrupted, no problem, the other
>  process can proceed through, then when the first one runs again the CAS
>  will fail, and it will go around the loop again.

One could use spin_lock_irq().  The performance would be similar.

> Now imagine it was the kernel involved...

Or are you saying that userspace does the above as well?
