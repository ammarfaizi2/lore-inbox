Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262212AbVCHXOq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262212AbVCHXOq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 18:14:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262218AbVCHXOD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 18:14:03 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.145]:59780 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262175AbVCHXFK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 18:05:10 -0500
Date: Tue, 8 Mar 2005 16:59:04 -0600
From: Jake Moilanen <moilanen@austin.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org,
       Anton Blanchard <anton@samba.org>, paulus@samba.org,
       benh@kernel.crashing.org
Subject: [PATCH 0/2] No-exec support for ppc64
Message-Id: <20050308165904.0ce07112.moilanen@austin.ibm.com>
Organization: IBM
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

These patches add no execute support to PPC64.  They prohibit executing
code on the stack, or most any non-text segment for both user space, and
kernel.

No execute is supported on Power4 processors and up.  These processors
support pages that have a no-execute permission bit.  

The patches include a base fixup from Anton Blanchard.  This includes a
fix for the wrong bit being used for no-exec and for read/write on the
hardware PTEs.

For distros that compile w/ pt_gnu_stacks, they depend on Ben
Herrenschmidt's vDSO patches for signal trampoline.  Without it, the
application will hang on the first signal due to the return code being
put on the signal context stack to return to the kernel on the
completion of the signal handler.  The changes should be in the latest
BK tree.

The patch is broken into two parts:

1/2: PPC64 no-exec support for user space:  This will prohibit user
space apps from executing in segments not marked as executable.  The
base support is in here as well.

2/2: PPC64 no-exec support for kernel space:  This prohibits the kernel
from executing non-text code.

Thanks,
Jake
