Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262366AbTFUFjy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jun 2003 01:39:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262577AbTFUFjy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jun 2003 01:39:54 -0400
Received: from x35.xmailserver.org ([208.129.208.51]:43393 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S262366AbTFUFjx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jun 2003 01:39:53 -0400
X-AuthUser: davidel@xmailserver.org
Date: Fri, 20 Jun 2003 22:51:30 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mcafeelabs.com
To: BalaKrishna Mallipeddi <bkmallipeddi@yahoo.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Bad address problem while reading from hard disk(using sys_read).
In-Reply-To: <20030621054000.66503.qmail@web10704.mail.yahoo.com>
Message-ID: <Pine.LNX.4.55.0306202248190.3449@bigblue.dev.mcafeelabs.com>
References: <20030621054000.66503.qmail@web10704.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Jun 2003, BalaKrishna Mallipeddi wrote:

> Hi,
>     I developed a kernel module. Within that i am
> dynamically allocating memory(using kmalloc and
> vmalloc) for a buffer to read data. After that while
> trying to read into this buffer from the hard disk
> using sys_read i am getting an error. And the same
> error i am getting while writing into another buffer,
> which was allocated in the same way, using sys_write.
> The error number set is -14(EFAULT) i.e., Bad address.
>
>
>    Give me any idea to resolve the problem.
>
>   If anyone help me i am gretful to them.

All sys_* functions expect user space addresses and you passing a kernel
space one. You need something like :

        mm_segment_t oldfs;

	oldfs = get_fs();
        set_fs(KERNEL_DS);
        nread = sys_read(fd, buf, cnt);
        set_fs(oldfs);

(If you really want to do that)



- Davide

