Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262069AbTKCOpe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Nov 2003 09:45:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262074AbTKCOpe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Nov 2003 09:45:34 -0500
Received: from hq.pm.waw.pl ([195.116.170.10]:3470 "EHLO hq.pm.waw.pl")
	by vger.kernel.org with ESMTP id S262069AbTKCOpc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Nov 2003 09:45:32 -0500
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.23-pre9
References: <Pine.LNX.4.44.0310300954540.1275-100000@logos.cnet>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: 03 Nov 2003 15:45:31 +0100
In-Reply-To: <Pine.LNX.4.44.0310300954540.1275-100000@logos.cnet>
Message-ID: <m365i15x4k.fsf@defiant.pm.waw.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Tosatti <marcelo.tosatti@cyclades.com> writes:

> Here goes -pre9. Only bugfixes will be accepted till 2.4.24-pre now.

Would you (try to) accept a patch from me if I fix the following?

Modular IDE is still broken:
hq:/usr/src/linux-hq# /sbin/depmod -ae
depmod: *** Unresolved symbols in .../kernel/drivers/ide/ide-core.o
depmod:         ide_wait_hwif_ready
depmod:         ide_probe_for_drive
depmod:         ide_probe_reset
depmod:         ide_tune_drives

This is a circular dependency - ide-core.o wants them and they are exported
by ide-probe.o which wants things from ide-core.o.



Compilation on one of my systems produces (gcc 3.3.1):
*** md5sum: WARNING: 1 of 13 computed checksums did NOT match

(this is probably the ISDN source file checksum - we should update MD5
checksum or drop this checking at all).

vt.c: In function `do_kdsk_ioctl':
vt.c:166: warning: comparison is always false due to limited range of data type
vt.c: In function `do_kdgkb_ioctl':
vt.c:283: warning: comparison is always false due to limited range of data type

Probably older gcc is more quiet here.

keyboard.c: In function `do_fn':
keyboard.c:640: warning: comparison is always true due to limited range of data
type
string.c:384: warning: conflicting types for built-in function `bcopy'
process.c: In function `machine_restart':
process.c:426: warning: use of memory input without lvalue in asm operand 0 is deprecated
time.c:433: warning: `do_gettimeoffset_cyclone' defined but not used

Modules:

inode.c:198: warning: `ncp_symlink_inode_operations' defined but not used
ioctl.c: In function `smb_ioctl':
ioctl.c:34: warning: comparison is always false due to limited range of data type
ioctl.c:34: warning: comparison is always false due to limited range of data type
ioctl.c:34: warning: comparison is always false due to limited range of data type
ioctl.c:34: warning: comparison is always false due to limited range of data type

-- 
Krzysztof Halasa, B*FH
