Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265429AbRGBUhp>; Mon, 2 Jul 2001 16:37:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265432AbRGBUhf>; Mon, 2 Jul 2001 16:37:35 -0400
Received: from chaos.analogic.com ([204.178.40.224]:18304 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S265429AbRGBUhU>; Mon, 2 Jul 2001 16:37:20 -0400
Date: Mon, 2 Jul 2001 16:37:16 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: semaphore/down()/up() question
Message-ID: <Pine.LNX.3.95.1010702163506.8534A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



I need to stop a kernel thread at a certain place in the
driver code. The task that stopped it needs to know that it's
stopped, i.e., needs to wait until it's sleeping.

Later on, I need to start it. So, I thought that a
semaphore would work. It works the first time, but
not after that. In other words, the first down_interruptible()
does, indeed put it in "down_interruptible". I can wake it
up with 'up()'. After that, the kernel thread just ignores
(immediately returns from) down_interruptible().

Trying to find out what was going on, I decided to cheat and
initialize the semaphore immediately before down_interruptible().
Again, it works the first time. However, the second time through
the code then gets stuck in down_interruptible() and a call to
up() gets stuck forever.

Also, it seems that up() and down() are logically reversed,
up() seems to wait until down() is executed. I would expect
that up() would just return if the semaphore was not active,
i.e., locked.

Does anybody know what's going on? Maybe this isn't how to
use these kernel services??

static struct semaphore stopper;

kernel_thread()
{
    for(;;)
    {
       down_interruptible(&stopper);
       do_stuff();
    }
}

ioctl()
{
    up(&stopper); 
}

int __init init_module()
{
    init_MUTEX_LOCKED(&stopper);
}


Cheers,
Dick Johnson

Penguin : Linux version 2.4.5 on an i686 machine (799.53 BogoMips).

    I was going to compile a list of innovations that could be
    attributed to Microsoft. Once I realized that Ctrl-Alt-Del
    was handled in the BIOS, I found that there aren't any.


