Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261216AbVAGA2e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261216AbVAGA2e (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 19:28:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261232AbVAGAUW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 19:20:22 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.143]:387 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261542AbVAGARQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 19:17:16 -0500
Date: Thu, 6 Jan 2005 16:17:15 -0800
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: linux-kernel@vger.kernel.org
Subject: FW: [KJ] ftape/fdc-io: schedule_timeout() usage
Message-ID: <20050107001715.GG3055@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Operating-System: Linux 2.6.10 (i686)
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I haven't had any replies so far, and it was suggested that I also fish on LKML
for input.

Thanks,
Nish

----- Forwarded message from Nishanth Aravamudan <nacc@us.ibm.com> -----

Date: Wed, 5 Jan 2005 16:14:00 -0800
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: linux-tape@vger.kernel.org
Cc: kernel-janitors@lists.osdl.org
Subject: [KJ] ftape/fdc-io: schedule_timeout() usage

Hello,

I'm hoping someone here can help me correct some ftape code.
drivers/char/ftape/lowlevel/fdc-io.c::fdc_interrupt_wait() contains the
following code:

set_current_state(TASK_INTERRUPTIBLE);
add_wait_queue((&ftape_wait_intr, &wait);
while (!ft_interrupt_seen && (current->state == TASK_INTERRUPTIBLE)) {
	timeout = schedule_timeout(timeout);
}

The problem I have is that after the first iteration of the loop
(schedule_timeout() with TASK_INTERRUPTIBLE), it will become a busy-wait, as
schedule_timeout() will be running with current->state set to TASK_RUNNING. I'm
not sure if this is desired, but it seems weird to me. Any input would be
appreciated.

-Nish

_______________________________________________
Kernel-janitors mailing list
Kernel-janitors@lists.osdl.org
http://lists.osdl.org/mailman/listinfo/kernel-janitors


----- End forwarded message -----
