Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129618AbQKITBf>; Thu, 9 Nov 2000 14:01:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129858AbQKITBZ>; Thu, 9 Nov 2000 14:01:25 -0500
Received: from chaos.analogic.com ([204.178.40.224]:3201 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S129618AbQKITBK>; Thu, 9 Nov 2000 14:01:10 -0500
Date: Thu, 9 Nov 2000 14:00:49 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Module open() problems, Linux 2.4.0
Message-ID: <Pine.LNX.3.95.1001109135504.14703A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


`lsmod` shows that a device is open twice when using Linux-2.4.0-test9
when, in fact, it has been opened only once.

lsmod is version 2.3.15, the latest-and-greatest.

Here are the open/close routines for a module.

/*-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*/
/*
 *  Open the device.
 */
static int device_open(struct inode *inp, struct file *fp)
{
    DEB(printk("%s open\n", info->dev));
    MOD_INC_USE_COUNT;                         /* Increment usage count */
    return 0;
} 
/*-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*/
/*
 *  Close the device.
 */
static int device_close(struct inode *inp, struct file *fp)
{
    DEB(printk("%s close\n", info->dev));
    MOD_DEC_USE_COUNT;                         /* Decrement usage count */
    return 0;
} 

When the module is closed, the use-count goes to zero as expected.
However, a single open() causes the use-count to be 2.

In a possibly-related observation, during the change-root from
an initial RAM disk to the root file system during boot, the
d_count used to be reported as '1'. It is now '3'.


Cheers,
Dick Johnson

Penguin : Linux version 2.4.0 on an i686 machine (799.54 BogoMips).

"Memory is like gasoline. You use it up when you are running. Of
course you get it all back when you reboot..."; Actual explanation
obtained from the Micro$oft help desk.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
