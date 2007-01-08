Return-Path: <linux-kernel-owner+w=401wt.eu-S932160AbXAHWpm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932160AbXAHWpm (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 17:45:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932165AbXAHWpm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 17:45:42 -0500
Received: from smtp.osdl.org ([65.172.181.24]:50395 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932160AbXAHWpl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 17:45:41 -0500
Date: Mon, 8 Jan 2007 14:45:33 -0800
From: Andrew Morton <akpm@osdl.org>
To: Gautham R Shenoy <ego@in.ibm.com>
Cc: vgoyal@in.ibm.com, vatsa@in.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Change cpu_up and co from __devinit to __cpuinit
Message-Id: <20070108144533.186a40c6.akpm@osdl.org>
In-Reply-To: <20070106093907.pu7mzlzeo0c4ck8s@imap.linux.ibm.com>
References: <20070106093907.pu7mzlzeo0c4ck8s@imap.linux.ibm.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat,  6 Jan 2007 09:39:07 -0500
Gautham R Shenoy <ego@in.ibm.com> wrote:

> Compiling the kernel with CONFIG_HOTPLUG = y and CONFIG_HOTPLUG_CPU = n
> with CONFIG_RELOCATABLE = y generates the following modpost warnings
> 
> WARNING: vmlinux - Section mismatch: reference to .init.data: from
> .text between '_cpu_up' (at offset 0xc0141b7d) and 'cpu_up'
> WARNING: vmlinux - Section mismatch: reference to .init.data: from
> .text between '_cpu_up' (at offset 0xc0141b9c) and 'cpu_up'
> WARNING: vmlinux - Section mismatch: reference to .init.text:__cpu_up
> from .text between '_cpu_up' (at offset 0xc0141bd8) and 'cpu_up'
> WARNING: vmlinux - Section mismatch: reference to .init.data: from
> .text between '_cpu_up' (at offset 0xc0141c05) and 'cpu_up'
> WARNING: vmlinux - Section mismatch: reference to .init.data: from
> .text between '_cpu_up' (at offset 0xc0141c26) and 'cpu_up'
> WARNING: vmlinux - Section mismatch: reference to .init.data: from
> .text between '_cpu_up' (at offset 0xc0141c37) and 'cpu_up'

I suppose we should treat this as a 2.6.20 bugfix.

> --- linux-2.6.20-rc3.orig/kernel/cpu.c
> +++ linux-2.6.20-rc3/kernel/cpu.c
> @@ -210,7 +210,7 @@ int cpu_down(unsigned int cpu)
>    #endif /*CONFIG_HOTPLUG_CPU*/
> 
>    /* Requires cpu_add_remove_lock to be held */
> -static int __devinit _cpu_up(unsigned int cpu)
> +static int __cpuinit _cpu_up(unsigned int cpu)
>    {

Well that's new.  space-stuffed emails are common enough, but you've worked
out how to do space-double-stuffing.

