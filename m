Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275156AbRIZMb1>; Wed, 26 Sep 2001 08:31:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275155AbRIZMbR>; Wed, 26 Sep 2001 08:31:17 -0400
Received: from imap.digitalme.com ([193.97.97.75]:33708 "EHLO digitalme.com")
	by vger.kernel.org with ESMTP id <S275156AbRIZMbB>;
	Wed, 26 Sep 2001 08:31:01 -0400
Subject: Re: 2.4.10: Crash on boot with trident driver non-module
From: "Trever L. Adams" <vichu@digitalme.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1001317209.1439.5.camel@aurora>
In-Reply-To: <1001317209.1439.5.camel@aurora>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.14.99+cvs.2001.09.25.08.08 (Preview Release)
Date: 26 Sep 2001 08:32:12 -0400
Message-Id: <1001507536.2606.4.camel@aurora>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Well, I realized that the EIP wasn't typed in correctly.  the l was
supposed to be a 1.  The new output is:

>>???; c01ba1ce <ac97_init_mixer+7e/e0>   <=====
Trace; c01bae74 <pci_announce_device+34/50>
Trace; c01baed2 <pci_register_driver+42/60>
Trace; c0105000 <_stext+0/0>
Trace; c0105049 <init+9/140>
Trace; c0105000 <_stext+0/0>
Trace; c0105536 <kernel_thread+26/30>
Trace; c0105040 <init+0/140>

Hope this helps.  I am having a hard time seeing where the changes in
2.4.9 would cause this NULL dereference in ac97_init_mixer when it is
compiled in but not when it is a module.

Trever

> ac97_codec: AC97 Codec, id 0x0000:0x0000 (unknown)
> Unable to handle kernel Null pointer derefference at virtual addresss 00000000
> *pde = 00000000
> Oops: 0000
> CPU: 0
> EIP: 0010:[<c01balce>]
> EFLAGS: 00010206
> EAX: 00000000   ebx: c7faac80     ecx: 00000802       edx: 00000006
> esi: 00000000   edi: c7faad30     ebp: 00000001       esp: c1219f48
> ds: 0018        es: 0018       ss: 0018
> Process swapper pid 1, stackpage=c1219000
> stack: c7faac80         00000040       c7faad30      00000001
>         c026831b       c7faac80      00000024     00000003
>         c024da40       c1275000      ffffffff     000cc000 (may be 0000cc00)
>         c02687b1       c1275000      0200180d     c027063c
>         c024db00       c1212000      00000000     c01bae74
>         c1212000       c026063c      c1212000     c024db00
> call trace: [<c01bae74>] [<c01baed2>] [<c0105000>] [<c0105049>]
>         [<c0105000>] [<c0105536>] [<c0105040>]
> code: 8b 00 85 c0 74 04 53 ff d0 5a 31 ed 83 3d 40 dc 24 c0 ff ba
> Using defaults from ksymoops -a i386
> Error (Oops_bfd_perror): /tmp/ksymoops.pWqCMC Invalid bfd target
> 
> Trace; c01bae74 <pci_announce_device+34/50>
> Trace; c01baed2 <pci_register_driver+42/60>
> Trace; c0105000 <_stext+0/0>
> Trace; c0105049 <init+9/140>
> Trace; c0105000 <_stext+0/0>
> Trace; c0105536 <kernel_thread+26/30>
> Trace; c0105040 <init+0/140>
> 
> Kernel Panic: Attempted to kill init!
> 
> 984 warnings and 1 error issued.  Results may not be reliable.

