Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280764AbRKOGaL>; Thu, 15 Nov 2001 01:30:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280757AbRKOGaB>; Thu, 15 Nov 2001 01:30:01 -0500
Received: from chamber.cco.caltech.edu ([131.215.48.55]:17824 "EHLO
	chamber.cco.caltech.edu") by vger.kernel.org with ESMTP
	id <S280766AbRKOG3u>; Thu, 15 Nov 2001 01:29:50 -0500
From: "Alex Adriaanse" <alex_a@caltech.edu>
To: "Ben Collins" <bcollins@debian.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: LFS stopped working
Date: Wed, 14 Nov 2001 22:29:50 -0800
Message-ID: <JIEIIHMANOCFHDAAHBHOCEONCMAA.alex_a@caltech.edu>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Importance: Normal
In-Reply-To: <20011114215815.S329@visi.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I actually re-compiled fileutils 4.1-7 from woody, and it still didn't
change anything.  This is what ./configure said during the recompile by the
way:
checking for special C compiler options needed for large files... no
checking for _FILE_OFFSET_BITS value needed for large files... 64
checking for _LARGE_FILES value needed for large files... no
I'm assuming that this is the way it's supposed to be.

What I don't get though is that dd and other programs USED to work fine -
and I didn't update the kernel, glibc, or these programs (which I suppose
are the only things that could break LFS for utilities such as dd) after
they worked fine.  I even reinstalled my new LFS-supporting glibc-2.1.3 to
be on the safe side in case apt-get "upgraded" them (which it didn't, as I
put it on hold).

Looking at the strace, it looks like these problems are actually coming from
the kernel, since the system call actually seems to be causing the
problem... but of course I could be wrong.

Thanks,

Alex

-----Original Message-----
From: Ben Collins [mailto:bmc@visi.net]
Sent: Wednesday, November 14, 2001 6:58 PM
To: Alex Adriaanse
Cc: linux-kernel@vger.kernel.org
Subject: Re: LFS stopped working


On Wed, Nov 14, 2001 at 02:05:21PM -0800, Alex Adriaanse wrote:
> Hey,
>
> I've been running 2.4.14 for a few days now.  I needed LFS support, so I
> recompiled glibc 2.1.3 with the new 2.4 headers, and after that I could
> create large files (e.g. using dd if=/dev/zero of=test bs=1M count=0
> seek=3000) just fine.
>
> However, as of yesterday, I couldn't create files bigger than 2GB anymore.
> I did not change kernels, nor did I mess with libc or anything else (I did
> some Debian package upgrades/installations/recompiles, but I don't think
> they should affect this) - I'm not quite sure what happened.  Now commands
> such as the dd command I mentioned above will die with the message "File
> size limit exceeded", leaving a 2GB file behind.  Rebooting didn't solve
> anything.  My ulimits seem to be fine (file size = unlimited).

Actually it does affect it. Recompiling glibc isn't the end all to LFS
support. In fact, 2.1.3 has less than adequate support for LFS, IIRC, so
use 2.2.x. For Debian, that just means upgrading to woody(testing).

Your problem extends from programs also needing to be recompiled with
LFS support. This involves some special LFS CFLAGS, and most common
programs detect whether to do this using autoconf (fileutils, gzip and
tar are perfect examples of programs that use this feature).


Ben

--
 .----------=======-=-======-=========-----------=====------------=-=-----.
/                   Ben Collins    --    Debian GNU/Linux                  \
`  bcollins@debian.org  --  bcollins@openldap.org  --  bcollins@linux.com  '
 `---=========------=======-------------=-=-----=-===-======-------=--=---'

