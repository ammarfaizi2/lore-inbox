Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265144AbUHNTnF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265144AbUHNTnF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Aug 2004 15:43:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265119AbUHNTmA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Aug 2004 15:42:00 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:18356 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264923AbUHNTlf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Aug 2004 15:41:35 -0400
Date: Sat, 14 Aug 2004 15:12:47 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] HOWTO find oops location
Message-ID: <20040814181247.GI846@logos.cnet>
References: <200408141153.06625.vda@port.imtp.ilyichevsk.odessa.ua> <200408141930.19163.vda@port.imtp.ilyichevsk.odessa.ua> <20040814162201.GE846@logos.cnet> <200408142159.27719.vda@port.imtp.ilyichevsk.odessa.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200408142159.27719.vda@port.imtp.ilyichevsk.odessa.ua>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 14, 2004 at 09:59:27PM +0300, Denis Vlasenko wrote:
> > > > Might be also worth mentioning "gcc -c file.c -g -Wa,-a,-ad  > file.s"
> > > > which makes gcc output C code mixed with asm output.
> > > >
> > > > Sometimes its not as effective as the comment method you describe,
> > > > but it will be less work for sure :)
> > >
> > > Aha! Cool.
> > >
> > > Mmmm... How to ensure that build environment exactly matches one
> > > used during make? Environment, -On level, regparm, other gcc switches,
> > > etc, etc, etc? Else file.s object code can be rather different from
> > > code in file.o...
> >
> > No idea.
> 
> I tried on 2.6:
> 
> make V=1 fs/dcache.o
> make V=1 CFLAGS="-g -Wa,-a,-ad" fs/dcache.o >dcache.asm
> 
> and compared gcc invocation commands. Pseudodiff:
> 
> - -Wall -Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing
> - -fno-common -pipe -msoft-float -mpreferred-stack-boundary=2
> - -march=i486 -I/.1/usr/srcdevel/kernel/linux-2.6.7-bk20.src/include/asm-i386/mach-default
> - -Iinclude/asm-i386/mach-default -O2 -falign-functions=1 -falign-labels=1 -falign-loops=1
> - -falign-jumps=1
> + -g -Wa,-a,-ad
> 
> :(

This worked for me:

gcc -c -g -Wa,-a,-ad -Wp,-MD,fs/.buffer.o.d -nostdinc -iwithprefix include -D__KERNEL__ -Iinclude  
-Wall -Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing -fno-common -pipe -msoft-float 
-mpreferred-stack-boundary=2  -march=athlon -Iinclude/asm-i386/mach-default -O2     
-DKBUILD_BASENAME=buffer -DKBUILD_MODNAME=buffer  fs/buffer.c

The order of the parameters matter in some way, which I have no idea of.
