Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261449AbSKDJHq>; Mon, 4 Nov 2002 04:07:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261450AbSKDJHq>; Mon, 4 Nov 2002 04:07:46 -0500
Received: from bilbo.math.uni-mannheim.de ([134.155.88.153]:36038 "HELO
	bilbo.math.uni-mannheim.de") by vger.kernel.org with SMTP
	id <S261449AbSKDJHp>; Mon, 4 Nov 2002 04:07:45 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Rolf Eike Beer <eike@bilbo.math.uni-mannheim.de>
To: linux-kernel@vger.kernel.org
Subject: Re: build error in 2.5.45
Date: Mon, 4 Nov 2002 10:16:07 +0100
User-Agent: KMail/1.4.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200211041016.07936@bilbo.math.uni-mannheim.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Von Hiro Yoshioka:

>   ld -m elf_i386 -e stext -T arch/i386/vmlinux.lds.s
>   arch/i386/kernel/head.o arch/i386/kernel/init_task.o  init/built-in.o
>   --start-group  arch/i386/kernel/built-in.o  arch/i386/mm/built-in.o 
>   arch/i386/mach-generic/built-in.o  kernel/built-in.o  mm/built-in.o 
>   fs/built-in.o  ipc/built-in.o  security/built-in.o  crypto/built-in.o
>    lib/lib.a  arch/i386/lib/lib.a  drivers/built-in.o  sound/built-in.o
>    arch/i386/pci/built-in.o  arch/i386/oprofile/built-in.o 
>   net/built-in.o --end-group  -o .tmp_vmlinux1
> net/built-in.o: In function `p8022_request':
> net/built-in.o(.text+0xf4b9): undefined reference to
> `llc_build_and_send_ui_pkt' net/built-in.o: In function
> `register_8022_client': net/built-in.o(.text+0xf502): undefined
> reference to `llc_sap_open' net/built-in.o: In function
> `unregister_8022_client': net/built-in.o(.text+0xf52e): undefined
> reference to `llc_sap_close' net/built-in.o: In function
> `snap_request': net/built-in.o(.text+0xf663): undefined reference to
> `llc_build_and_send_ui_pkt' net/built-in.o: In function `snap_init':
> net/built-in.o(.init.text+0x613): undefined reference to `llc_sap_open'
> make: *** [.tmp_vmlinux1] Error 1

I had the same problem here. This one helped:

326c326,330
< # CONFIG_TR is not set
---
> CONFIG_TR=y
> # CONFIG_IBMTR is not set
> CONFIG_TMS380TR=m
> CONFIG_TMSISA=m
> # CONFIG_SMCTR is not set

Eike
