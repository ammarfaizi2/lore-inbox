Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315762AbSETFLV>; Mon, 20 May 2002 01:11:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315783AbSETFLU>; Mon, 20 May 2002 01:11:20 -0400
Received: from zok.SGI.COM ([204.94.215.101]:60087 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S315762AbSETFLT>;
	Mon, 20 May 2002 01:11:19 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Mike Fedyk <mfedyk@matchmail.com>
Cc: Wayne.Brown@altec.com, linux-kernel@vger.kernel.org
Subject: Re: kbuild 2.5 is ready for inclusion in the 2.5 kernel - take 3 
In-Reply-To: Your message of "Sun, 19 May 2002 21:31:01 MST."
             <20020520043101.GA502@matchmail.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 20 May 2002 15:11:09 +1000
Message-ID: <3487.1021871469@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 19 May 2002 21:31:01 -0700, 
Mike Fedyk <mfedyk@matchmail.com> wrote:
>Kieth, can you confirm that all of the old kbuild-2.4 commands have been
>wrapped in kbuild-2.5 commands?

make *config	- same
make dep	- kbuild 2.5 says 'nothing to do'.
make [b]zImage	- Replaced by 'installable', with the kernel type
		  specified in .config.
make modules	- Replaced by 'installable'.
make bzlilo	- All install targets have been subsumed by 'install'.

'make installable' is the default target if nothing else is specified.
kbuild 2.5 moves the type of kernel to build into .config, it is no
longer specified on the command line.  This makes it even easier to
build from a previous kernel, copy .config and

 make -j defconfig installable && sudo make -j install

There is no need for separate passes for kernel and modules.  Building
kernel and modules separately has always been a potential source of
human error, kbuild 2.5 delivers a complete and accurate set of
installable files.  Because kbuild 2.5 only rebuilds what is necessary,
collapsing the two passes into one actually saves build time.

'make install' uses .config entries to determine what to install, where
to install it, whether or not you want to install System.map or .config
and where they are installed.  Again, this makes it much easier to
reuse a previous config.  It also makes life easier for people doing
cross compiles, set one config variable to a directory and everything
is installed relative to that directory, instead of relative to /.

Another config entry specifies an install script to be run after
install.  You are no longer restricted to a hard coded script name.
kbuild 2.5 deliberately does not include any interfaces to lilo, grub,
syslinux, etc., nor to apt, rpm, tarballs etc., they are all handled by
the post-install script.  Sample scripts are provided, if you don't
like them you can modify to suit or write your own post-install
scripts.  This is more flexible than "everything goes through
/sbin/install".

