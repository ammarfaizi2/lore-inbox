Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261196AbTHTBnU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 21:43:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261357AbTHTBnU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 21:43:20 -0400
Received: from codepoet.org ([166.70.99.138]:33684 "EHLO winder.codepoet.org")
	by vger.kernel.org with ESMTP id S261196AbTHTBnS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 21:43:18 -0400
Date: Tue, 19 Aug 2003 19:42:29 -0600
From: Erik Andersen <andersen@codepoet.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Rob Landley <rob@landley.net>,
       "Ihar 'Philips' Filipau" <filia@softhome.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Re: [PATCH] scsi.h uses "u8" which isn't defined.
Message-ID: <20030820014228.GA7105@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	Jeff Garzik <jgarzik@pobox.com>, Rob Landley <rob@landley.net>,
	Ihar 'Philips' Filipau <filia@softhome.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <lRjc.6o4.3@gated-at.bofh.it> <3F4120DD.3030108@softhome.net> <20030818190421.GN24693@gtf.org> <200308190832.24744.rob@landley.net> <20030819172651.GA15781@gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030819172651.GA15781@gtf.org>
User-Agent: Mutt/1.3.28i
X-Operating-System: Linux 2.4.19-rmk7, Rebel-NetWinder(Intel StrongARM 110 rev 3), 185.95 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue Aug 19, 2003 at 01:26:51PM -0400, Jeff Garzik wrote:
> > Or used directly by uclibc (and linux from scratch) to build the library 
> > against.
> 
> Yes, this is incorrect.
> 
> Kernel developers have been telling people for years, "do not directly
> include kernel headers."

<Kernel developer hat on>

Yes.  As a kernel developer I regularly tell people to make their
own private copy of the bits of kernel headers they need, to
prevent breakage when random bits in the kernel headers change.
I can't begin to count the number of applications I have fixed by
removing some kernel headers and then copying in the definition
of some random struct, adding a few ioctl defines, and then
changing everything to use types from stdint.h rather than the
kernel's internal typing.

I have also long maintained that this is incredibly stupid....
When I wrote the cdrom.h header file, for example, I wrote it to
define the interface which user space would use when talking to
the kernel.  I _designed_ that header file to be directly used by
user space, since that is the one and only spot that contains all
the relevant knowledge needed to interact with the kernel's cdrom
driver.  I mean, how else would user space know what to do?  It
is silly there needs to be N copies of the header file defining
this interface for N applications...  The fact the kernel has
mingled its internal interfaces and its external interfaces is a
serious and ugly blemish.


<uClibc maintainer hat on>

Not including kernel headers in user space is of course perfect
advice for your average piece of user space.  This is _not_
currently a reasonable request for a C library because the kernel
folk have not yet provided a reasonable alternative.  Looked at
glibc recently?  Just like uClibc, it determines the ABI of the
kernel against which it is compiled (in the case of glibc, via
the --with-headers configure option).  Distros such as RedHat and
Debian provide kernel-headers packages against which C libraries
are compiled.  Guess what those contain?  Kernel headers.  Kernel
headers which are used by user space because the kernel folk have
been too damn lazy to provide something better.

That said, for uClibc I have begun the process of eliminating the
dependence on kernel headers for random structs.  I now have arch
specific headers such as "kernel_stat.h", mainly since the kernel
headers are too inconsistant between architectures to be even
remotely usable.  But as others have noted, extracting and
sanitizing the entire kernel ABI is a huge amount of work and I
am nowhere close to done.

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
