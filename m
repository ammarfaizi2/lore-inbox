Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280588AbRLaHFj>; Mon, 31 Dec 2001 02:05:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285096AbRLaHF3>; Mon, 31 Dec 2001 02:05:29 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:15373 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S280588AbRLaHFM>;
	Mon, 31 Dec 2001 02:05:12 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Albert Cranford <ac9410@bellsouth.net>
Cc: kbuild-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: Announce: Kernel Build for 2.5, Release 1.12 is available 
In-Reply-To: Your message of "Mon, 31 Dec 2001 00:54:48 CDT."
             <3C2FFDA8.81073B84@bellsouth.net> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 31 Dec 2001 18:04:56 +1100
Message-ID: <30269.1009782296@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 31 Dec 2001 00:54:48 -0500, 
Albert Cranford <ac9410@bellsouth.net> wrote:
>Is it just me or did 1.12 break i386 in 2.4.18-pre1?
>I applied linux-2.4.18-pre1 then:
>kbuild-2.5-2.4.16-3                
>kbuild-2.5-2.4.17-1
>kbuild-2.5-2.4.18-pre1-1
>cp /tmp/saved.config /usr/src/linux/.config
>
>I noticed there is no link include/asm to include/asm-i386
>
>Here is my output:
>home1:~/linux# ll .config*
>  28 -rw-r--r--   1 root     root        25907 Dec 31 00:04 .config
>home1:~/linux# make -f Makefile-2.5 oldconfig
>In file included from /usr/include/bits/errno.h:25,
>                 from /usr/include/errno.h:36,
>                 from /usr/src/linux/scripts/pp_makefile.h:11,
>                 from /usr/src/linux/scripts/pp_filetree.c:11:
>/usr/include/linux/errno.h:4: asm/errno.h: No such file or directory

You have a broken glibc, /usr/include/linux is a symlink to
/usr/src/linux.  Linus has said repeatedly that glibc must not do that,
it gives different results for userspace code depending on which
version of the kernel source you are working on.  The fact that kbuild
2.5 highlights the broken versions of glibc is a bonus.

Newer versions of glibc have local copies of /usr/include/linux which
never change, instead of using a symlink to a random kernel source and
blindly hoping that /usr/src/linux contains something useful.  If you
cannot upgrade glibc, find the version of the kernel that glibc was
compiled against, probably the first kernel your distribution shipped
with.  Install the headers from that kernel as /usr/src/linux to keep
glibc happy.  NEVER change /usr/src/linux again, build your kernels
under a different directory.

