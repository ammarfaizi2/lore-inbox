Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314975AbSECSLu>; Fri, 3 May 2002 14:11:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314981AbSECSLt>; Fri, 3 May 2002 14:11:49 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.176.19]:51938 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S314975AbSECSLm>; Fri, 3 May 2002 14:11:42 -0400
Date: Fri, 3 May 2002 20:07:16 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.19-pre8
In-Reply-To: <E173dLJ-0006L4-00@the-village.bc.nu>
Message-ID: <Pine.NEB.4.44.0205032000270.2605-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 May 2002, Alan Cox wrote:

> > 8253xdbg.o 8253xplx.o 8253xtty.o 8253xchr.o 8253xint.o amcc5920.o
> > 8253xmcs.o 8253xutl.o
> > make[4]: *** No rule to make target `8253xcfg.c', needed by `8253xcfg'.
> > Stop.
> > make[4]: Leaving directory
> > `/home/bunk/linux/kernel-2.4/linux/drivers/net/wan/8253x'
>
> Oops. I probably forgot to send Marcelo the makefile tweak
>
> > It seems 8253xcfg.c was accidentially not included.
>
> Remove it from the makefile and it should all be happy

Until the next compile error...

<--  snip  -->

...
ld -m elf_i386  -r -o ASLX.o 8253xini.o 8253xnet.o 8253xsyn.o crc32.o
8253xdbg.o 8253xplx.o 8253xtty.o 8253xchr.o 8253xint.o amcc5920.o
8253xmcs.o 8253xutl.o
gcc  -o 8253xmac -I. -U__KERNEL__ 8253xmac.c
8253xmac.c: In function `main':
8253xmac.c:29: `PSEUDOMAC' undeclared (first use in this function)
8253xmac.c:29: (Each undeclared identifier is reported only once
8253xmac.c:29: for each function it appears in.)
8253xmac.c:29: parse error before `pmac'
8253xmac.c:52: `pmac' undeclared (first use in this function)
8253xmac.c:54: `SAB8253XGETMAC' undeclared (first use in this function)
8253xmac.c:167: `SAB8253XSETMAC' undeclared (first use in this function)
make[4]: *** [8253xmac] Error 1
make[4]: Leaving directory
`/home/bunk/linux/kernel-2.4/linux/drivers/net/wan/8253x'

<--  snip  -->


Both the -pre7-ac4 and the -pre8 patches contain a
drivers/net/wan/8253x/readme.txt that says:


<--  snip  -->

...
+2) The following network ioctl have been removed
+
+#define SAB8253XSETMAC         (SIOCDEVPRIVATE + 5 + 2)
+#define SAB8253XGETMAC         (SIOCDEVPRIVATE + 5 + 3)
+
+along with the PSEUDOMAC structure and references to this structure.
+
+The following standard ioctls provide the same functionality.
+
+#define        SIOCSIFHWADDR   0x8924          /* set hardware address
*/
+#define SIOCGIFHWADDR  0x8927          /* Get hardware address         */
+
+The 8253xmac tool has been removed.  To start the ASLX sab8253x
+network interface, you should use a command like the following with
+the substitutions appropriate to your environment.
...

<--  snip  -->


But both the -pre7-ac4 and the -pre8 patches add a 8253xmac.c and the
Makefile tries to compile it...


> Alan

cu
Adrian

-- 

You only think this is a free country. Like the US the UK spends a lot of
time explaining its a free country because its a police state.
								Alan Cox

