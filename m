Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318107AbSHZMZH>; Mon, 26 Aug 2002 08:25:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318109AbSHZMZH>; Mon, 26 Aug 2002 08:25:07 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:38651 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318107AbSHZMZG>; Mon, 26 Aug 2002 08:25:06 -0400
Subject: Re: Compilation error in 2.4.20-pre4-ac2
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Petr Konecny <pekon@informatics.muni.cz>
Cc: alan@redhat.com, linux-kernel@vger.kernel.org
In-Reply-To: <qwwr8glzxgh.fsf@decibel.fi.muni.cz>
References: <qwwr8glzxgh.fsf@decibel.fi.muni.cz>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-6) 
Date: 26 Aug 2002 13:30:18 +0100
Message-Id: <1030365019.1298.0.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-08-26 at 12:11, Petr Konecny wrote:
> Hi Alan,
> 
> I got an error when compiling 2.4.20-pre4-ac2. Compiled on debian
> unstable with gcc-3.2.
>
Arghh missed that because I didn't clean build after I broke that bit

Try the following

--- drivers/ide/Makefile~	2002-08-26 13:06:26.000000000 +0100
+++ drivers/ide/Makefile	2002-08-26 13:06:26.000000000 +0100
@@ -19,6 +19,9 @@
 obj-m		:=
 ide-obj-y	:=
 
+subdir-$(CONFIG_BLK_DEV_IDEPCI)	+= pci
+subdir-$(CONFIG_BLK_DEV_IDE) += legacy ppc arm raid
+
 obj-$(CONFIG_BLK_DEV_IDE)		+= ide-probe.o ide-geometry.o ide-iops.o ide-taskfile.o ide.o ide-lib.o
 obj-$(CONFIG_BLK_DEV_IDEDISK)		+= ide-disk.o
 obj-$(CONFIG_BLK_DEV_IDECD)		+= ide-cd.o
