Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262740AbVAJWiP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262740AbVAJWiP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 17:38:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262584AbVAJWhe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 17:37:34 -0500
Received: from smtpout.mac.com ([17.250.248.45]:3015 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S262568AbVAJWdp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 17:33:45 -0500
In-Reply-To: <20050110135811.8559.qmail@web52207.mail.yahoo.com>
References: <20050110135811.8559.qmail@web52207.mail.yahoo.com>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <B1B1EF32-6357-11D9-9712-000D9352858E@mac.com>
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org
From: Felipe Alfaro Solana <lkml@mac.com>
Subject: Re: ext3 inclusion in kernel config file
Date: Mon, 10 Jan 2005 23:33:47 +0100
To: linux lover <linux_lover2004@yahoo.com>
X-Mailer: Apple Mail (2.619)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10 Jan 2005, at 14:58, linux lover wrote:

> Hello,
> I have downloaded kernel 2.4.24 and compiled it as per
> my requirement. I have included here my config file.
> My requirements are to use this kernel on LAN with NIC
> 8139too and limited functionality. I have Intel
> 845GLAD motherboard. What i want to know is that is
> any necessary component am i missing to include???
>       Also i am confuse about ext3 filesystem. I think
> its essential to compile with ext3 support but how to
> include it either Module or Built-in support. I have
> compiled with exts as Module as well as built in and
> both are working. But i want to know standard way.

Ext3 isn't esentially a necessary filesystem: it depends on whether you 
will use it. Many Linux distributions use ReiserFS by default, others 
use ext3. So in fact, it depends. First, you will need to know what 
filesystem is being used by your root filesystem. Thus, you will 
probably want to compile the corresponding module into your kernel 
(instead of using a module).

For example, on my main workstation, I use ext3 and thus, I choose to 
build ext3 into the kernel. However, on my laptop I usually prefer to 
use ext2 and thus, I build ext2 into the kernel and don't build ext3 at 
all.

If your kernel works with ext3 as a module or built-in, is probably due 
to the fact that, either your root filesystem is not ext3, or you are 
using an Initial RAMDISK (initrd) which is loaded together with the 
kernel image into RAM by the bootloader. The kernel mounts the initial 
RAMDISK as the root filesystem and uses a /linuxrc script to start 
booting the system. I guess your Initial RAMDISK does also include the 
ext3.ko kernel module which is loaded into memory by /linuxrc in order 
to allow for mounting your real ext3 root filesystem later.

