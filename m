Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261217AbVCYEWf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261217AbVCYEWf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 23:22:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261221AbVCYEWe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 23:22:34 -0500
Received: from fire.osdl.org ([65.172.181.4]:53740 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261217AbVCYEWa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 23:22:30 -0500
Date: Thu, 24 Mar 2005 20:22:15 -0800
From: Andrew Morton <akpm@osdl.org>
To: Miles Lane <miles.lane@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: OOPS running "ls -l /sys/class/i2c-adapter/*"-- 2.6.12-rc1-mm2
Message-Id: <20050324202215.663bd8a9.akpm@osdl.org>
In-Reply-To: <a44ae5cd05032420122cd610bd@mail.gmail.com>
References: <20050324044114.5aa5b166.akpm@osdl.org>
	<a44ae5cd05032420122cd610bd@mail.gmail.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Miles Lane <miles.lane@gmail.com> wrote:
>
> root@Monkey100:/sys/class/i2c-adapter# ls * -l
>  root@Monkey100:/sys# cat */*/*/*
> 
>  ksymoops 2.4.9 on i686 2.6.12-rc1-mm2.  Options used
>       -o /lib/modules/2.6.12-rc1-mm2 (specified)
>       -m /boot/System.map-2.6.12-rc1-mm2 (specified)
> 
>  Unable to handle kernel paging request at virtual address 24fc1024
>  c0198448
>  *pde = 00000000
>  Oops: 0000 [#1]
>  CPU:    0
>  EIP:    0060:[<c0198448>]    Not tainted VLI

I wonder why the EIP sometimes doesn't get decoded.

>  Using defaults from ksymoops -t elf32-i386 -a i386
>  EFLAGS: 00210206   (2.6.12-rc1-mm2)
>  eax: 00000001   ebx: c039f820   ecx: 00000001   edx: 24fc1000
>  esi: e75b6cc4   edi: f7c015e4   ebp: e7b93e94   esp: e7b93e94
>  ds: 007b   es: 007b   ss: 0068
>  Stack: e7b93eb8 c0198644 f7c01694 00000000 f7c015e4 e7b93eb8 c039f820 e75b6cc4
>         f7c015e4 e7b93edc c0198790 f7c01694 f7c015e4 e712a000 f7c01694 e712a000
>         fffffff4 e7b93f10 e7b93ef8 c019884f e75b6cc4 e712a000 ffffffea e75b6cc4
>  Call Trace:
>   [<c010410f>] show_stack+0x7f/0xa0
>   [<c01042aa>] show_registers+0x15a/0x1c0
>   [<c01044ac>] die+0xfc/0x190
>   [<c011450b>] do_page_fault+0x31b/0x670
>   [<c0103cf3>] error_code+0x4f/0x54
>   [<c0198644>] sysfs_get_target_path+0x14/0x80
>   [<c0198790>] sysfs_getlink+0xe0/0x150
>   [<c019884f>] sysfs_follow_link+0x4f/0x60
>   [<c016b46f>] generic_readlink+0x2f/0x90
>   [<c01635b6>] sys_readlink+0x86/0x90
>   [<c0103249>] syscall_call+0x7/0xb
>  Code: 42 70 e8 a4 fc 19 00 e9 f3 fe ff ff 90 90 90 90 90 90 90 90 90
>  90 90 90 90 90 90 90 90 90 90 90 90 90 90 55 31 c0 89 e5 8b 55 08<8b>
>  52 24 40 85 d2 75 f8 c9 c3 8d b4 26 00 00 00 00 8d bc 27 00
> 
> 
>  >>EIP; c0198448 <object_depth+8/20>   <=====

I can't repeat it here.  Are you able to narrow it down to a specific sysfs
file?

The .config might help.

