Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318229AbSHIKYp>; Fri, 9 Aug 2002 06:24:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318230AbSHIKYp>; Fri, 9 Aug 2002 06:24:45 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:36856 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S318229AbSHIKYo>; Fri, 9 Aug 2002 06:24:44 -0400
Date: Fri, 9 Aug 2002 12:28:24 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Marc-Christian Petersen <mcp@linux-systeme.de>
cc: linux-kernel@vger.kernel.org, Marcelo Tosatti <marcelo@conectiva.com.br>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [BUG] 2.4.19-rc5 with ipchains module
In-Reply-To: <200208021755.11174.mcp@linux-systeme.de>
Message-ID: <Pine.NEB.4.44.0208091224430.26570-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 Aug 2002, Marc-Christian Petersen wrote:

> Hi there,
>
> ipchains isn't able to be loaded as a module, even there is no iptables
> loaded. .config is attached.
>
> root@codeman:[/] > modprobe ipchains
> Warning: loading /lib/modules/2.4.19-rc5/kernel/net/ipv4/netfilter/ipchains.o
> will taint the kernel: non-GPL license - BSD without advertisement clause
>...

The following trivial patch taken from 2.4.20-pre1-ac1 fixes it:

--- linux.20pre1/net/ipv4/netfilter/ipchains_core.c	2002-08-06 15:40:34.000000000 +0100
+++ linux.20pre1-ac1/net/ipv4/netfilter/ipchains_core.c	2002-08-06 15:41:56.000000000 +0100
@@ -1779,4 +1779,4 @@
 #endif
 	return ret;
 }
-MODULE_LICENSE("BSD without advertisement clause");
+MODULE_LICENSE("Dual BSD/GPL");



Marcelo:
Please include this patch in 2.4.20.


cu
Adrian

-- 

You only think this is a free country. Like the US the UK spends a lot of
time explaining its a free country because its a police state.
								Alan Cox



