Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261605AbTELATx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 May 2003 20:19:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261666AbTELATw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 May 2003 20:19:52 -0400
Received: from siaab1ab.compuserve.com ([149.174.40.2]:26328 "EHLO
	siaab1ab.compuserve.com") by vger.kernel.org with ESMTP
	id S261605AbTELATt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 May 2003 20:19:49 -0400
Date: Sun, 11 May 2003 20:29:08 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Stupid question about the output of show_task()
To: linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200305112032_MC3-1-386D-F200@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  I'm trying to decipher the output of alt-sysrq-t on i386 running
2.4.21-rc2-ac1:

                          free                        sibling
   task             PC    stack   pid father child younger older
init          S 000001F0  4352     1      0   943               (NOTLB)

Why does it report the program counter as 0x1f0?  This comes from
((unsigned long *)thread_struct.esp)[3], i.e. the third item from the
top of the saved process stack.  Why do many of the processes show
completely invalid values for the instruction pointer?  And where is
the layout for the stack of sleeping processes documented?

Some processes show large numbers that are above the kernel's space:

xfsdatad/0    S D7EE0342  6076    13      1            14    12 (L-TLB)

Many others just have zero or one for their PC:

scsi_eh_0     S 00000000  6084    14      1            15    13 (L-TLB)
kupdated      S 00000001  5632     7      1             8     6 (L-TLB)


