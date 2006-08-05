Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751457AbWHELW4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751457AbWHELW4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Aug 2006 07:22:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751461AbWHELW4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Aug 2006 07:22:56 -0400
Received: from mx1.redhat.com ([66.187.233.31]:52203 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751457AbWHELW4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Aug 2006 07:22:56 -0400
Date: Sat, 5 Aug 2006 07:21:48 -0400
From: Jakub Jelinek <jakub@redhat.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org,
       dhowells@redhat.com, linux-audit@redhat.com
Subject: Re: ELF: what should be part of the userspace headers?
Message-ID: <20060805112148.GH32572@devserv.devel.redhat.com>
Reply-To: Jakub Jelinek <jakub@redhat.com>
References: <20060805110559.GU25692@stusta.de> <1154776124.5181.57.camel@shinybook.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1154776124.5181.57.camel@shinybook.infradead.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 05, 2006 at 07:08:43PM +0800, David Woodhouse wrote:
> On Sat, 2006-08-05 at 13:05 +0200, Adrian Bunk wrote:
> > include/linux/elf-em.h is used by include/linux/audit.h, but this usage 
> > doesn't seem to be part of the kernel <-> userspace interface?
> 
> The machine types _are_ part of the audit kernel<->userspace interface,
> I think. Exporting elf-em.h should be fairly harmless.
> 
> > And which part of the ELF headers is part of the kernel <-> userspace 
> > interface?
> 
> Almost none of them, I'd suggest. Nothing but auxvec.h

Well, sys/procfs.h on several arches includes <asm/elf.h>:

find -type f -a -name \*.h | xargs grep '<\(asm\|linux\).*elf'
./sysdeps/unix/sysv/linux/alpha/sys/procfs.h:#include <asm/elf.h>
./sysdeps/unix/sysv/linux/sh/sys/procfs.h:#include <asm/elf.h>
./sysdeps/unix/sysv/linux/sys/procfs.h:#include <asm/elf.h>

while most other arches don't need it:
for i in `find . -name procfs.h`; do grep -q '<\(asm\|linux\).*elf' $i || echo $i; done
./sysdeps/unix/sysv/linux/s390/sys/procfs.h
./sysdeps/unix/sysv/linux/powerpc/sys/procfs.h
./sysdeps/unix/sysv/linux/sparc/sys/procfs.h
./sysdeps/unix/sysv/linux/i386/sys/procfs.h
./sysdeps/unix/sysv/linux/ia64/sys/procfs.h
./sysdeps/unix/sysv/linux/x86_64/sys/procfs.h

Guess it shouldn't be hard to convert even alpha and sh (not sure then
if there are any arches that actually use the linux/sys/procfs.h header).

	Jakub
