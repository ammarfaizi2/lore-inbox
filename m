Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263270AbTCYUHJ>; Tue, 25 Mar 2003 15:07:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263277AbTCYUHJ>; Tue, 25 Mar 2003 15:07:09 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:1804 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S263270AbTCYUHI>; Tue, 25 Mar 2003 15:07:08 -0500
Date: Tue, 25 Mar 2003 20:18:15 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Andy Pfiffer <andyp@osdl.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       jsimmons@infradead.org
Subject: Re: [TRIVIAL PATCH][2.5.66] fix for link-error in i810fb_imageblit
Message-ID: <20030325201815.F24418@flint.arm.linux.org.uk>
Mail-Followup-To: Andy Pfiffer <andyp@osdl.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	jsimmons@infradead.org
References: <1048623198.14000.8.camel@andyp.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1048623198.14000.8.camel@andyp.pdx.osdl.net>; from andyp@osdl.org on Tue, Mar 25, 2003 at 12:13:19PM -0800
X-Message-Flag: Your copy of Microsoft Outlook is vurnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 25, 2003 at 12:13:19PM -0800, Andy Pfiffer wrote:
> The error:
>         ld -m elf_i386  -T arch/i386/vmlinux.lds.s
> arch/i386/kernel/head.o arch/i386/kernel/init_task.o   init/built-in.o
> --start-group  usr/built-in.o  arch/i386/kernel/built-in.o 
> arch/i386/mm/built-in.o  arch/i386/mach-default/built-in.o 
> kernel/built-in.o  mm/built-in.o  fs/built-in.o  ipc/built-in.o 
> security/built-in.o  crypto/built-in.o  lib/lib.a  arch/i386/lib/lib.a 
> drivers/built-in.o  sound/built-in.o  arch/i386/pci/built-in.o 
> net/built-in.o --end-group  -o .tmp_vmlinux1
> drivers/built-in.o: In function `i810fb_imageblit':
> drivers/built-in.o(.text+0xb59c1): undefined reference to `__memcpy'
> make: *** [.tmp_vmlinux1] Error 1
> 
> 
> The diff:
> 
> diff -Nru a/include/linux/fb.h b/include/linux/fb.h
> --- a/include/linux/fb.h	Tue Mar 25 12:02:29 2003
> +++ b/include/linux/fb.h	Tue Mar 25 12:02:29 2003
> @@ -4,6 +4,7 @@
>  #include <linux/tty.h>
>  #include <asm/types.h>
>  #include <asm/io.h>
> +#include <asm/string.h>
>  
>  /* Definitions of frame buffers						*/

Why linux/fb.h and why asm/string.h when we have linux/string.h?
Shouldn't <linux/string.h> be included by the i810fb driver?

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

