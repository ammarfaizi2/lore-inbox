Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264832AbUETCq6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264832AbUETCq6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 May 2004 22:46:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264829AbUETCq6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 May 2004 22:46:58 -0400
Received: from dcs-server2.cs.uiuc.edu ([128.174.252.3]:17559 "EHLO
	dcs-server2.cs.uiuc.edu") by vger.kernel.org with ESMTP
	id S264832AbUETCqu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 May 2004 22:46:50 -0400
From: "Zhenmin Li" <zli4@cs.uiuc.edu>
To: <linux-kernel@vger.kernel.org>
Subject: [OPERA] Potential bug in /arch/sparc/prom/memory.c &  /arch/sparc64/prom/memory.c
Date: Wed, 19 May 2004 21:45:03 -0500
Message-ID: <001201c43e14$73e8c840$76f6ae80@Turandot>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.6626
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We ran our bug detection tool upon Linux 2.6.6, and found some potential
errors. We would sincerely appreciate your help if anyone can confirm
whether they are bugs or not.

Linux 2.6.6, /arch/sparc/prom/memory.c, Line 153-160

153    for(iter=0; iter<num_regs; iter++) {
154            prom_prom_taken[iter].start_adr =
155                    (char *) prom_reg_memlist[iter].phys_addr;
156            prom_prom_taken[iter].num_bytes =
157                    (unsigned long) prom_reg_memlist[iter].reg_size;
158            prom_prom_taken[iter].theres_more =
!159                    &prom_phys_total[iter+1];
160    }

May be changeg to:

153    for(iter=0; iter<num_regs; iter++) {
154            prom_prom_taken[iter].start_adr =
155                    (char *) prom_reg_memlist[iter].phys_addr;
156            prom_prom_taken[iter].num_bytes =
157                    (unsigned long) prom_reg_memlist[iter].reg_size;
158            prom_prom_taken[iter].theres_more =
!159                    & prom_prom_taken[iter+1];
160    }


The same bug is in /arch/sparc64/prom/memory.c, Line 111-118.


Thanks a lot,
OPERA Research Group
University of Illinois at Urbana-Champaign


