Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261406AbTJ2TTN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Oct 2003 14:19:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261429AbTJ2TTN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Oct 2003 14:19:13 -0500
Received: from mail.ccur.com ([208.248.32.212]:20999 "EHLO exchange.ccur.com")
	by vger.kernel.org with ESMTP id S261406AbTJ2TTJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Oct 2003 14:19:09 -0500
Subject: x86_64 module loader reloc problem
From: Jason Baietto <jason.baietto@ccur.com>
To: lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1067455102.444.18.camel@broccoli>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Wed, 29 Oct 2003 14:18:22 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Using test8 I'm only able to load kernel modules on x86_64 systems if I
comment out the overflow check for R_X86_64_32 relocation entries in
arch/x64_64/kernel/module.c.

With the check in place I get errors like this:

   overflow in relocation type 10 val ffffff0000426b88" errors
   `test' likely not compiled with -mcmodel=kernel
   insmod: error inserting 'test.ko': -1 Invalid module format

Yes, I'm using -mcmodel=kernel.  I'm also using module-init-tools
0.9.15-pre2.  Once loaded, the modules appear to be working properly,
but it wouldn't surprise me if a time bomb was lurking there.

What am I doing wrong?  Compiler used for both kernel and modules is gcc
(GCC) 3.2.3 20030502 (Red Hat Linux 3.2.3-20).

Note that in my linked test module, objdump shows 632 R_X86_64_32 reloc
entries and only 18 R_X86_64_64 reloc entries.

Take care,
Jason


