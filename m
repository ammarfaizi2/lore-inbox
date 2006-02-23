Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750944AbWBWEio@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750944AbWBWEio (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 23:38:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750933AbWBWEio
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 23:38:44 -0500
Received: from xenotime.net ([66.160.160.81]:43175 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1750739AbWBWEin (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 23:38:43 -0500
Date: Wed, 22 Feb 2006 20:39:46 -0800
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: "Ian McDonald" <imcdnzl@gmail.com>
Cc: trivial@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation: Update to BUG-HUNTING
Message-Id: <20060222203946.f698d8ed.rdunlap@xenotime.net>
In-Reply-To: <cbec11ac0602221147n75e077cep9718c637f9761acd@mail.gmail.com>
References: <cbec11ac0602221147n75e077cep9718c637f9761acd@mail.gmail.com>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Feb 2006 08:47:39 +1300 Ian McDonald wrote:

> Hi there,

Lo,

> +Finding bugs is not always easy. Have a go though. If you can't find it don't
> +give up. Report as much as you have found to the relevant maintainer. See
> +MAINTAINERS for who that is for the subsystem you have worked on.
   or that you are having problems with.


> +To debug a kernel, use objdump and look for the hex offset from the crash
> +output to find the valid line of code/assembler. Without debug symbols, you
> +will see the assembler code for the routine shown, but if your kernel has
> +debug symbols the C code will also be available. (Debug symbols can be enabled
> +in the kernel hacking menu of the menu configuration.) For example:
> +
> +    objdump -r -S -l --disassemble net/dccp/ipv4.o
> +
> +NB.: you need to be at the top level of the kernel tree for this to pick up
> +your C files.
> +
> +If you don't have access to the code you can also debug on some crash dumps
> +e.g. crash dump output as shown by Dave Miller.
> +
> +>    EIP is at ip_queue_xmit+0x14/0x4c0
> +>     ...
> +>    Code: 44 24 04 e8 6f 05 00 00 e9 e8 fe ff ff 8d 76 00 8d bc 27 00 00
> +>    00 00 55 57  56 53 81 ec bc 00 00 00 8b ac 24 d0 00 00 00 8b 5d 08
> +>    <8b> 83 3c 01 00 00 89 44  24 14 8b 45 28 85 c0 89 44 24 18 0f 85
> +>
> +>    Put the bytes into a "foo.s" file like this:
> +>
> +>           .text
> +>           .globl foo
> +>    foo:
> +>           .byte  .... /* bytes from Code: part of OOPS dump */
> +>
> +>    Compile it with "gcc -c -o foo.o foo.s" then look at the output of
> +>    "objdump --disassemble foo.o".

Maybe add this:

You can also take the "Code:" <object code> and feed it as bytes into a
.S (assembly) source file, assemble that, then objdump the .o file.
This is especially useful if the "Code:" line is one of the best clues
that you have.  Andi Kleen has a script for doing this.  It's called
'decodecode' and it's available from
ftp://ftp.firstfloor.org/pub/ak/shell/decodecode


---
~Randy
