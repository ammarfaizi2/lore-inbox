Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277733AbRJIOnn>; Tue, 9 Oct 2001 10:43:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277731AbRJIOn1>; Tue, 9 Oct 2001 10:43:27 -0400
Received: from obelix.hrz.tu-chemnitz.de ([134.109.132.55]:32704 "EHLO
	obelix.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id <S277732AbRJIOnX>; Tue, 9 Oct 2001 10:43:23 -0400
Date: Tue, 9 Oct 2001 16:43:48 +0200
From: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: VDA <VDA@port.imtp.ilyichevsk.odessa.ua>, linux-kernel@vger.kernel.org
Subject: Re: kernel size
Message-ID: <20011009164348.I30515@nightmaster.csn.tu-chemnitz.de>
In-Reply-To: <163112682879.20011009161634@port.imtp.ilyichevsk.odessa.ua> <Pine.LNX.3.95.1011009100315.5093A-100000@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <Pine.LNX.3.95.1011009100315.5093A-100000@chaos.analogic.com>; from root@chaos.analogic.com on Tue, Oct 09, 2001 at 10:16:48AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 09, 2001 at 10:16:48AM -0400, Richard B. Johnson wrote:
> Compiled, produces this:
> 
> 	.file	"xxx.c"
> 	.version	"01.01"
> gcc2_compiled.:
> 	.comm	foo,4,4
> 	.ident	"GCC: (GNU) egcs-2.91.66 19990314 (egcs-1.1.2 release)"
> 
> It __might__ be possible to link, without linking in ".ident", which
> currently shares space with .rodata. My gcc man pages are not any
> better than the usual Red Hat so I can't find out if there is any way
> to turn OFF these spurious strings.

strip -R .ident -R .comment -R .note

is your friend. 

Or if we would like to solve it more elegant:

--- linux-2.4.10/arch/i386/vmlinux.lds       Tue Oct  9 16:36:06 2001
+++ linux/arch/i386/vmlinux.lds   Tue Oct  9 16:36:28 2001
@@ -70,6 +70,9 @@
        *(.text.exit)
        *(.data.exit)
        *(.exitcall.exit)
+       *(.ident)
+       *(.comment)
+       *(.note)
        }

   /* Stabs debugging sections.  */


which puts it into the list of sections to be discarde on i386.

Regards

Ingo Oeser
