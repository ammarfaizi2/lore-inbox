Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282027AbRKVDEm>; Wed, 21 Nov 2001 22:04:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282026AbRKVDEd>; Wed, 21 Nov 2001 22:04:33 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:59144 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S282027AbRKVDEX>;
	Wed, 21 Nov 2001 22:04:23 -0500
Date: Thu, 22 Nov 2001 01:03:32 -0200
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Erik Jansson <erja9907@student.uu.se>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Compile problem in vmalloc.h
Message-ID: <20011122010332.G2216@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Erik Jansson <erja9907@student.uu.se>, linux-kernel@vger.kernel.org
In-Reply-To: <3BFA9F2D.98FB7F72@student.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3BFA9F2D.98FB7F72@student.uu.se>
User-Agent: Mutt/1.3.23i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Nov 20, 2001 at 07:21:33PM +0100, Erik Jansson escreveu:
> Hi all!
> 
> I've looked and asked around for a while about this, but I can't seem to
> find the answer. Maybe you know what's up.
> 
> I'm compiling a driver that's not part of the kernel tree (but it's GPL
> anyway). It compiles nicely against the 2.4.8 kernel tree, but fails
> with both 2.4.10 and 2.4.14. Those are the only ones that I've tried
> though.
> 
> I'm using clean sources (nothing patched, make mrproper; make clean;
> make config; make bzImage etc).
> 
> I'm using gcc version 2.95.4 20010902 (Debian prerelease).
> 
> The error I get looks like this:
> 
> gcc -c -o ./src/proc.o ./src/proc.c -D__KERNEL__ -DMODULE -O2 -Wall
> -Wstrict-pro
> totypes -Wpointer-arith -I /usr/src/linux/include  -DCAN_DEBUG
> In file included from /usr/src/linux/include/asm/io.h:46,
>                  from src/../include/main.h:11,
>                  from ./src/proc.c:25:
> /usr/src/linux/include/linux/vmalloc.h: In function `vmalloc':
> /usr/src/linux/include/linux/vmalloc.h:35: `boot_cpu_data_Rsmp_0657d037'

Try adding this:

#include <linux/module.h>

to your driver, of course before the '#include <linux/vmalloc.h>' line 8)

- Arnaldo
