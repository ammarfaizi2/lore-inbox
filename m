Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287439AbSAPUSs>; Wed, 16 Jan 2002 15:18:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287440AbSAPUSj>; Wed, 16 Jan 2002 15:18:39 -0500
Received: from codepoet.org ([166.70.14.212]:23246 "EHLO winder.codepoet.org")
	by vger.kernel.org with ESMTP id <S287439AbSAPUSX>;
	Wed, 16 Jan 2002 15:18:23 -0500
Date: Wed, 16 Jan 2002 13:18:23 -0700
From: Erik Andersen <andersen@codepoet.org>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Query about initramfs and modules
Message-ID: <20020116201823.GA1872@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	"H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
In-Reply-To: <15428.47094.435181.278715@irving.iisd.sra.com> <Pine.GSO.4.21.0201152226100.4339-100000@weyl.math.psu.edu> <20020116194121.GC32184@codepoet.org> <a24lub$4o9$1@cesium.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a24lub$4o9$1@cesium.transmeta.com>
User-Agent: Mutt/1.3.24i
X-Operating-System: Linux 2.4.16-rmk1, Rebel-NetWinder(Intel StrongARM 110 rev 3), 185.95 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed Jan 16, 2002 at 11:56:59AM -0800, H. Peter Anvin wrote:
> Followup to:  <20020116194121.GC32184@codepoet.org>
> By author:    Erik Andersen <andersen@codepoet.org>
> In newsgroup: linux.dev.kernel
> > 
> > Keep in mind that insmod current needs to incorporate a full ELF
> > interpreter in userspace (and the source code needs to know about
> > all the types of relocations and jump for each arch and for 32
> > and 64 bit ELF.  Horrible stuff really.  If we could cleanup the
> > kernel's insmod implementation to require merely a syscall
> > passing a filename to the kernel, it would sure make the
> > initramfs smaller and simpler.  I believe Rusty made a patch to
> > do this sort of thing....
> > 
> 
> Yeah!  Let's put all this crap in KERNEL SPACE!  *NOT!*

Good point.  We surely wouldn't want to have an ELF interpreter
in kernel space.  That would be evil!  
	rm linux/fs/binfmt_elf.c
There, thats better, now userspace can load everything.  If we
can figure out how to get userspace loaded....

The kernel already knows how to load ELF files, and _has_ to do
that job to get userspace running anyways.   So why not use that
mechanism for modules?

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
