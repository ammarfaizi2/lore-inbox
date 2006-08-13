Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751389AbWHMUAe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751389AbWHMUAe (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Aug 2006 16:00:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751397AbWHMUAe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Aug 2006 16:00:34 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:48653 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751389AbWHMUAe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Aug 2006 16:00:34 -0400
Date: Sun, 13 Aug 2006 22:00:32 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Jakub Jelinek <jakub@redhat.com>
Cc: David Woodhouse <dwmw2@infradead.org>, linux-kernel@vger.kernel.org,
       dhowells@redhat.com, linux-audit@redhat.com
Subject: Re: ELF: what should be part of the userspace headers?
Message-ID: <20060813200032.GI3543@stusta.de>
References: <20060805110559.GU25692@stusta.de> <1154776124.5181.57.camel@shinybook.infradead.org> <20060805112148.GH32572@devserv.devel.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060805112148.GH32572@devserv.devel.redhat.com>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 05, 2006 at 07:21:48AM -0400, Jakub Jelinek wrote:
> On Sat, Aug 05, 2006 at 07:08:43PM +0800, David Woodhouse wrote:
> > On Sat, 2006-08-05 at 13:05 +0200, Adrian Bunk wrote:
> > > include/linux/elf-em.h is used by include/linux/audit.h, but this usage 
> > > doesn't seem to be part of the kernel <-> userspace interface?
> > 
> > The machine types _are_ part of the audit kernel<->userspace interface,
> > I think. Exporting elf-em.h should be fairly harmless.
> > 
> > > And which part of the ELF headers is part of the kernel <-> userspace 
> > > interface?
> > 
> > Almost none of them, I'd suggest. Nothing but auxvec.h
> 
> Well, sys/procfs.h on several arches includes <asm/elf.h>:
> 
> find -type f -a -name \*.h | xargs grep '<\(asm\|linux\).*elf'
> ./sysdeps/unix/sysv/linux/alpha/sys/procfs.h:#include <asm/elf.h>
> ./sysdeps/unix/sysv/linux/sh/sys/procfs.h:#include <asm/elf.h>
> ./sysdeps/unix/sysv/linux/sys/procfs.h:#include <asm/elf.h>
> 
> while most other arches don't need it:
> for i in `find . -name procfs.h`; do grep -q '<\(asm\|linux\).*elf' $i || echo $i; done
> ./sysdeps/unix/sysv/linux/s390/sys/procfs.h
> ./sysdeps/unix/sysv/linux/powerpc/sys/procfs.h
> ./sysdeps/unix/sysv/linux/sparc/sys/procfs.h
> ./sysdeps/unix/sysv/linux/i386/sys/procfs.h
> ./sysdeps/unix/sysv/linux/ia64/sys/procfs.h
> ./sysdeps/unix/sysv/linux/x86_64/sys/procfs.h
> 
> Guess it shouldn't be hard to convert even alpha and sh (not sure then
> if there are any arches that actually use the linux/sys/procfs.h header).

Thanks for this, I grepped only on i386.

Let me try to put it into two questions:
- What should be exported to userspace as part of the
  kernel<->userspace interface?
- What has to be exported (at least for some time) for not breaking
  existing userspace code?

Your answer was for the second question.

But even more important is the first question.

> 	Jakub

cu
Adrian

-- 

    Gentoo kernels are 42 times more popular than SUSE kernels among
    KLive users  (a service by SUSE contractor Andrea Arcangeli that
    gathers data about kernels from many users worldwide).

       There are three kinds of lies: Lies, Damn Lies, and Statistics.
                                                    Benjamin Disraeli

