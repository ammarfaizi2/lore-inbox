Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751169AbWFSJIV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751169AbWFSJIV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 05:08:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751254AbWFSJIV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 05:08:21 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:2745 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751169AbWFSJIV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 05:08:21 -0400
Subject: Re: About the fixes of /drivers/serial/8250.C in 2.6.17-rc6 for
	avoiding habbg-up
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: gouji <gouji.masayuki@jp.fujitsu.com>
Cc: "'LKML'" <linux-kernel@vger.kernel.org>
In-Reply-To: <000d01c6934c$f25c9870$f4647c0a@GOUJI>
References: <000d01c6934c$f25c9870$f4647c0a@GOUJI>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 19 Jun 2006 10:23:14 +0100
Message-Id: <1150708994.2503.3.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Llu, 2006-06-19 am 12:03 +0900, ysgrifennodd gouji:
> In /drivers/serial/8250.C of 2.6.17-rc6,
> 
> these fixes are adapted for avoinding  the problem of hang-up
> while TTY write and console write from kernel conflicted.

Yes, there is a bug in this version that was not in the one I submitted,
someone added an improvement.

> +   if (oops_in_progress) {
> +      locked = spin_trylock_irqsave(&up->port.lock, flags);
> +   } else
> +      spin_lock_irqsave(&up->port.lock, flags);
> +

It could always use spin_trylock_irqsave(). The oops in progress
optimisation makes some sense initially but there are many console
printk users that can occur during serial I/O in exceptional cases.

It's not an easy problem to solve with the current serial locking.

Alan

