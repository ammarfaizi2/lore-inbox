Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262227AbTFONbv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jun 2003 09:31:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262254AbTFONbv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jun 2003 09:31:51 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:9 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262227AbTFONbt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jun 2003 09:31:49 -0400
Date: Sun, 15 Jun 2003 14:45:38 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: =?iso-8859-1?Q?Pawe=B3_Go=B3aszewski?= <blues@ds.pg.gda.pl>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.71
Message-ID: <20030615144538.B32102@flint.arm.linux.org.uk>
Mail-Followup-To: =?iso-8859-1?Q?Pawe=B3_Go=B3aszewski?= <blues@ds.pg.gda.pl>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0306141411320.2156-100000@home.transmeta.com> <Pine.LNX.4.51L.0306151526190.11459@piorun.ds.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.51L.0306151526190.11459@piorun.ds.pg.gda.pl>; from blues@ds.pg.gda.pl on Sun, Jun 15, 2003 at 03:29:11PM +0200
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 15, 2003 at 03:29:11PM +0200, Pawe³ Go³aszewski wrote:
> On Sat, 14 Jun 2003, Linus Torvalds wrote:
> > I think I'll call this kernel the "sticky turtle", in honor of that
> > historic "greased weasel" kernel, and as a comment on how sadly
> > dependent I've become on the daily BK snapshots. It's been too long
> > since 2.5.70.
> 
> well done - this kernel looks really good. Even building is cleaner...
> 
> But - I get now after make modules_install:
> if [ -r System.map ]; then /sbin/depmod -ae -F System.map  2.5.71; fi
> WARNING: /lib/modules/2.5.71/kernel/drivers/char/agp/nvidia-agp.ko needs unknown symbol agp_memory_reserved
> WARNING: /lib/modules/2.5.71/kernel/drivers/net/3c509.ko needs unknown symbol netdev_boot_setup_check

I'm afraid to say it, but I'm considering christening this kernel as
"the most whinging 2.5 kernel thus far". 8/

I'm currently tracking down the cause of all these whinges, eg:

VFS: Mounted root (ext2 filesystem).
Freeing init memory: 88K
bad: scheduling while atomic! (00000001 0 1 swapper)
[<c02372d0>] (schedule+0x0/0x490) from [<c0258cc4>] (do_generic_mapping_read+0x48c/0x49c)
[<c0258838>] (do_generic_mapping_read+0x0/0x49c) from [<c0258fb0>] (__generic_file_aio_read+0x1ac/0x1e4)
[<c0258e04>] (__generic_file_aio_read+0x0/0x1e4) from [<c02590e4>] (generic_file_read+0x68/0x90)
[<c025907c>] (generic_file_read+0x0/0x90) from [<c0277b90>] (vfs_read+0xd8/0x124)
[<c0277ab8>] (vfs_read+0x0/0x124) from [<c0284100>] (kernel_read+0x54/0x80)
[<c02840ac>] (kernel_read+0x0/0x80) from [<c0285388>] (do_execve+0x104/0x1dc)
[<c0285284>] (do_execve+0x0/0x1dc) from [<c02273a0>] (sys_execve+0x44/0x60)
[<c022735c>] (sys_execve+0x0/0x60) from [<c0222300>] (ret_fast_syscall+0x0/0x30)

(UP preempt)

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

