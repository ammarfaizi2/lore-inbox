Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315263AbSELAbR>; Sat, 11 May 2002 20:31:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315264AbSELAbR>; Sat, 11 May 2002 20:31:17 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:41739 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S315263AbSELAbQ>;
	Sat, 11 May 2002 20:31:16 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Russell King <rmk@arm.linux.org.uk>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: 64-bit jiffies, a better solution take 2 
In-Reply-To: Your message of "Sun, 12 May 2002 01:01:21 +0100."
             <20020512010121.A23946@flint.arm.linux.org.uk> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 12 May 2002 10:31:06 +1000
Message-ID: <16925.1021163466@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 12 May 2002 01:01:21 +0100, 
Russell King <rmk@arm.linux.org.uk> wrote:
>On Sun, May 12, 2002 at 09:38:48AM +1000, Keith Owens wrote:
>> Any reason that you are using sed and not cpp like the other
>> architectures?
>
>Only historical and a hatred of cpp's "# line file" stuff, and the fact
>that ARM needs to use sed elsewhere in the build to get around broken
>GCC %c0 stuff.

>From arch/$(ARCH)/Makefile.in

  extra_aflags(vmlinux.lds.i -U$(ARCH) -C -P)

-P suppresses the '# line file' stuff.

>I think we could actually get rid of the preprocessing of the linker
>files - see ld's defsym argument.

Some architectures need #ifdef in their script, they control more than
just values (sh, ia64).  I like standard code, so use cpp for everything.

>> In kbuild 2.5 I am trying to standardize on
>> arch/$(ARCH)/vmlinux.lds.S which is always pre-processed by cpp to
>> vmlinux.lds.i which is used to link vmlinux.
>
>Eww, so I can't use "find . -name '*.[cS]'" to find all the C source and
>assembly source with kbuild 2.5 because we've got pollution of the .S
>extension?

Don't blame kbuild 2.5 for that.

  arch/ia64/vmlinux.lds.S
  arch/mips64/ld.script.elf32.S
  arch/sh/vmlinux.lds.S

I am just following the most common existing convention, trying to
minimize changes to existing files for kbuild 2.5.

>I'm not a fan of dont-diff stuff myself - I'd rather ensure a clean
>source tree and then diff rather than diffing a dirty built tree.

Then you must like separate source and object trees for kbuild 2.5 :)

>dont-diff stuff needs to be maintained and extended as stuff changes
>in the kernel tree, and lets face it, no amount of extension pollution
>will prevent it from being updated over time.

True, but we can try to minimize the special cases.

