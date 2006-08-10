Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750836AbWHJV1D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750836AbWHJV1D (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 17:27:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750803AbWHJV1C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 17:27:02 -0400
Received: from sj-iport-3-in.cisco.com ([171.71.176.72]:25911 "EHLO
	sj-iport-3.cisco.com") by vger.kernel.org with ESMTP
	id S1750836AbWHJV07 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 17:26:59 -0400
X-IronPort-AV: i="4.08,112,1154934000"; 
   d="scan'208"; a="440083004:sNHT51564561424"
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: kernel panic:BUG in cascade at kernel/timer.c
Date: Thu, 10 Aug 2006 14:26:15 -0700
Message-ID: <F795765B112E7344AF36AA9112796415019ED349@xmb-sjc-212.amer.cisco.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: kernel panic:BUG in cascade at kernel/timer.c
Thread-Index: Aca8w5xrngF/Wl7ETa+MrY8QUMKpNA==
From: "Bizhan Gholikhamseh \(bgholikh\)" <bgholikh@cisco.com>
To: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 10 Aug 2006 21:26:15.0755 (UTC) FILETIME=[9C89A9B0:01C6BCC3]
Authentication-Results: sj-dkim-2.cisco.com; header.From=bgholikh@cisco.com; dkim=pass (
	sig from cisco.com verified; ); 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,
We have developed our own custom board based on MPC8541 board running
linux 2.6.11 During stress testing the system we get following kernel
panic which related to timer cascase.
Any hints greatly apprieciated. Many thanks in advance:
 
kernel BUG in cascade at kernel/timer.c:416!
Oops: Exception in kernel mode, sig: 5 [#1] PREEMPT
NIP: C0023AB4 LR: C0023CC8 SP: C02DDDF0 REGS: c02ddd40 TRAP: 0700
Tainted: P    
MSR: 00021200 EE: 0 PR: 0 FP: 0 ME: 1 IR/DR: 00 TASK = c02bb730[0]
'swapper' THREAD: c02dc000 Last syscall: 120 

File timer.c line 416 :
    401 static int cascade(tvec_base_t *base, tvec_t *tv, int index)
    402 {
    403         /* cascade all the timers from tv up one level */
    404         struct list_head *head, *curr;
    405 
    406         head = tv->vec + index;
    407         curr = head->next;
    408         /*
    409          * We are removing _all_ timers from the list, so we
don't  have
         to
    410          * detach them individually, just clear the list
afterwards.
    411          */ 
    412         while (curr != head) {
    413                 struct timer_list *tmp;
    414         
    415                 tmp = list_entry(curr, struct timer_list,
entry);
    416                 BUG_ON(tmp->base != base);
    417                 curr = curr->next;
    418                 internal_add_timer(base, tmp);
    419         }
    420         INIT_LIST_HEAD(head);
    421 
    422         return index;

 
Regards,
Bizhan
