Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261625AbVCCLof@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261625AbVCCLof (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 06:44:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261642AbVCCLkw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 06:40:52 -0500
Received: from fire.osdl.org ([65.172.181.4]:61114 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261625AbVCCLhl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 06:37:41 -0500
Date: Thu, 3 Mar 2005 03:37:04 -0800
From: Andrew Morton <akpm@osdl.org>
To: jes@trained-monkey.org (Jes Sorensen)
Cc: linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [patch -mm series] ia64 specific /dev/mem handlers
Message-Id: <20050303033704.6fb77a34.akpm@osdl.org>
In-Reply-To: <16923.193.128608.607599@jaguar.mkp.net>
References: <16923.193.128608.607599@jaguar.mkp.net>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jes@trained-monkey.org (Jes Sorensen) wrote:
>
> This patch introduces ia64 specific read/write handlers for /dev/mem
>  access which is needed to avoid uncached pages to be accessed through
>  the cached kernel window which can lead to random corruption.

This patch causes hiccups on my ia32e box.

linux:/home/akpm#  /usr/sbin/hwscan --isapnp                       
zsh: 7528 segmentation fault  /usr/sbin/hwscan --isapnp
linux:/home/akpm#  /usr/sbin/hwscan --pci   
zsh: 7529 segmentation fault  /usr/sbin/hwscan --pci
linux:/home/akpm#  /usr/sbin/hwscan --block
zsh: 7530 segmentation fault  /usr/sbin/hwscan --block
linux:/home/akpm#  /usr/sbin/hwscan --floppy
zsh: 7533 segmentation fault  /usr/sbin/hwscan --floppy

strace ends with:

open("/proc/apm", O_RDONLY)             = -1 ENOENT (No such file or directory)
open("/dev/mem", O_RDONLY)              = 3
lseek(3, 1024, SEEK_SET)                = 1024
read(3, 0x50a080, 256)                  = -1 EFAULT (Bad address)
close(3)                                = 0
--- SIGSEGV (Segmentation fault) @ 0 (0) ---
+++ killed by SIGSEGV +++



