Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261391AbVAXQIk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261391AbVAXQIk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 11:08:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261437AbVAXQIk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 11:08:40 -0500
Received: from mail.fh-wedel.de ([213.39.232.198]:40833 "EHLO
	moskovskaya.fh-wedel.de") by vger.kernel.org with ESMTP
	id S261391AbVAXQIh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 11:08:37 -0500
Date: Mon, 24 Jan 2005 17:08:11 +0100
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Florian Lohoff <flo@rfc822.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel BUG at fs/sysfs/symlink.c:87
Message-ID: <20050124160811.GA19232@wohnheim.fh-wedel.de>
References: <20050124155100.GA2583@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20050124155100.GA2583@paradigm.rfc822.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 January 2005 16:51:00 +0100, Florian Lohoff wrote:
> 
> while using the bridging code between a tap0 and a real eth1 i got this:
> 
> Linux zmgr1.wstk.mediaways.net 2.6.10-zmgr-p3cel #1 Mon Jan 24 16:15:39 CET 2005 i686 GNU/Linux
                                        ^^^^^^^^^^
Would be interesting to see if this shows up with a plain 2.6.10 as
well.  Do you have time to check that?

Looks like br_sysfs_addif() forgot to add a dentry to the kobj passed
to sysfs_create_link(), but I'm not too familiar with that code.

> UP, P3 Celeron, Non-Preempt, Vanilla Kernel
> 
> kernel BUG at fs/sysfs/symlink.c:87!
> invalid operand: 0000 [#1]
> Modules linked in: ppp_deflate bsd_comp ppp_async crc_ccitt ppp_generic slhc 3c59x bridge tun autofs eepro100 e100 mii i2c_i801 i2c_core uhci_hcd usbcore
> CPU:    0
> EIP:    0060:[<c017cac6>]    Not tainted VLI
> EFLAGS: 00010246   (2.6.10-zmgr-p3cel)
> EIP is at sysfs_create_link+0x56/0x60
> eax: c45ef738   ebx: 00000000   ecx: c709f000   edx: c39b3ec0
> esi: c8880878   edi: c7915728   ebp: c79156a0   esp: c4d91e94
> ds: 007b   es: 007b   ss: 0068
> Process brctl (pid: 3500, threadinfo=c4d90000 task=c52b25e0)
> Stack: c017b8cf c68ba7e4 c8880824 00000000 c887aa57 c45ef738 c7915728 c709f000
>        c45ef220 c709f000 c79156a0 c45ef220 00000000 c887762d c79156a0 c79156a0
>        c709f090 00000001 c709f000 c45ef220 ffffffed c4d91f34 c8877c34 c45ef220
> Call Trace:
>  [<c017b8cf>] sysfs_create_file+0x2f/0x50
>  [<c887aa57>] br_sysfs_addif+0xe7/0x140 [bridge]
>  [<c887762d>] br_add_if+0xbd/0x160 [bridge]
>  [<c8877c34>] add_del_if+0x64/0x80 [bridge]
>  [<c022d564>] dev_ifsioc+0x384/0x3f0
>  [<c022d7b7>] dev_ioctl+0x1e7/0x260
>  [<c0269d2c>] inet_ioctl+0x9c/0xb0
>  [<c02231c9>] sock_ioctl+0xc9/0x240
>  [<c015bc79>] sys_ioctl+0xc9/0x240
>  [<c01024a3>] syscall_call+0x7/0xb
> Code: 4c 24 04 8b 44 24 18 89 1c 24 89 44 24 08 e8 f2 fe ff ff 89 c1 8b 53 08 ff 42 68 0f 8e 0b 02 00 00 8b 5c 24 0c 89 c8 83 c4 10 c3 <0f> 0b 57 00 f5 59 2c c0 eb be 8b 44 24 04 8b 40 30 89 44 24 04
>  <7>tap0: no IPv6 routers present



Jörn

-- 
Good warriors cause others to come to them and do not go to others.
-- Sun Tzu
