Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263455AbTFYBnD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jun 2003 21:43:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263451AbTFYBnD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jun 2003 21:43:03 -0400
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.28]:42937 "HELO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id S263455AbTFYBnA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jun 2003 21:43:00 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Jean Tourrilhes <jt@hpl.hp.com>
Date: Wed, 25 Jun 2003 11:56:53 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16121.357.838418.87410@gargle.gargle.HOWL>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Provide refrigerator support for irda
X-Mailer: VM 7.16 under Emacs 21.3.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Jean.
 2.5.73/MAINTAINERS: IRDA SUBSYSTEM
doesn't have an "M:" field, so I'm guessing that the P: field is close
enough.

Without this patch, kIrDAd prevents my notebook from entering suspend
mode.

NeilBrown


 ----------- Diffstat output ------------
 ./drivers/net/irda/sir_kthread.c |    3 +++
 1 files changed, 3 insertions(+)

diff ./drivers/net/irda/sir_kthread.c~current~ ./drivers/net/irda/sir_kthread.c
--- ./drivers/net/irda/sir_kthread.c~current~	2003-06-25 11:50:36.000000000 +1000
+++ ./drivers/net/irda/sir_kthread.c	2003-06-25 11:51:02.000000000 +1000
@@ -166,6 +166,9 @@ static int irda_thread(void *startup)
 			set_task_state(current, TASK_RUNNING);
 		remove_wait_queue(&irda_rq_queue.kick, &wait);
 
+		if (current->flags & PF_FREEZE)
+			refrigerator(PF_IOTHREAD);
+
 		run_irda_queue();
 	}
 
