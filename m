Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317362AbSGDHxT>; Thu, 4 Jul 2002 03:53:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317363AbSGDHxS>; Thu, 4 Jul 2002 03:53:18 -0400
Received: from zok.SGI.COM ([204.94.215.101]:40630 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S317362AbSGDHxS>;
	Thu, 4 Jul 2002 03:53:18 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: "Adam J. Richter" <adam@yggdrasil.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: __ex_table vs. init sections bug in most architectures 
In-reply-to: Your message of "Thu, 04 Jul 2002 00:09:17 MST."
             <200207040709.AAA05891@adam.yggdrasil.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 04 Jul 2002 17:55:40 +1000
Message-ID: <13382.1025769340@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Jul 2002 00:09:17 -0700, 
"Adam J. Richter" <adam@yggdrasil.com> wrote:
>	It looks like all architectures except {sparc,ppc}{,64} rely on
>the __ex_table section already being sorted by the address of the
>instruction that caused the memory access violation that is to be fixed
>up.  However, __ex_table will not be constructed in sorted order if it
>includes any references made from an __init or __exit routine, because
>these routines are loaded into the kernel image after all of the other
>routines, rather than being loaded in the order in which they appear in
>each source file.

http://marc.theaimsgroup.com/?l=linux-kernel&m=101912337804026&w=2 and
the following thread.  I was going to recode using the ppc insert sort
but got sidetracked.

>One refinement of this
>approach would be have some bfd tool sort __ex_table in vmlinux
>when the kernel is linked, and to do something similar for
>modules, to keep the sort out of the kernel and save a few
>microseconds of run time.

That either requires bfd devel to build the kernel (no chance) or a
program that can cope with cross compilation, including different word
sizes and endianness between the build and target machines.  It is
easier and safer to do the sort at boot time then discard the code.

