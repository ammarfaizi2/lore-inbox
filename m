Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267271AbUG1Pvy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267271AbUG1Pvy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 11:51:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267250AbUG1Pt6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 11:49:58 -0400
Received: from users.linvision.com ([62.58.92.114]:8119 "HELO bitwizard.nl")
	by vger.kernel.org with SMTP id S267205AbUG1Prz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 11:47:55 -0400
Date: Wed, 28 Jul 2004 17:47:49 +0200
From: Erik Mouw <erik@harddisk-recovery.com>
To: linux-kernel@vger.kernel.org
Cc: wli@holomorphy.com
Subject: 2.4.26 doesn't boot on a 386 without "Unsynced TSC support"
Message-ID: <20040728154748.GB1675@harddisk-recovery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Organization: Harddisk-recovery.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I tried to boot 2.4.26 on my good old 386 board, but got a kernel
panic:

  CPU: 386
  Kernel panic: Kernel compiled for Pentium+, requires TSC feature!

The error message comes from the function check_config() in
include/asm-i386/bugs.h (thanks to wli for figuring out faster than I
did).

I am sure I selected support for a 80386 CPU, so the error message
looks wrong to me. CONFIG_M586TSC is not set, but CONFIG_X86_TSC is
enabled by default. The only way to disable it, is to enable "Unsynced
TSC support", (CONFIG_X86_TSC_DISABLE).

The help for CONFIG_X86_TSC_DISABLE mentions to use it for "NUMA
mult-mode boxes, laptops and other systems suffering from unsynced TSCs
or TSC drift, which can cause gettimeofday to return non-monotonic
values." A simple 80386 board doesn't belong to these, and I can't
remember having problmes with gettimeofday() in the past (IIRC the
board last ran linux-1.2 or 2.0).

My question is: is this a code bug, or a documentation bug? Right now,
I guess 2.4.26 will not run on anything < Pentium without
CONFIG_X86_TSC_DISABLE enabled.


Erik

-- 
+-- Erik Mouw -- www.harddisk-recovery.com -- +31 70 370 12 90 --
| Lab address: Delftechpark 26, 2628 XH, Delft, The Netherlands
