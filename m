Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129529AbRBCCuq>; Fri, 2 Feb 2001 21:50:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129920AbRBCCug>; Fri, 2 Feb 2001 21:50:36 -0500
Received: from [200.222.195.185] ([200.222.195.185]:38788 "EHLO
	pervalidus.dyndns.org") by vger.kernel.org with ESMTP
	id <S129529AbRBCCuc>; Fri, 2 Feb 2001 21:50:32 -0500
Date: Sat, 3 Feb 2001 00:49:26 -0200
From: Frédéric L. W. Meunier <0@pervalidus.net>
To: Keith Owens <kaos@ocs.com.au>, Jocelyn Mayer <jocelyn.mayer@netgem.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Fix for include/linux/fs.h in 2.4.0 kernels
Message-ID: <20010203004926.M160@pervalidus.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.14i
X-Mailer: Mutt/1.3.14i - Linux 2.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith Owens wrote:

> Rule 2. Any glibc that has a symlink from
> /usr/include/{linux,asm} to /usr/src/linux/include/{linux,asm}
> is wrong.

Such symlinks are created by the user.

> Relying on /usr/include/{linux,asm} always pointing at the
> current kernel source is broken as designed.

>From glibc 2.2.1 FAQ:

2.17.   I have /usr/include/net and /usr/include/scsi as symlinks
	into my Linux source tree.  Is that wrong?

{PB} This was necessary for libc5, but is not correct when
using glibc. Including the kernel header files directly in user
programs usually does not work (see question 3.5). glibc
provides its own <net/*> and <scsi/*> header files to replace
them, and you may have to remove any symlink that you have in
place before you install glibc. However, /usr/include/asm and
/usr/include/linux should remain as they were.

Keith, are you saying that glibc is wrong?

3.5.    On Linux I've got problems with the declarations in Linux
	kernel headers.

{UD,AJ} On Linux, the use of kernel headers is reduced to the
minimum. This gives Linus the ability to change the headers
more freely. Also, user programs are now insulated from changes
in the size of kernel data structures.

For example, the sigset_t type is 32 or 64 bits wide in the
kernel. In glibc it is 1024 bits wide. This guarantees that
when the kernel gets a bigger sigset_t (for POSIX.1e realtime
support, say) user programs will not have to be recompiled.
Consult the header files for more information about the
changes.

Therefore you shouldn't include Linux kernel header files
directly if glibc has defined a replacement. Otherwise you
might get undefined results because of type conflicts.

> /usr/include/{linux,asm} must be real directories that are
> shipped as part of glibc, not symlinks to some random version
> of the kernel. Fix /usr/include.

But make install didn't create them. I built 2.2 and 2.2.1.

-- 
Frédéric L. W. Meunier - http://www.pervalidus.net/
0@pervalidus.{net, {dyndns.}org} Tel: 55-21-717-2399 (Niterói-RJ BR)
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
