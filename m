Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316973AbSF0VJc>; Thu, 27 Jun 2002 17:09:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316974AbSF0VJb>; Thu, 27 Jun 2002 17:09:31 -0400
Received: from zikova.cvut.cz ([147.32.235.100]:4878 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S316973AbSF0VJa>;
	Thu, 27 Jun 2002 17:09:30 -0400
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: linux-kernel@vger.kernel.org
Date: Thu, 27 Jun 2002 23:11:29 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Oops in schedule in 2.5.24
X-mailer: Pegasus Mail v3.50
Message-ID: <95039BC6D12@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
  I decided to give 2.5.24 a try now when IDE94 and IDE95 were out.
So I applied IDE94/95 and built usual kernel (PIII, SMP) for my UP P4
host. And it died with

Unable to handle kernel NULL reference to 0x0000002A
Call trace: schedule + 491/1102
            sys_sched_yield + 444/455
            syscall

>From looking at the code, it looks like that queue->next (sched.c, line
866) was 0x00000002, so next happened to be 0xFFFFFFE2, and then it
died when context_switch() tried to access next->mm :-( No idea how 0x000002
happened to be in queue->next.

Another explanation is that rq->idle was 0xFFFFFFE2, and rq->nr_running
was 0. But it looks impossible too.

  Does anybody have any idea what's wrong? Crash happened few minutes
after boot. For now I reverted back to 2.5.21-changeset1.493, which 
works flawlessly.

  Box is running slapd (which invoked yield()) and grabs TV teletext
using bttv. Network card driver is e100. There should be always one
process ready to run: dnetc.
                                        Thanks,
                                            Petr Vandrovec
                                            vandrove@vc.cvut.cz
                                            
