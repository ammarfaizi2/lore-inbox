Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263692AbTEMHsn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 03:48:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263282AbTEMHsn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 03:48:43 -0400
Received: from landfill.ihatent.com ([217.13.24.22]:51584 "EHLO
	mail.ihatent.com") by vger.kernel.org with ESMTP id S263692AbTEMHsO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 03:48:14 -0400
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.5.69-mm4
References: <20030512225504.4baca409.akpm@digeo.com>
	<87vfwf8h2n.fsf@lapper.ihatent.com>
	<20030513001135.2395860a.akpm@digeo.com>
From: Alexander Hoogerhuis <alexh@ihatent.com>
Date: 13 May 2003 10:00:58 +0200
In-Reply-To: <20030513001135.2395860a.akpm@digeo.com>
Message-ID: <87n0hr8edh.fsf@lapper.ihatent.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Andrew Morton <akpm@digeo.com> writes:

> Alexander Hoogerhuis <alexh@ihatent.com> wrote:
> >
> > net/core/dev.c:1496: conflicting types for `handle_bridge'
> >  net/core/dev.c:1468: previous declaration of `handle_bridge'
> 
> argh, sorry, stupid.
> 
> diff -puN net/core/dev.c~handle_bridge-fix net/core/dev.c
> --- 25/net/core/dev.c~handle_bridge-fix	2003-05-13 00:10:47.000000000 -0700
> +++ 25-akpm/net/core/dev.c	2003-05-13 00:10:57.000000000 -0700
> @@ -1491,7 +1491,7 @@ static inline void handle_diverter(struc
>  #endif
>  }
>  
> -static inline int handle_bridge(struct sk_buff *skb,
> +static inline int __handle_bridge(struct sk_buff *skb,
>  			struct packet_type **pt_prev, int *ret)
>  {
>  #if defined(CONFIG_BRIDGE) || defined(CONFIG_BRIDGE_MODULE)
> @@ -1548,7 +1548,7 @@ int netif_receive_skb(struct sk_buff *sk
>  
>  	handle_diverter(skb);
>  
> -	if (handle_bridge(skb, &pt_prev, &ret))
> +	if (__handle_bridge(skb, &pt_prev, &ret))
>  		goto out;
>  
>  	list_for_each_entry_rcu(ptype, &ptype_base[ntohs(type)&15], list) {
> 

And this one :)

        ld -m elf_i386  -T arch/i386/vmlinux.lds.s arch/i386/kernel/head.o arch/i386/kernel/init_task.o   init/built-in.o --start-group  usr/built-in.o  arch/i386/kernel/built-in.o  arch/i386/mm/built-in.o  arch/i386/mach-default/built-in.o  kernel/built-in.o  mm/built-in.o  fs/built-in.o  ipc/built-in.o  security/built-in.o  crypto/built-in.o  lib/lib.a  arch/i386/lib/lib.a  drivers/built-in.o  sound/built-in.o  arch/i386/pci/built-in.o  net/built-in.o --end-group  -o .tmp_vmlinux1
kernel/built-in.o(.text+0x1005): In function `schedule':
: undefined reference to `active_load_balance'
make: *** [.tmp_vmlinux1] Error 1
alexh@lapper ~/src/linux/linux-2.5.69-mm4 $

mvh,
A
- -- 
Alexander Hoogerhuis                               | alexh@ihatent.com
CCNP - CCDP - MCNE - CCSE                          | +47 908 21 485
"You have zero privacy anyway. Get over it."  --Scott McNealy
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Processed by Mailcrypt 3.5.8 <http://mailcrypt.sourceforge.net/>

iD8DBQE+wKY3CQ1pa+gRoggRAmd6AKDCJGGIiqot4yzmTlVdWpvQR1JagwCaAsY7
UdsL8kbCLzCEKTrsL/ijsoA=
=Uhvc
-----END PGP SIGNATURE-----
