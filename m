Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277750AbRJIOxl>; Tue, 9 Oct 2001 10:53:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277744AbRJIOxI>; Tue, 9 Oct 2001 10:53:08 -0400
Received: from chaos.analogic.com ([204.178.40.224]:58240 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S277746AbRJIOwy>; Tue, 9 Oct 2001 10:52:54 -0400
Date: Tue, 9 Oct 2001 10:52:50 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
cc: VDA <VDA@port.imtp.ilyichevsk.odessa.ua>, linux-kernel@vger.kernel.org
Subject: Re: kernel size
In-Reply-To: <20011009164348.I30515@nightmaster.csn.tu-chemnitz.de>
Message-ID: <Pine.LNX.3.95.1011009105102.5543A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Oct 2001, Ingo Oeser wrote:

> On Tue, Oct 09, 2001 at 10:16:48AM -0400, Richard B. Johnson wrote:
> > Compiled, produces this:
> > 
> > 	.file	"xxx.c"
> > 	.version	"01.01"
> > gcc2_compiled.:
> > 	.comm	foo,4,4
> > 	.ident	"GCC: (GNU) egcs-2.91.66 19990314 (egcs-1.1.2 release)"
> > 
> > It __might__ be possible to link, without linking in ".ident", which
> > currently shares space with .rodata. My gcc man pages are not any
> > better than the usual Red Hat so I can't find out if there is any way
> > to turn OFF these spurious strings.
> 
> strip -R .ident -R .comment -R .note
> 
> is your friend. 
> 
> Or if we would like to solve it more elegant:
> 
> --- linux-2.4.10/arch/i386/vmlinux.lds       Tue Oct  9 16:36:06 2001
> +++ linux/arch/i386/vmlinux.lds   Tue Oct  9 16:36:28 2001
> @@ -70,6 +70,9 @@
>         *(.text.exit)
>         *(.data.exit)
>         *(.exitcall.exit)
> +       *(.ident)
> +       *(.comment)
> +       *(.note)
>         }
> 

Yes! Wonderful...
-rwxr-xr-x   1 root     root      1571516 Oct  9 10:50 vmlinux
-rwxr-xr-x   1 root     root      1590692 Oct  1 13:26 vmlinux.OLD

That got rid of some cruft.


Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

    I was going to compile a list of innovations that could be
    attributed to Microsoft. Once I realized that Ctrl-Alt-Del
    was handled in the BIOS, I found that there aren't any.


