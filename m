Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267260AbTBXRKt>; Mon, 24 Feb 2003 12:10:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267264AbTBXRKt>; Mon, 24 Feb 2003 12:10:49 -0500
Received: from [67.99.70.131] ([67.99.70.131]:59657 "EHLO
	peter.integraltech.com") by vger.kernel.org with ESMTP
	id <S267260AbTBXRKs>; Mon, 24 Feb 2003 12:10:48 -0500
Message-ID: <006801c2dc29$1a80e560$8f00a8c0@integraltech.com>
From: "Rob Murphy" <rmurphy@integraltech.com>
To: <linux-kernel@vger.kernel.org>
Subject: 2.5.62 ioremap fails
Date: Mon, 24 Feb 2003 12:21:01 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1106
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have been trying to allocate memory past the end of the kernel in a system
that has more that 1 Gb of memory and have been unsuccessful.  My current
machine has an athlon processor and 1.5Gb of memory.

I created a driver with the following code:

#define MAXHM 0x8000000 // 128 Mb
int __init init_module(void)
{
    void *kHighMem;

    printk(KERN_ERR"before ioremap\n");
    kHighMem = ioremap(__pa(high_memory), MAXHM);
    printk(KERN_ERR"ioremap ret: %x\n",kHighMem);

    return 0;
}

void __exit leave_mod(void) {
    iounmap(kHighMem);
    printk(KERN_ERR"iounmap passed\n");

    printk(KERN_ERR,"module successfully unloaded.\n");
}

I add the line append="mem=xx" to lilo.
If I set "xx" to around 860 or above then ioremap fails.  If I set "xx" to
860 or less then ioremap is successful.  Has anyone had any experience
trying to allocate a contiguous memory buffer beyond the end of what the
kernel manages in a system with over 1Gb of memory?  Any help would be
appreciated in this matter.

Regards,
Rob Murphy


