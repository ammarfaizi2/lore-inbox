Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286322AbSCWVM2>; Sat, 23 Mar 2002 16:12:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291102AbSCWVMT>; Sat, 23 Mar 2002 16:12:19 -0500
Received: from mail.cogenit.fr ([195.68.53.173]:38086 "EHLO cogenit.fr")
	by vger.kernel.org with ESMTP id <S286322AbSCWVMI>;
	Sat, 23 Mar 2002 16:12:08 -0500
Date: Sat, 23 Mar 2002 22:10:58 +0100
From: Francois Romieu <romieu@cogenit.fr>
To: Maksim Krasnyanskiy <maxk@qualcomm.com>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
        marcelo Tosatti <marcelo@conectiva.com.br>, Alan@lxorguk.ukuu.org.uk
Subject: Re: [PATCH] Updated ATM patch for 2.4.19-pre4
Message-ID: <20020323221058.B15111@fafner.intra.cogenit.fr>
In-Reply-To: <5.1.0.14.2.20020322170653.0337b970@mail1.qualcomm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-Organisation: Marie's fan club - II
X-Warning: scheduled downtime from 22PM to 2AM for 22/15 recovery
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Maksim Krasnyanskiy <maxk@qualcomm.com> :
[...]
> I updated ATM patch for 2.4.19-pre4. It includes couple of fixes that I 
> missed in my first patch
> and includes ATM Ethernet bridging support (RFC2684) implemented by Marcell 
> GAL.
> It is rather big for email. Here is the URL:
>          http://bluez.sourceforge.net/patches/atm.patch-2.4.19-pre4.gz

1 - It won't compile with CONFIG_ATM_BR2684_IPFILTER=y (see error message 
below). Suggested fix:
ed net/atm/br2684.c <<EOF
17a
#include <linux/ip.h>
.
wq
EOF

-> Error message:
make[2]: Entering directory `/tmp/romieu/kernel/linux-2.4.19-pre4/net/atm'
kgcc -D__KERNEL__ -I/tmp/romieu/kernel/linux-2.4.19-pre4/include -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing
-fno-common -pipe  -march=i686 -DMODULE  -DKBUILD_BASENAME=br2684  -c -o
br2684.o br2684.c
br2684.c: In function `packet_fails_filter':
br2684.c:378: dereferencing pointer to incomplete type
make[2]: *** [br2684.o] Error 1
make[2]: Leaving directory `/tmp/romieu/kernel/linux-2.4.19-pre4/net/atm'
make[1]: *** [_modsubdir_atm] Error 2
make[1]: Leaving directory `/tmp/romieu/kernel/linux-2.4.19-pre4/net'
make: *** [_mod_net] Error 2

2 - As the patch does many things, splitting it in parts would be nice imho.

3 - I have on my TODO a 'please ifconfig down before killing br2684ctl' BUG
that Marcell Gal told me a few months ago (*spleen*). Did someone take care
of it ?

-- 
Ueimor
