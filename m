Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263461AbTC2U7v>; Sat, 29 Mar 2003 15:59:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263462AbTC2U7v>; Sat, 29 Mar 2003 15:59:51 -0500
Received: from [12.47.58.57] ([12.47.58.57]:43988 "EHLO pao-ex01.pao.digeo.com")
	by vger.kernel.org with ESMTP id <S263461AbTC2U7u>;
	Sat, 29 Mar 2003 15:59:50 -0500
Date: Sat, 29 Mar 2003 13:12:18 -0800
From: Andrew Morton <akpm@digeo.com>
To: "J.A. Magallon" <jamagallon@able.es>
Cc: jamagallon@able.es, linux-kernel@vger.kernel.org, marcelo@conectiva.com.br,
       vortex@scyld.com
Subject: Re: Bad PCI IDs-Names table in 3c59x.c
Message-Id: <20030329131218.04a8cf1e.akpm@digeo.com>
In-Reply-To: <20030329141245.GA2560@werewolf.able.es>
References: <20030329013022.GA2711@werewolf.able.es>
	<20030328183836.36ccd14b.akpm@digeo.com>
	<20030329141245.GA2560@werewolf.able.es>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 29 Mar 2003 21:11:01.0834 (UTC) FILETIME=[B3B3E2A0:01C2F637]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"J.A. Magallon" <jamagallon@able.es> wrote:
>
> 
> pci.ids has this:
> 
> 10b7  3Com Corporation
>     ...
>     9805  3c980-TX 10/100baseTX NIC [Python-T]
>         10b7 1201  3c982-TXM 10/100baseTX Dual Port A [Hydra]
>         10b7 1202  3c982-TXM 10/100baseTX Dual Port B [Hydra]
>         10b7 9805  3c980 10/100baseTX NIC [Python-T]

That's hardly authoritative.

> and my card gives:
> 
> (lspci -n)
> 00:12.0 Class 0200: 10b7:9805 (rev 78)
> (lspci -v)
> 00:12.0 Ethernet controller: 3Com Corporation 3c980-TX 10/100baseTX NIC [Python-T] (rev 78)
>         Subsystem: 3Com Corporation: Unknown device 1000

Nor is that.

> Donald's driver has:
>     { 0x10B7, 0x9800, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CH_3C980 },
>     { 0x10B7, 0x9805, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CH_3C9805 },
> ...
>     {"3c980 Cyclone",
>      PCI_USES_IO|PCI_USES_MASTER, IS_CYCLONE|HAS_HWCKSM, 128, },
>     {"3c982 Dual Port Server Cyclone",
>      PCI_USES_IO|PCI_USES_MASTER, IS_CYCLONE|HAS_HWCKSM, 128, },

Nope, Donald's latest driver has

    {"3c982 Server Tornado",{ 0x980510B7, 0xffffffff },
     PCI_IOTYPE, CYCLONE_SIZE, FEATURE_TORNADO, },

(Note: no HAS_NWAY either)

But if you have a 10b7/9805 with a "3c980 Python-T" sticker on it I guess
that will do.

Not sure about NWAY though.

hm, the 2.5 kernel has 

    {"3c980C Python-T",
     PCI_USES_IO|PCI_USES_MASTER, IS_CYCLONE|HAS_NWAY|HAS_HWCKSM, 128, },

for 10b7/9805, which looks much more healthy.

