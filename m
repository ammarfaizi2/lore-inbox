Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262084AbVF0Qh0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262084AbVF0Qh0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 12:37:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262093AbVF0PBa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 11:01:30 -0400
Received: from ms005msg.fastwebnet.it ([213.140.2.50]:55975 "EHLO
	ms005msg.fastwebnet.it") by vger.kernel.org with ESMTP
	id S261281AbVF0OFO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 10:05:14 -0400
Date: Mon, 27 Jun 2005 16:04:53 +0200
From: Paolo Ornati <ornati@fastwebnet.it>
To: Andreas Kies <andikies@t-online.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: A Bug in gcc or asm/string.h ?
Message-ID: <20050627160453.6b815e8a@localhost>
In-Reply-To: <200506270105.28782.andikies@t-online.de>
References: <200506270105.28782.andikies@t-online.de>
X-Mailer: Sylpheed-Claws 1.0.4 (GTK+ 1.2.10; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Jun 2005 01:05:28 +0200
Andreas Kies <andikies@t-online.de> wrote:

> Hello,
> 
> When running a kernel module compiled with gcc 3.3.5, I think I've found a
> bug  in either the compiler or the kernel definition of strcmp in 
> asm-i386/string.h . The exact compiler version is :
> 
> Reading specs from /usr/lib/gcc-lib/i586-suse-linux/3.3.5/specs
> Configured with: ../configure --enable-threads=posix --prefix=/usr 
> --with-local-prefix=/usr/local --infodir=/usr/share/info 
> --mandir=/usr/share/man --enable-languages=c,c++,f77,objc,java,ada 
> --disable-checking --libdir=/usr/lib --enable-libgcj --with-slibdir=/lib 
> --with-system-zlib --enable-shared --enable-__cxa_atexit i586-suse-linux
> Thread model: posix
> gcc version 3.3.5 20050117 (prerelease) (SUSE Linux)
> 
> I was able to construct a small pure usermode program.
> If you compile the included test program with optimization level 1 or less
> it  works, if compiled with level 2 it fails. Failing means the strcmp
> result  is != 0 because char ptr has valid contents at the time strcmp is
> expanded. Other platforms besides i386 might be affected, too.
> In the case of a failure you get "Unrecognized" as output on stdout.
> 
> So, here are my questions :
> - Is this a bug in the compiler ?
> In Documentation/Changes version 2.95.x is still recommended, I guess this
> is  outdated.
> - Is it a bug in the definition of strcmp ? Maybe an addition volatile is 
> missing.
> 
> Thanks for reading.
> 
...
> 
> int oem;
> 
> int main(void)
> {
>    char ptr[2];

what happens if you change "char ptr[2]" to "volatile char ptr[2]" ?

--
	Paolo Ornati
	Linux 2.6.12.1 on x86_64
