Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965346AbWAFXK0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965346AbWAFXK0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 18:10:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965349AbWAFXKZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 18:10:25 -0500
Received: from smtp.osdl.org ([65.172.181.4]:16341 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965346AbWAFXKY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 18:10:24 -0500
Date: Fri, 6 Jan 2006 15:12:15 -0800
From: Andrew Morton <akpm@osdl.org>
To: simon schuler <simon.schuler@gmx.net>
Cc: linux-kernel@vger.kernel.org, JANAK DESAI <janak@us.ibm.com>
Subject: Re: Oops with 2.6.15-mm1
Message-Id: <20060106151215.106fd0ca.akpm@osdl.org>
In-Reply-To: <43BE8495.8050907@gmx.net>
References: <20060105062249.4bc94697.akpm@osdl.org>
	<43BE8495.8050907@gmx.net>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

simon schuler <simon.schuler@gmx.net> wrote:
>
> I'm getting an oops sometimes (about 70% probability) when I try to 
> start a wine application.
> last working kernel version: 2.6.15-rc5-mm1
> not working: 2.6.15-mm1, 2.6.15-rc5-mm3
> not tested: 2.6.15-rc5-mm2
> 
> .config is attached.
> I don't know if this is a known issue...
> If you need more information, let me know.
> 
> Unable to handle kernel NULL pointer dereference at virtual address 00000004
>  printing eip:
> c0118755
> *pde = 00000000
> Oops: 0000 [#1]
> last sysfs file: /class/vc/vcsa1/dev
> Modules linked in:
> CPU:    0
> EIP:    0060:[<c0118755>]    Not tainted VLI
> EFLAGS: 00210282   (2.6.15-mm1)
> EIP is at dup_fd+0x25/0x290
> eax: eff40c20   ebx: eff40c28   ecx: eff40c20   edx: eff40c58
> esi: ead0e000   edi: 00000000   ebp: eff7aaa0   esp: ead0fe48
> ds: 007b   es: 007b   ss: 0068
> Process wine (pid: 769, threadinfo=ead0e000 task=eb468ab0)
> Stack: <0>00000000 ebbe8854 00000001 ec1abd0c eff40c20 c015b937 ec1abd0c 
> 00000001
>        <0>00000000 eb468ab0 ead0e000 c0423ebe eff7aaa0 c0118a1c eb468ab0 
> ead0fe88
>        <0>fffffff4 eff40ce0 c0118a73 00000000 eb468ab0 00000060 ead0e000 
> c01867e4
> Call Trace:
>  [<c015b937>] vfs_read+0x127/0x190
>  [<c0118a1c>] copy_files+0x5c/0x80
>  [<c0118a73>] unshare_files+0x33/0x70
>  [<c01867e4>] load_elf_binary+0x174/0xe10
>  [<c014102f>] get_page_from_freelist+0x7f/0xd0
>  [<c0259d0f>] copy_from_user+0x3f/0xa0
>  [<c0259d0f>] copy_from_user+0x3f/0xa0
>  [<c0166063>] copy_strings+0x163/0x230
>  [<c0167160>] search_binary_handler+0x50/0x180
>  [<c0167414>] do_execve+0x184/0x220
>  [<c0101c4c>] sys_execve+0x3c/0x80
>  [<c010300b>] sysenter_past_esp+0x54/0x75
> Code: bc 27 00 00 00 00 55 57 56 53 83 ec 24 8b 44 24 38 8b b8 64 04 00 
> 00 e8 6a ff ff ff 85 c0 89 44 24 10 0f 84 b6 01 00 00 8b 58 04 <8b> 77 
> 04 89 34 24 e8 d0 fe ff ff 89 44 24 18 31 c0 8b 54 24 18
> 

OK, thanks.  It looks like a problem in the new unsharing code...
