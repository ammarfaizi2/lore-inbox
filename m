Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262091AbVBJKSv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262091AbVBJKSv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Feb 2005 05:18:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262095AbVBJKSu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Feb 2005 05:18:50 -0500
Received: from mxc.rambler.ru ([81.19.66.31]:28933 "EHLO mxc.rambler.ru")
	by vger.kernel.org with ESMTP id S262091AbVBJKSf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Feb 2005 05:18:35 -0500
Date: Thu, 10 Feb 2005 13:15:48 -0500
From: Pavel Fedin <sonic_amiga@rambler.ru>
To: linux-kernel@vger.kernel.org
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Floppy driver DMA question - PLEASE answer me, it's important for
 fixing
Message-Id: <20050210131548.42ccd31d.sonic_amiga@rambler.ru>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Auth-User: sonic_amiga, whoson: (null)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 I'd like to ask some questions about floppy driver. I am owner of Pegasos-II PowerPC-based mainboard (http://www.pegasosppc.com) and floppy drive doesn't work on my machine. It doesn't read any data, sometimes even causes random crashes. Sometimes operation looks like completed ok but wrong data are read from/written to disk. Everything points to DMA problem - wrong region is used.
 I tried to turn off DMA by specifying floppy=nodma but then it doesn't work at all.
 I investigated the problem and discovered that virtual DMA for PowerPC is not implemented at all and hardware DMA is also handled differently. So here is my question:

 In include/asm-ppc/floppy.h i see the following:
 --- cut ---
/*
 * The PowerPC has no problems with floppy DMA crossing 64k borders.
 */
#define CROSS_64KB(a,s)	(0)
 --- cut ---
 What architectures was this tested on? Only Macintoshes or also something else? Does this work on CHRP-based machines? Pegasos is a CHRP-based machine and i'd like to know if ISA DMA is restricted in the same way as on x86. If yes, i will try to replace this macro with one taken from include/asm-i386/floppy.h but i'm afraid of reducing functionality or even breaking support for some machines which i don't know about. I guess i should use some #ifdef's here but i don't know conditions for them.

 P. S. For information: Pegasos uses Discovery II MV64361 as a northbridge and VIA 8231 as southbridge. For full technical specifications see: http://www.pegasosppc.com/tech_specs.php

-- 
Best regards,
Pavel Fedin,									mailto:sonic_amiga@rambler.ru
