Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292337AbSBULTh>; Thu, 21 Feb 2002 06:19:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292338AbSBULT2>; Thu, 21 Feb 2002 06:19:28 -0500
Received: from acolyte.thorsen.se ([193.14.93.247]:25094 "HELO
	acolyte.hack.org") by vger.kernel.org with SMTP id <S292337AbSBULTN>;
	Thu, 21 Feb 2002 06:19:13 -0500
From: Christer Weinigel <wingel@nano-system.com>
To: jgarzik@mandrakesoft.com
Cc: zwane@linux.realnet.co.sz, roy@karlsbakk.net, alan@lxorguk.ukuu.org.uk,
        linux-kernel@vger.kernel.org
In-Reply-To: <3C74C8C7.25D7BCD@mandrakesoft.com> (message from Jeff Garzik on
	Thu, 21 Feb 2002 05:15:35 -0500)
Subject: Re: [DRIVER][RFC] SC1200 Watchdog driver
In-Reply-To: <Pine.LNX.4.44.0202211134080.7649-100000@netfinity.realnet.co.sz> <3C74C8C7.25D7BCD@mandrakesoft.com>
Message-Id: <20020221111910.57235F5B@acolyte.hack.org>
Date: Thu, 21 Feb 2002 12:19:10 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik <jgarzik@mandrakesoft.com> wrote:

> I just looked at their watchdog driver -- yours might be better...  They
> don't use semaphores in _open, they don't use request_region, etc.

I do use request region, it's all done in another source file though.

What use would the semaphore be?  To disallow multiple opens?

I'm not too sure about the locking requirements on release, do I need
to add lock_kernel to the release function, or is that automatically
handled by "owner: THIS_MODULE"?

static int scx200_watchdog_release(struct inode *inode, struct file *file)
{
	lock_kernel();
	if (!expect_close) {
                printk(KERN_WARNING "%s: watchdog device closed unexpectedly, will not disable the watchdog timer\n", name);
        } else if (!nowayout) {
                scx200_watchdog_disable();
        }
        clear_bit(0, &in_use);
	unlock_kernel();

        return 0;
}

Is there anything else that I ought to change in the driver?  (Except
to get rid of all the magic constants, I'm planning to do this, I
promise).

 /Christer
