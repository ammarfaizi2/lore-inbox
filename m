Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261162AbUJ3NVG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261162AbUJ3NVG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Oct 2004 09:21:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261164AbUJ3NVG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Oct 2004 09:21:06 -0400
Received: from r3az252.chello.upc.cz ([213.220.243.252]:27266 "EHLO
	aquarius.doma") by vger.kernel.org with ESMTP id S261162AbUJ3NVB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Oct 2004 09:21:01 -0400
Message-ID: <41839535.1080506@ribosome.natur.cuni.cz>
Date: Sat, 30 Oct 2004 15:20:53 +0200
From: =?ISO-8859-2?Q?Martin_MOKREJ=A9?= <mmokrejs@ribosome.natur.cuni.cz>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8a5) Gecko/20041030
X-Accept-Language: cs, en, en-us
MIME-Version: 1.0
To: =?ISO-8859-2?Q?Martin_MOKREJ=A9?= <mmokrejs@ribosome.natur.cuni.cz>
CC: linux-kernel@vger.kernel.org, marcelo.tosatti@cyclades.com
Subject: Re: cannot compile 2.4.28-rc1-bk3
References: <41838899.6070302@ribosome.natur.cuni.cz>
In-Reply-To: <41838899.6070302@ribosome.natur.cuni.cz>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Another one:

gcc -D__KERNEL__ -I/usr/src/linux-2.4.28-rc1-bk3/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686    -nostdinc -iwithprefix include -DKBUILD_BASENAME=arp  -c -o arp.o arp.c
arp.c:1342: error: `THIS_MODULE' undeclared here (not in a function)
arp.c:1342: error: initializer element is not constant
arp.c:1342: error: (near initialization for `arp_seq_fops.owner')
make[3]: *** [arp.o] Error 1
make[3]: Leaving directory `/usr/src/linux-2.4.28-rc1-bk3/net/ipv4'



That can be fixed with:

--- net/ipv4/arp.c.orig 2004-10-30 15:18:41.000000000 +0200
+++ net/ipv4/arp.c      2004-10-30 15:18:44.000000000 +0200
@@ -76,6 +76,7 @@
 #include <linux/types.h>
 #include <linux/string.h>
 #include <linux/kernel.h>
+#include <linux/module.h>
 #include <linux/sched.h>
 #include <linux/config.h>
 #include <linux/socket.h>
