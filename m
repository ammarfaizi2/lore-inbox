Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261723AbUEBLWS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261723AbUEBLWS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 May 2004 07:22:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262961AbUEBLWS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 May 2004 07:22:18 -0400
Received: from av7-2-sn4.m-sp.skanova.net ([81.228.10.109]:59088 "EHLO
	av7-2-sn4.m-sp.skanova.net") by vger.kernel.org with ESMTP
	id S261723AbUEBLWQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 May 2004 07:22:16 -0400
To: mikeb1@t-online.de (Michael Berger)
Cc: linux-kernel@vger.kernel.org
Subject: Re: Error in installing kernel 2.6.5 compiled with GCC 3.4.0 and -mregparm=3
References: <408BBCB2.9010804@t-online.de>
From: Peter Osterlund <petero2@telia.com>
Date: 02 May 2004 13:22:14 +0200
In-Reply-To: <408BBCB2.9010804@t-online.de>
Message-ID: <m2d65n2hw9.fsf@p4.localdomain>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mikeb1@t-online.de (Michael Berger) writes:

> I get following error in installing kernel 2.6.5 compiled with GCC
> 3.4.0 and -mregparm=3.
> 
> [root@Loki linux-2.6]# make modules_install
...
>   INSTALL drivers/block/loop.ko
...
> [root@Loki linux-2.6]# make install
...
> sh /home/chewie/work/kernel/linux-2.6/arch/i386/boot/install.sh 2.6.5
> arch/i386/boot/bzImage System.map ""
> All of your loopback devices are in use.
> mkinitrd failed

I recently got the same error when I installed a reconfigured version
of the 2.6.6-rc3 kernel while already running another configuration of
the same kernel version.

What happens is that "make modules_install" installs a new loop driver
built for the new kernel, but when you then run "make install",
mkinitrd loads the loop driver. The result is that the new loop driver
gets loaded into the old kernel, and depending on what configuration
options you changed, this may or may not work. In my case I got an
oops in lo_open().

Maybe something similar is happening in your case.

-- 
Peter Osterlund - petero2@telia.com
http://w1.894.telia.com/~u89404340
