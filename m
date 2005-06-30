Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262957AbVF3KeV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262957AbVF3KeV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Jun 2005 06:34:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262955AbVF3KdE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Jun 2005 06:33:04 -0400
Received: from wproxy.gmail.com ([64.233.184.201]:21735 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262938AbVF3Kbl convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Jun 2005 06:31:41 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=n2ul0CgMWSVwuMITT6plThzW+NgOyAGO7cSCTtYMxqXmbzNfE5yzzGJCF0weWyFii+67UULsttNoPp9HRPWWCsVZcHPdvI+VWsvsbl5xHbHiiZYWI++ZkLN8tpLHzNy9RW/wuWgP2rz8V+ypXTmOOorTCOhvRICdv6DUxC+grNA=
Message-ID: <cce092220506300331401efa35@mail.gmail.com>
Date: Thu, 30 Jun 2005 18:31:37 +0800
From: Wang Jian <larkwang@gmail.com>
Reply-To: Wang Jian <larkwang@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.12.1 problems I meet (please CC: me)
In-Reply-To: <20050630111916.FEA2.LARKWANG@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050630111916.FEA2.LARKWANG@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2005/6/30, Wang Jian <larkwang@gmail.com>:
> Hi,
> 
> I use a customized kernel to do packets analysis. The analysis code is
> linked into kernel. It will vmalloc() nearly 128M (a little less) when
> initialized.
> 
> The original code runs on 2.6.10 and works fine. The platform is a
> general P4 with 100M ethernet. The user space system is a 8M compressed
> ramdisk image which is a 32M filesystem.
> 
> Now I want to make it work on 2.6.12+ and on Athlon64 platform, for
> better driver and better CPU/NIC performance.
> 
> I have a P4 box (compilation bed, CB), a 2-way Athlon64 box (test bed,
> TB).
> 
> The problems are:
> 
> 2. I compile kernel 2.6.12.1 for K7 on CB. Boot it on TB, the system
> boot up execept that the analysis code can't vmalloc() the needed memory.
> 
> "allocation failed: out of vmalloc space - use vmalloc=<size> to increase size."
> 
> If I use vmalloc=256m in boot command line, then
> 
> initrd extends beyond end of memory (0x37fef716 > 0x30000000)
> initrd extends beyond end of memory (0x37fef716 > 0x30000000)
> Kernel panic - unsyncing: VFS: Unable to mount root fs on unknown-block
> (1,0)
> 

This problem also presents itself in 2.6.10.

I remove 512M physic RAM from this TB, so it has 512M RAM left. The
problem is  then gone. The needed memory can be correctly vmalloc()
during boot without vmalloc=256m specified in boot command line.

I am curious why this happens?

1. With 512M physic RAM, vmalloc(16776989 * 8) succeeds.
2. With 1G physic RAM, vmalloc(16776989 * 8) fails.
3. With 1G physic RAM, vmalloc=256m boot option will cause kernel fail
to expand a 8M initrd image which is of 32M filesystem.
