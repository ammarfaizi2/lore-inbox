Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265473AbUAZDZf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jan 2004 22:25:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265479AbUAZDZf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jan 2004 22:25:35 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:1248 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S265473AbUAZDZd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jan 2004 22:25:33 -0500
Date: Mon, 26 Jan 2004 04:25:30 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: andre@linux-ide.org, Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Wilfried Weissmann <wweissmann@gmx.at>,
       Arjan van de Ven <arjanv@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: [2.4 patch] small hptraid.c fix
Message-ID: <20040126032530.GA513@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I got the following warning while compileing 2.4.25-pre7:

<--  snip  -->

...
gcc-2.95 -D__KERNEL__ 
-I/home/bunk/linux/kernel-2.4/linux-2.4.25-pre7-full/include -Wall 
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common 
-fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=k6  -I../ 
-nostdinc -iwithprefix include -DKBUILD_BASENAME=hptraid  -c -o 
hptraid.o hptraid.c
{standard input}: Assembler messages:
{standard input}:92: Warning: setting incorrect section attributes for .text.init
...

<--  snip  -->

The problem is that a struct was marked __init instead of __initdata.

The patch below fixes this issue.

cu
Adrian

--- linux-2.4.25-pre7-full/drivers/ide/raid/hptraid.c.old	2004-01-26 04:19:37.000000000 +0100
+++ linux-2.4.25-pre7-full/drivers/ide/raid/hptraid.c	2004-01-26 04:19:53.000000000 +0100
@@ -146,7 +146,7 @@
 	make_request:		hptraid01_make_request
 };
 
-static __init struct {
+static __initdata struct {
 	struct raid_device_operations *op;
 	u_int8_t type;
 	char label[8];
