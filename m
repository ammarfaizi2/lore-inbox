Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267145AbTAFVRx>; Mon, 6 Jan 2003 16:17:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267146AbTAFVRx>; Mon, 6 Jan 2003 16:17:53 -0500
Received: from navgwout.symantec.com ([198.6.49.12]:36077 "EHLO
	navgwout.symantec.com") by vger.kernel.org with ESMTP
	id <S267145AbTAFVRv>; Mon, 6 Jan 2003 16:17:51 -0500
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Gigabit/SMP performance problem
MIME-Version: 1.0
X-Mailer: Lotus Notes Release 5.0.9a  January 7, 2002
Message-ID: <OF56E8EAC6.7DEBE879-ON85256CA6.007042A6-85256CA6.0070AD35@symantec.com>
From: "Avery Fay" <avery_fay@symantec.com>
Date: Mon, 6 Jan 2003 15:29:13 -0500
X-MIMETrack: Serialize by Router on USCU-SMTPOB01-1/GLOBE-ADMIN/SYMANTEC(Release 5.0.11
  |July 24, 2002) at 01/06/2003 12:39:11 PM,
	Serialize complete at 01/06/2003 12:39:11 PM
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Well, judging by the fact that a UP kernel can route more traffic (and 
consequently more interrupts p/s) than an SMP kernel, I think that one cpu 
can probably handle all of the interrupts. Really the issue I'm trying to 
solve is not routing performance, but rather the fact that SMP routing 
performance is worse while using twice the cpu time (2 cpu's at around 95% 
vs. 1 at around 95%).

Avery Fay





"Martin J. Bligh" <mbligh@aracnet.com>
01/03/2003 04:36 PM

 
        To:     Avery Fay <avery_fay@symantec.com>
        cc:     linux-kernel@vger.kernel.org
        Subject:        Re: Gigabit/SMP performance problem


P3's distributed interrupts round-robin amongst cpus. P4's send 
everything to CPU 0. If you put irq_balance on, it'll spread
them around, but any given interrupt is still only handled by
one CPU (as far as I understand the code). If you hammer one
adaptor, does that generate more interrupts than 1 cpu can handle?
(turn irq balance off by sticking a return at the top of balance_irq,
and hammer one link, see how much CPU power that burns).

M.



