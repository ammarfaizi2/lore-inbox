Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261894AbSJVIJp>; Tue, 22 Oct 2002 04:09:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262180AbSJVIJp>; Tue, 22 Oct 2002 04:09:45 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:27182 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S261894AbSJVIJo>; Tue, 22 Oct 2002 04:09:44 -0400
To: Jeff Garzik <jgarzik@pobox.com>
Cc: landley@trommello.org, Guillaume Boissiere <boissiere@adiglobal.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Son of crunch time: the list v1.2.
References: <20021021135137.2801edd2.rusty@rustcorp.com.au>
	<3DB3AB3E.23020.5FFF7144@localhost>
	<200210211536.25109.landley@trommello.org>
	<3DB4B1B9.4070303@pobox.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 22 Oct 2002 02:14:02 -0600
In-Reply-To: <3DB4B1B9.4070303@pobox.com>
Message-ID: <m1k7kaubzp.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik <jgarzik@pobox.com> writes:

> > 13) Kexec, luanch ELF format linux kernel from Linux (Eric W. Biederman)
> > http://lists.insecure.org/lists/linux-kernel/2002/Oct/6584.html
> 
> Useful, but at the same time not many people will use this I think.  It may need
> to live as a patch for a while, if not for a long while...

Hmm. 2+ years is not enough?

A couple of comments.

The limitation to the ELF file format is long gone, (so the summary is
incorrect).  sys_kexec can launch any random kernel, it just needs an
appropriate user space program that understands the format.  kexec
bzImage works, and I suspect kexec could even start booting windows
from the boot sector of a hard drive.

The code has been looked at, and discussed by the kmonte, and bootimg
authors, and the kexec interface has not been found to be a problem.
Except for tracking kernel interface changes the code really has not
needed to change in quite a long while.

The biggest challenge right now is to track down the strange and
mysterious failures caused by driver or BIOS bugs.  Kexec is
inherently open to a bug anywhere in the system causing it to fail.
The development work consists of writing code, and inventing
techniques to track down those mysterious failures.  Kernel debuggers
don't work when you don't have a running kernel. 

All of this is generic kernel stabilization work, and it sounds to me
like a good complement to the upcoming 2.5.x stabilization efforts.

A smallish user base may be a good argument against it.  But I unless
I have miscounted there are quite a few people playing with bootimg,
and kmonte, not to mention the earlier versions of kexec.  

To do things right sys_kexec needs access to call device_shutdown, and
the reboot notifier chain.  The latter is available only as a  static
variable in kernel/sys.c.  And neither of them are exported from the
kernel.  

Keeping sys_kexec out of the kernel seems to encourage half baked,
half debugged implementations that just work for their authors, and
are limited to what it is easy to do as a module.

Putting in the sys_kexec patch in the kernel will certainly discourage
hacks in the code, and encourage those last few strange mysterious
failures to be tracked.  Plus it will put pressure on driver
maintainers to fix various bugs in their code.  And the patch is
not very intrusive at all so I fail to see a downside except bloat.

Eric
