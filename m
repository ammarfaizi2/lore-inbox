Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265063AbTFLXkI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jun 2003 19:40:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265064AbTFLXkI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jun 2003 19:40:08 -0400
Received: from ajax.cs.uga.edu ([128.192.251.3]:51929 "EHLO ajax.cs.uga.edu")
	by vger.kernel.org with ESMTP id S265063AbTFLXkB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jun 2003 19:40:01 -0400
Date: Thu, 12 Jun 2003 19:59:05 -0400
From: Ed L Cashin <ecashin@uga.edu>
To: linux-kernel@vger.kernel.org
Cc: "Martin J. Bligh" <mbligh@aracnet.com>
Subject: illegal sleeping function call on shutdown (was Re: 2.5.70-mjb2)
Message-ID: <20030612195905.A317@atlas.cs.uga.edu>
References: <46310000.1055429606@[10.10.2.4]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <46310000.1055429606@[10.10.2.4]>; from mbligh@aracnet.com on Thu, Jun 12, 2003 at 07:53:26AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 12, 2003 at 07:53:26AM -0700, Martin J. Bligh wrote:
...
> I'd be very interested in feedback from anyone willing to test on any 
> platform, however large or small.

On shutdown -h, I see the stack trace below before power
off.  This is a Dell Poweredge 4400 with two 900MHz cpus.
I know that in the past, combining SMP and APM has been a 
no-no -- don't know if that's what's going on.

I see this with 2.5.70-mm4, too, btw.  At least it's very
similar: starts with close and produces a sleeping function
warning.

More system details are at URL below:

  http://www.cs.uga.edu/~cashin/temp/mjb2-bt.txt

Synchronizing SCSI caches: 
Shutting down devices
Power down.
acpi_power_off called
Debug: sleeping function called from illegal context at include/asm/semaphore.h:121
Call Trace:
 [<c011e033>] __might_sleep+0x4f/0x53
 [<c01fcecf>] acpi_os_wait_semaphore+0xff/0x1ec
 [<c0222395>] acpi_ut_acquire_mutex+0xd5/0x170
 [<c0210d27>] acpi_hw_clear_acpi_status+0x57/0xe0
 [<c0211b99>] acpi_enter_sleep_state+0xcd/0x2a8
 [<c0224fd1>] Letext+0x21/0x28
 [<c011502a>] machine_power_off+0xe/0x12
 [<c012b23c>] sys_reboot+0x1b0/0x2c8
 [<c011b7c7>] wake_up_process_kick+0xf/0x14
 [<c01289bb>] kill_proc_info+0x37/0x4c
 [<c0128aa2>] kill_something_info+0xd2/0xf0
 [<c012a05d>] sys_kill+0x49/0x54
 [<c014dfec>] __fput+0xc0/0xe4
 [<c014df27>] fput+0x17/0x1c
 [<c014cb7e>] filp_close+0x96/0xa4
 [<c014cbe1>] sys_close+0x55/0x6c
 [<c010aa73>] syscall_call+0x7/0xb

 hwsleep-0257 [35] acpi_enter_sleep_state: Entering sleep state [S5]


-- 
--Ed L Cashin            |   PGP public key:
  ecashin@uga.edu        |   http://noserose.net/e/pgp/
