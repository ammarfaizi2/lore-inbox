Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261453AbUKIJXR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261453AbUKIJXR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 04:23:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261455AbUKIJXR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 04:23:17 -0500
Received: from fw.osdl.org ([65.172.181.6]:5076 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261453AbUKIJXN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 04:23:13 -0500
Date: Tue, 9 Nov 2004 01:22:12 -0800
From: Andrew Morton <akpm@osdl.org>
To: David Woodhouse <dwmw2@infradead.org>
Cc: rmk@arm.linux.org.uk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Correctly flush 8250 buffers, notify ldisc of line
 status changes.
Message-Id: <20041109012212.463009c7.akpm@osdl.org>
In-Reply-To: <1099659997.20469.71.camel@localhost.localdomain>
References: <1099659997.20469.71.camel@localhost.localdomain>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Woodhouse <dwmw2@infradead.org> wrote:
>
> We weren't flushing the TX FIFO on 8250 uarts when uart_flush_buffer()
>  was called. This adds a flush_buffer() method to the uart_port
>  operations and calls it from uart_flush_buffer().

Your patch makes my computer stop working, which saddens me.


NMI Watchdog detected LOCKUP on CPU1CPU 1 
Modules linked in:                        
Pid: 1, comm: init Not tainted 2.6.10-rc1-mm4
RIP: 0010:[<ffffffff803b04c0>] <ffffffff803b04c0>{_spin_lock_irqsave+31}
RSP: 0018:ffff81007ff19d68  EFLAGS: 00000013                            
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000001 RSI: 0000000000000000 RDI: 0000000000000001
RBP: ffffffff80585da0 R08: ffff81000b663920 R09: 0000000000000000
R10: ffff81017ffa3980 R11: 0000000000000040 R12: 0000000000000246
R13: ffff81017f4de000 R14: ffff81000b65ad28 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffffffff80594c80(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b                           
CR2: 0000000000000000 CR3: 000000017f4e6000 CR4: 00000000000006e0
Process init (pid: 1, threadinfo ffff81007ff18000, task ffff81007ffaf740)
Stack: 0000000000000013 ffffffff80585da0 ffffffff80585da0 ffffffff8028fe34 
       0000000000000246 ffff81000b65ad08 0000000000000246 ffffffff8028d8d3 
       ffffffff80585da0 0000000000000246                                   
Call Trace:<ffffffff8028fe34>{serial8250_flush_buffer+15} <ffffffff8028d8d3>{uart_flush_buffer+75} 
       <ffffffff8028e9bc>{uart_close+332} <ffffffff80272fa9>{release_dev+578}                      
       <ffffffff8017b942>{chrdev_open+438} <ffffffff8015ae42>{poison_obj+56}  
       <ffffffff80174273>{filp_dtor+0} <ffffffff802737a2>{tty_release+17}    
       <ffffffff8017406d>{__fput+100} <ffffffff80171911>{filp_close+107}  
       <ffffffff8017199c>{sys_close+132} <ffffffff8010f346>{system_call+126} 


Maybe the lock which uart_flush_buffer() takes is the same as the lock
which serial8250_flush_buffer() takes?
