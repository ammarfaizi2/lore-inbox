Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269660AbTGRQGl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 12:06:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267363AbTGRQFj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 12:05:39 -0400
Received: from mta06-svc.ntlworld.com ([62.253.162.46]:30109 "EHLO
	mta06-svc.ntlworld.com") by vger.kernel.org with ESMTP
	id S271841AbTGRPgV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 11:36:21 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: SA <bullet.train@ntlworld.com>
To: linux-kernel@vger.kernel.org
Subject: Missing interrupts?
Date: Fri, 18 Jul 2003 16:51:21 +0100
User-Agent: KMail/1.4.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200307181651.21730.bullet.train@ntlworld.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Dear LK,

I am testing a new device driver and have found that one one machine it does not receive any interrupts.  
I am stumped by this problem and wonder if anyone had any advice before I start to take things apart blindly.

Machines test where everything worked: kernels 2.4.18-10 and  2.4.18-24.8.0 on athlon based PCs

Machine where interrupts failed to appear: kernel 2.4.18-3 on a pentium 4.

I register the interrupt on open with 
        err=request_irq(pi_stage.interrupt,pi_int_handler,SA_SHIRQ,PI_IRQ_ID,(void*)&pi_stage);

My handler looks like

static void pi_int_handler(int irq, void *dev_id,struct pt_regs *regs){
u32 event;
        pi_stage.ints_all++;
        event=pi_read_control(PI_STAGE_INTEVENTSET);
        if(event & PI_STAGE_ALLINTS){
                pi_write_control(PI_STAGE_INTEVENTCLEAR,event  &PI_STAGE_ALLINTS);
                 if(event & PI_STAGE_INTGPIO3)
                        pi_stage.ints_io++;
                if(event & PI_STAGE_GPINT){
                        pi_stage.ints_axis++;
                        tasklet_schedule(&pi_tasklet);
                        }
                pi_stage.ints_board++;
                }
        }

On the dodgy machine I see the driver and card working fine except for the missing interrupts.
The variable pi_stage.ints_all is never incremented and /proc/interrupts never reports any interrupts.
On all machines the conditions that generate the interrupts do occur.

It looks like on this one machine that interrupts are never received by the system.

Is it possible that differences between the BIOSs on the machines could cause this?
(ie my card is init'd differently so on the bad machine the ints are never generated or
received).

Any suggestions?

Thanks SA
