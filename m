Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266458AbUFUUsk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266458AbUFUUsk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jun 2004 16:48:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266459AbUFUUsk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jun 2004 16:48:40 -0400
Received: from outmx001.isp.belgacom.be ([195.238.3.51]:42975 "EHLO
	outmx001.isp.belgacom.be") by vger.kernel.org with ESMTP
	id S266458AbUFUUsi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jun 2004 16:48:38 -0400
Subject: 2.6.7-mm1 I/O regression ?
From: FabF <fabian.frederick@skynet.be>
To: linux-kernel@vger.kernel.org
In-Reply-To: <20040620174632.74e08e09.akpm@osdl.org>
References: <20040620174632.74e08e09.akpm@osdl.org>
Content-Type: text/plain
Message-Id: <1087859142.2331.30.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 22 Jun 2004 01:05:43 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

	I've got strange I/O regression from 2.6.7-mm1.Here's a small fgrep
report :
	
2.6.7-mm1 (worst results ever seen)
-----------------------------------
Grepping  /usr/bin  :
23% cpu - 86.16 RT Sec - 1.77 Sec in KM
Entries scanned :
1569
90192 Kb analyzed this time

2.6.7-mm1 vm profile snippet
----------------------------

61.9360  vmlinux                  poll_idle
0.8899  vmlinux                  mark_offset_tsc
0.8857  vmlinux                  __copy_to_user_ll
0.6136  vmlinux                  mask_and_ack_8259A
0.5605  vmlinux                  do_anonymous_page
0.3445  vmlinux                  unix_poll
0.3240  vmlinux                  __switch_to
0.2016  vmlinux                  enable_8259A_irq
0.1448  vmlinux                  do_select
0.1336  vmlinux                  get_exec_dcookie
0.1128  vmlinux                  fget
0.0959  vmlinux                  schedule

2.6.7 (best results ever seen)
------------------------------
Grepping  /usr/bin  :
48% cpu - 37.61 RT Sec - 1.46 Sec in KM
Entries scanned :
1569
90184 Kb analyzed this time

2.6.7 vm Profile snippet
------------------------
80.4850  vmlinux                  poll_idle
0.9149  vmlinux                  mark_offset_tsc
0.7879  vmlinux                  mask_and_ack_8259A
0.4552  vmlinux                  do_wp_page
0.3943  vmlinux                  do_anonymous_page
0.2559  vmlinux                  enable_8259A_irq
0.2464  vmlinux                  __copy_to_user_ll
0.1721  vmlinux                  unix_poll
0.1302  vmlinux                  irq_entries_start

Well, profiles don't give a clue but fgrep RT delta is impressive.Did I missed something ?

PS : Those tests were made on ext3 partition.

Regards,
FabF

