Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262330AbTKTVTV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Nov 2003 16:19:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262458AbTKTVTU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Nov 2003 16:19:20 -0500
Received: from fw.osdl.org ([65.172.181.6]:21738 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262330AbTKTVTT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Nov 2003 16:19:19 -0500
Date: Thu, 20 Nov 2003 13:19:45 -0800
From: Andrew Morton <akpm@osdl.org>
To: Lawrence Walton <lawrence@the-penguin.otak.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Opps on boot 2.6.0-pre9-mm4
Message-Id: <20031120131945.3cd35911.akpm@osdl.org>
In-Reply-To: <20031120193318.GA5578@the-penguin.otak.com>
References: <20031120193318.GA5578@the-penguin.otak.com>
X-Mailer: Sylpheed version 0.9.6 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lawrence Walton <lawrence@the-penguin.otak.com> wrote:
>
> Hello all, I got this opps when booting 2.6.0-test9-mm4
> It happens consistently every boot.
> 
> I had to copy it down by hand, I think I got all of it correctly.
> As always flames, additional questions, and patches are welcome.
> 
> 
> 
> 
> 
> ksymoops 2.4.9 on i686 2.6.0-test9.  Options used
>      -V (default)
>      -k /proc/ksyms (default)
>      -l /proc/modules (default)
>      -o /lib/modules/2.6.0-test9-mm4/ (specified)
>      -m /System.map (specified)
> 
> Error (regular_file): read_ksyms stat /proc/ksyms failed
> No modules in ksyms, skipping objects
> No ksyms, skipping lsmod
> CPU:    0
> EIP:    0098:[<00005121>]  Not tainted VLI
> Using defaults from ksymoops -t elf32-i386 -a i386
> EFLAGS: 00010046
> esi: 0000a15a   edi: 00000000     ebp: c151fe8c       esp: c151fe5a
> ds: 00a0   es: 00a8   ss: 0068
> Stack: 00000cfe 0e5700a0 000b000b 9daba392 9d3a9b03 9ad10001 00000000 007b0001
>        9ab6007b 00000246 00020082 000bdfdc 00020090 00000002 000100a8 000000a0
>        9ce70000 0060c025 00020000 00000000 00000000 007b0000 007b0000 02460000
> Call Trace:
> Code: Bad EIP Value.

Looks like it died inside the machine's BIOS.

Please try reverting the three pnp patches:

ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.0-test9/2.6.0-test9-mm4/broken-out/pnp-fix-3.patch
ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.0-test9/2.6.0-test9-mm4/broken-out/pnp-fix-2.patch
ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.0-test9/2.6.0-test9-mm4/broken-out/pnp-fix-1.patch

and let us know?

Other things to do would be:

- Add `initcall_debug' to the kernel boot command line, look up the final
  initcall address in System.map

- Disable pnpbios in kernel config

- Upgrade the bios

Thanks.
