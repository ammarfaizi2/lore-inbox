Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261438AbTD2QTM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Apr 2003 12:19:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262034AbTD2QTM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Apr 2003 12:19:12 -0400
Received: from air-2.osdl.org ([65.172.181.6]:39100 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261438AbTD2QTL convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Apr 2003 12:19:11 -0400
Date: Tue, 29 Apr 2003 09:28:57 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Christian =?ISO-8859-1?Q?Borntr=E4ger?= <linux@borntraeger.net>
Cc: acme@conectiva.com.br, linux-kernel@vger.kernel.org
Subject: Re: [BUG 2.5.67 (and probably earlier)] /proc/dev/net doesnt show
 all net devices
Message-Id: <20030429092857.4ebffcc9.rddunlap@osdl.org>
In-Reply-To: <200304291434.18272.linux@borntraeger.net>
References: <200304291434.18272.linux@borntraeger.net>
Organization: OSDL
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i586-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Apr 2003 14:34:18 +0200 Christian Bornträger <linux@borntraeger.net> wrote:

| Summary: /proc/net/devices doesnt show all devices using cat. With dd all are 
| available.
| 
| I tested a kernels prior to 
| http://linus.bkbits.net:8080/linux-2.5/cset@1.797.156.3
| and it doesnt seem to have this problem.


I haven't tried to make that many net devices.
Acme, does this look helpful?
Christian, can you test this patch?

--
~Randy


patch_name:	proc_net_dev_seq.patch
patch_version:	2003-04-29.09:10:38
author:		Randy.Dunlap <rddunlap@osdl.org>
description:	fix /proc/net/dev to include entire file for output
product:	Linux
product_versions: linux-2568-428
changelog:	seq_start() needs to increment i;
URL:		_
requires:	_
conflicts:	_
maintainer:	davem@redhat.com
diffstat:	=
 net/core/dev.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)


diff -Naur ./net/core/dev.c%SEQ ./net/core/dev.c
--- ./net/core/dev.c%SEQ	2003-04-28 15:07:01.000000000 -0700
+++ ./net/core/dev.c	2003-04-29 09:06:18.000000000 -0700
@@ -1789,7 +1789,7 @@
 	struct net_device *dev;
 	loff_t i;
 
-	for (i = 0, dev = dev_base; dev && i < pos; dev = dev->next);
+	for (i = 0, dev = dev_base; dev && i < pos; dev = dev->next, i++);
 
 	return i == pos ? dev : NULL;
 }
