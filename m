Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261925AbTILXG5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Sep 2003 19:06:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261928AbTILXG5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Sep 2003 19:06:57 -0400
Received: from waste.org ([209.173.204.2]:38311 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S261925AbTILXGt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Sep 2003 19:06:49 -0400
Date: Fri, 12 Sep 2003 18:06:37 -0500
From: Matt Mackall <mpm@selenic.com>
To: Pat LaVarre <p.lavarre@ieee.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: console lost to Ctrl+Alt+F$n in 2.6.0-test5
Message-ID: <20030912230637.GB4489@waste.org>
References: <1063378664.5059.19.camel@patehci2> <1063390768.2898.15.camel@patehci2>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1063390768.2898.15.camel@patehci2>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 12, 2003 at 12:19:28PM -0600, Pat LaVarre wrote:
> 
> > ... always ... an oops ... Must be fixed.
> 
> Once upon a time Ctrl+Alt+F1 gave me a plain text console, Ctrl+Alt+F7
> returned me to me X Windows console.
> 
> Much has changed, the last thing I changed was upgrading to 2.6.0-test5
> from 2.6.0-test4, and now I find that toggling back and forth a few
> times leaves my display permanently dark.  Recovered from my ext3
> journal are the following two examples of  `cat /proc/kmsg | tee ...`
> output.
> 
> This report differs slightly, e.g. by severity, repeatability, and
> mention of handle_vm86_fault, from much of:
> http://groups.google.com/groups?q=__might_sleep&scoring=d
> 
> Example #1:
> 
> ...
> <4>sr0: scsi3-mmc drive: 0x/48x writer cd/rw xa/form2 cdda tray
> <4>sr0: scsi3-mmc maybe not writeable
> <6>Uniform CD-ROM driver Revision: 3.12
> <7>Attached scsi CD-ROM sr0 at scsi0, channel 0, id 0, lun 0
> <4>sr1: scsi3-mmc writable profile: 0x0002
> <7>Attached scsi CD-ROM sr1 at scsi1, channel 0, id 0, lun 0
> <3>Debug: sleeping function called from invalid context at include/asm/uaccess.h:473
> <4>Call Trace:
> <4> [<c0121f16>] __might_sleep+0x5f/0x72
> <4> [<c010e76a>] save_v86_state+0x6a/0x20f
> <4> [<c010f32d>] handle_vm86_fault+0xa7/0x8fb
> <4> [<c010cc8f>] do_general_protection+0x0/0x93
> <4> [<c010bf49>] error_code+0x2d/0x38
> <4> [<c010b4bf>] syscall_call+0x7/0xb
> <4>
> 
> Example #2:
> 
> ...
> <3>Debug: sleeping function called from invalid context at include/asm/uaccess.h:473
> <4>Call Trace:
> <4> [<c0121f16>] __might_sleep+0x5f/0x72
> <4> [<c010e76a>] save_v86_state+0x6a/0x20f
> <4> [<c010f32d>] handle_vm86_fault+0xa7/0x8fb
> <4> [<c02323aa>] ipi_handler+0x0/0x7
> <4> [<c010cc8f>] do_general_protection+0x0/0x93
> <4> [<c010bf49>] error_code+0x2d/0x38
> <4> [<c010b4bf>] syscall_call+0x7/0xb
> <4>
> ...
> 
> Pat LaVarre

I'm working on this, it's rather messy. Your lockup might be caused by
printk spew during console switch, see if it still locks up with the
sleep debugging turned off.

-- 
Matt Mackall : http://www.selenic.com : of or relating to the moon
