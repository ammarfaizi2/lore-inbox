Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261824AbTILSSb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Sep 2003 14:18:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261825AbTILSSb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Sep 2003 14:18:31 -0400
Received: from email-out2.iomega.com ([147.178.1.83]:28357 "EHLO
	email.iomega.com") by vger.kernel.org with ESMTP id S261824AbTILSS3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Sep 2003 14:18:29 -0400
Subject: console lost to Ctrl+Alt+F$n in 2.6.0-test5
From: Pat LaVarre <p.lavarre@ieee.org>
To: linux-kernel@vger.kernel.org
In-Reply-To: <1063378664.5059.19.camel@patehci2>
References: <1063378664.5059.19.camel@patehci2>
Content-Type: text/plain
Organization: 
Message-Id: <1063390768.2898.15.camel@patehci2>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 12 Sep 2003 12:19:28 -0600
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 12 Sep 2003 18:18:27.0533 (UTC) FILETIME=[430B2FD0:01C3795A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> ... always ... an oops ... Must be fixed.

Once upon a time Ctrl+Alt+F1 gave me a plain text console, Ctrl+Alt+F7
returned me to me X Windows console.

Much has changed, the last thing I changed was upgrading to 2.6.0-test5
from 2.6.0-test4, and now I find that toggling back and forth a few
times leaves my display permanently dark.  Recovered from my ext3
journal are the following two examples of  `cat /proc/kmsg | tee ...`
output.

This report differs slightly, e.g. by severity, repeatability, and
mention of handle_vm86_fault, from much of:
http://groups.google.com/groups?q=__might_sleep&scoring=d

Example #1:

...
<4>sr0: scsi3-mmc drive: 0x/48x writer cd/rw xa/form2 cdda tray
<4>sr0: scsi3-mmc maybe not writeable
<6>Uniform CD-ROM driver Revision: 3.12
<7>Attached scsi CD-ROM sr0 at scsi0, channel 0, id 0, lun 0
<4>sr1: scsi3-mmc writable profile: 0x0002
<7>Attached scsi CD-ROM sr1 at scsi1, channel 0, id 0, lun 0
<3>Debug: sleeping function called from invalid context at include/asm/uaccess.h:473
<4>Call Trace:
<4> [<c0121f16>] __might_sleep+0x5f/0x72
<4> [<c010e76a>] save_v86_state+0x6a/0x20f
<4> [<c010f32d>] handle_vm86_fault+0xa7/0x8fb
<4> [<c010cc8f>] do_general_protection+0x0/0x93
<4> [<c010bf49>] error_code+0x2d/0x38
<4> [<c010b4bf>] syscall_call+0x7/0xb
<4>

Example #2:

...
<3>Debug: sleeping function called from invalid context at include/asm/uaccess.h:473
<4>Call Trace:
<4> [<c0121f16>] __might_sleep+0x5f/0x72
<4> [<c010e76a>] save_v86_state+0x6a/0x20f
<4> [<c010f32d>] handle_vm86_fault+0xa7/0x8fb
<4> [<c02323aa>] ipi_handler+0x0/0x7
<4> [<c010cc8f>] do_general_protection+0x0/0x93
<4> [<c010bf49>] error_code+0x2d/0x38
<4> [<c010b4bf>] syscall_call+0x7/0xb
<4>
...

Pat LaVarre



