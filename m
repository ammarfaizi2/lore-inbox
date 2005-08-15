Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964875AbVHOSFV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964875AbVHOSFV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Aug 2005 14:05:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964876AbVHOSFV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Aug 2005 14:05:21 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:22917 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S964875AbVHOSFU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Aug 2005 14:05:20 -0400
Date: Mon, 15 Aug 2005 11:05:14 -0700
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [-mm PATCH 0/32] fix-up schedule_timeout() usage
Message-ID: <20050815180514.GC2854@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Operating-System: Linux 2.6.12 (i686)
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Andrew,

Sorry for the lack of a combined To:/Cc: list, but it would have been
excessive if I included everyone (I won't send all of the patches to
LKML, unless there is no other list entry in MAINTAINERS - I think that
is only 9 out of the 32 patches :)

Andrew recently added schedule_timeout_interruptible() and
schedule_timeout_uninterruptible() to the -mm tree, as
schedule_timeout() called without the state set results in an immediate
return; thus, it makes little sense to ever call it that way. Almost all
the kernel invocations of schedule_timeout(), additionally, follow:

	set_current_state(TASK_{,UN}INTERRUPTIBLE);
	schedule_timeout(some_value_in_jiffies);

Andrew pointed out that creating non-inline wrappers for this common
usage should reduce the kernel size. The following 32 patches (split up
by directory/subsystem) convert the schedule_timeout() callers in
2.6.13-rc5-mm1, where appropriate.

Here's the list of patches as I split them up:

01/32: include/
02/32: fs/
03/32: kernel/
04/32: mm/
05/32: net/
06/32: sound/
07/32: arch/alpha
08/32: arch/i386
09/32: arch/ia64
10/32: arch/m68k
11/32: arch/mips
12/32: arch/ppc
13/32: arch/ppc64
14/32: arch/um
15/32: drivers/acpi
16/32: drivers/block
17/32: drivers/cdrom
18/32: drivers/char
19/32: drivers/dlm
20/32: drivers/net
21/32: drivers/ieee1394
22/32: drivers/isdn
23/32: drivers/macintosh
24/32: drivers/md
25/32: drivers/media
26/32: drivers/message
27/32: drivers/parport
28/32: drivers/sbus
29/32: drivers/scsi
30/32: drivers/serial
31/32: drivers/telephony
32/32: drivers/usb

Thanks,
Nish
