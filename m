Return-Path: <linux-kernel-owner+willy=40w.ods.org-S968641AbWLETe3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S968641AbWLETe3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 14:34:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S968664AbWLETe3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 14:34:29 -0500
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:4063 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S968641AbWLETe2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 14:34:28 -0500
Date: Tue, 5 Dec 2006 19:33:57 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Cc: Sam Ravnborg <sam@ravnborg.org>
Subject: More ARM binutils fuckage
Message-ID: <20061205193357.GF24038@flint.arm.linux.org.uk>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>,
	Sam Ravnborg <sam@ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There's not much to say about this, other than scream and go hide in the
corner.  ARM toolchains are just basically fscked.

  arm-linux-ld -EL  -p --no-undefined -X -o .tmp_vmlinux1 -T
 arch/arm/kernel/vmlinux.lds arch/arm/kernel/head.o
 arch/arm/kernel/init_task.o  init/built-in.o --start-group
  usr/built-in.o  arch/arm/kernel/built-in.o  arch/arm/mm/built-in.o
  arch/arm/common/built-in.o  arch/arm/mach-versatile/built-in.o
  arch/arm/nwfpe/built-in.o  arch/arm/vfp/built-in.o  kernel/built-in.o
  mm/built-in.o  fs/built-in.o  ipc/built-in.o  security/built-in.o
  crypto/built-in.o  block/built-in.o  arch/arm/lib/lib.a  lib/lib.a
  arch/arm/lib/built-in.o  lib/built-in.o  drivers/built-in.o
  sound/built-in.o  net/built-in.o --end-group

Produces no error, but:

$ arm-linux-nm ../build/versatile/.tmp_vmlinux1 |grep ' U '
         U __divdi3
         U __udivdi3
         U __umoddi3

Duh.

Result is you get successful kernel builds without any error, but a *bad*
incomplete image.  IOW, you do not know whether or not your kernel is
_safe_ to execute.

That's binutils 2.17.  binutils 2.16 had this problem and I tried to get a
patch into the kernel to use 'nm' to detect this fsckage.  We *need* this
patch in the kernel.

Sam, can we resurrect my attempts to do this please?

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
