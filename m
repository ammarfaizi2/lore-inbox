Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964874AbVLIT5g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964874AbVLIT5g (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Dec 2005 14:57:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932427AbVLIT5g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Dec 2005 14:57:36 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:24493 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S932425AbVLIT5f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Dec 2005 14:57:35 -0500
Subject: Re: i386 -> x86_64 cross compile failure (binutils bug?)
From: Lee Revell <rlrevell@joe-job.com>
To: Ken Moffat <zarniwhoop@ntlworld.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.63.0512091930440.19998@deepthought.mydomain>
References: <1134154208.14363.8.camel@mindpipe>
	 <Pine.LNX.4.63.0512091930440.19998@deepthought.mydomain>
Content-Type: text/plain
Date: Fri, 09 Dec 2005 14:59:02 -0500
Message-Id: <1134158342.18432.1.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-12-09 at 19:50 +0000, Ken Moffat wrote:
> On Fri, 9 Dec 2005, Lee Revell wrote:
> 
> > I'm trying to build an x66-64 kernel on a 32 bit system (Ubuntu 5.10).
> > I added -m64 to the CFLAGS as per the gcc docs.  But the build fails
> > with:
> >
> > $ make ARCH=x86_64
> >  [...]
> >  CC      init/initramfs.o
> >  CC      init/calibrate.o
> >  LD      init/built-in.o
> >  CHK     usr/initramfs_list
> >  CC      arch/x86_64/kernel/process.o
> >  CC      arch/x86_64/kernel/signal.o
> >  AS      arch/x86_64/kernel/entry.o
> > arch/x86_64/kernel/entry.S: Assembler messages:
> > arch/x86_64/kernel/entry.S:204: Error: cannot represent relocation type BFD_RELOC_X86_64_32S
> 
>   Unless ubuntu provides a biarch toolchain (and the fact gcc accepts 
> '-m64' means nothing - use 'file' on init/built-in.o), you have to build 
> a cross toolchain, (just binutils and gcc), put that on your path, and 
> use
> 
> make ARCH=x86_64 CROSS_COMPILE=x86_64-pc-linux-gnu-
> 
>   so that the build will use x86_64-pc-linux-gnu-as and friends.  You 
> should not need to mess with the CFLAGS.
> 

$ file init/built-in.o 
init/built-in.o: ELF 64-bit LSB relocatable, AMD x86-64, version 1
(SYSV), not stripped

>From man gcc, i386 section:

-m32
-m64
    Generate code for a 32-bit or 64-bit environment.  The 32-bit 
    environment sets int, long and pointer to 32
    bits and generates code that runs on any i386 system.  The 
    64-bit environment sets int to 32 bits and long
    and pointer to 64 bits and generates code for AMD's x86-64 
    architecture.

Lee

