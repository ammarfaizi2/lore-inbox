Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267170AbTAFVZq>; Mon, 6 Jan 2003 16:25:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267174AbTAFVZq>; Mon, 6 Jan 2003 16:25:46 -0500
Received: from navgwout.symantec.com ([198.6.49.12]:27560 "EHLO
	navgwout.symantec.com") by vger.kernel.org with ESMTP
	id <S267170AbTAFVZn>; Mon, 6 Jan 2003 16:25:43 -0500
To: Anton Blanchard <anton@samba.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Gigabit/SMP performance problem
MIME-Version: 1.0
X-Mailer: Lotus Notes Release 5.0.9a  January 7, 2002
Message-ID: <OFAB3BBE62.009CD13E-ON85256CA6.00714931-85256CA6.00718BA3@symantec.com>
From: "Avery Fay" <avery_fay@symantec.com>
Date: Mon, 6 Jan 2003 15:38:42 -0500
X-MIMETrack: Serialize by Router on USCU-SMTPOB01-1/GLOBE-ADMIN/SYMANTEC(Release 5.0.11
  |July 24, 2002) at 01/06/2003 12:48:41 PM,
	Serialize complete at 01/06/2003 12:48:41 PM
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hmm. That paper is actually very interesting. I'm thinking maybe with the 
P4 I'm better off with only 1 cpu. WRT hyperthreading, I actually disabled 
it because it make performance worse (wasn't clear in the original email).

Avery Fay





Anton Blanchard <anton@samba.org>
01/03/2003 10:33 PM

 
        To:     Avery Fay <avery_fay@symantec.com>
        cc:     linux-kernel@vger.kernel.org
        Subject:        Re: Gigabit/SMP performance problem


 
> I'm working with a dual xeon platform with 4 dual e1000 cards on 
different 
> pci-x buses. I'm having trouble getting better performance with the 
second 
> cpu enabled (ht disabled). With a UP kernel (redhat's 2.4.18), I can 
route 
> about 2.9 gigabits/s at around 90% cpu utilization. With a SMP kernel 
> (redhat's 2.4.18), I can route about 2.8 gigabits/s with both cpus at 
> around 90% utilization. This suggests to me that the network code is 
> serialized. I would expect one of two things from my understanding of 
the 
> 2.4.x networking improvements (softirqs allowing execution on more than 
> one cpu):

The Fujitsu guys have a nice summary of this:

http://www.labs.fujitsu.com/en/techinfo/linux/lse-0211/index.html

Skip forward to page 8.

Dont blame the networking code just yet :) Notice how worse UP vs SMP
performance is on the P4 compared to the P3?

This brings up another point, is a single CPU with hyperthreading worth
it? As Rusty will tell you, you need to compare it with a UP kernel
since it avoids all the locking overhead. I suspect for a lot of cases
HT will be a loss (imagine your case, comparing UP and one CPU HT)

Anton



