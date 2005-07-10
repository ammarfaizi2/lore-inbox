Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261897AbVGJLMP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261897AbVGJLMP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Jul 2005 07:12:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261903AbVGJLMP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Jul 2005 07:12:15 -0400
Received: from mail.portrix.net ([212.202.157.208]:34993 "EHLO
	zoidberg.portrix.net") by vger.kernel.org with ESMTP
	id S261897AbVGJLMN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Jul 2005 07:12:13 -0400
Message-ID: <42D10283.6040701@ppp0.net>
Date: Sun, 10 Jul 2005 13:12:03 +0200
From: Jan Dittmer <jdittmer@ppp0.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050331 Thunderbird/1.0.2 Mnenhy/0.6.0.104
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christian Zankel <chris@zankel.net>
CC: czankel@tensilica.com, Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: arch xtensa does not compile
References: <42BD6557.9070102@ppp0.net> <42BD8622.8060506@zankel.net> <42C80B34.80007@ppp0.net> <42D0990D.8030701@zankel.net>
In-Reply-To: <42D0990D.8030701@zankel.net>
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christian Zankel wrote:
> Jan Dittmer wrote:
> 
>>I guess I'm using the wrong binutils version (2.15.94.0.2.2). Which is the
>>recommended gcc/binutils pair which is supposed to compile the kernel?
> 
> 
> Bob Wilson made some changes to binutils last week to address this 
> problem but he only submitted it to the latest binutils version.
> 
> With the latest gcc+binutils toolchain, the kernel compiles for me.
> Note, however, that I just submitted a patch that is not in Linus' tree, 
> yet.
> 
> gcc version 3.4.5 20050707 (prerelease)
> GNU ld version 2.16.91 20050707

Yep, using GNU ld 20050710 and gcc 3.4.4 20050513 I get much further now.

  CC      init/version.o
  LD      init/built-in.o
  LD      .tmp_vmlinux1
arch/xtensa/kernel/built-in.o: In function `__down_interruptible':
: dangerous relocation: l32r: literal target out of range: .sched.literal
arch/xtensa/kernel/built-in.o: In function `__down_interruptible':
: dangerous relocation: l32r: literal target out of range: (.sched.literal+0x4)
arch/xtensa/kernel/built-in.o: In function `__down_interruptible':
: dangerous relocation: l32r: literal target out of range: (.sched.literal+0x8)
arch/xtensa/kernel/built-in.o: In function `__down_interruptible':
: dangerous relocation: l32r: literal target out of range: (.sched.literal+0xc)
arch/xtensa/kernel/built-in.o: In function `__down_interruptible':
: dangerous relocation: l32r: literal target out of range: (.sched.literal+0xc)
arch/xtensa/kernel/built-in.o: In function `__down':
: dangerous relocation: l32r: literal target out of range: .sched.literal
arch/xtensa/kernel/built-in.o: In function `__down':
: dangerous relocation: l32r: literal target out of range: (.sched.literal+0x4)
arch/xtensa/kernel/built-in.o: In function `__down':
: dangerous relocation: l32r: literal target out of range: (.sched.literal+0x8)
arch/xtensa/kernel/built-in.o: In function `__down':
: dangerous relocation: l32r: literal target out of range: (.sched.literal+0xc)
kernel/built-in.o: In function `schedule':

... lots more of these, until ...

rwsem.c:(.sched.text+0x290): dangerous relocation: l32r: literal target out of range: (. sched.literal+0x18)
rwsem.c:(.sched.text+0x297): dangerous relocation: l32r: literal target out of range: (. sched.literal+0x1c)
rwsem.c:(.sched.text+0x29c): dangerous relocation: l32r: literal target out of range: (. sched.literal+0x20)
rwsem.c:(.sched.text+0x2bb): dangerous relocation: l32r: literal target out of range: (. sched.literal+0x24)
make: *** [.tmp_vmlinux1] Error 1

Is the gcc version still too old? Or do I need some special config option?

Reading specs from /usr/cc/xtensa/lib/gcc/xtensa-linux/3.4.4/specs
Configured with: ../configure --prefix=/usr/cc --exec-prefix=/usr/cc/xtensa --target=xtensa-linux --disable-shared --disable-werror --disable-nls
--disable-threads --disable-werror --disable-libmudflap --with-newlib --with-gnu-as --with-gnu-ld --enable-languages=c
Thread model: single
gcc version 3.4.4 20050513 (prerelease)

Thanks,

-- 
Jan
