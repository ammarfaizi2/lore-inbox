Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129764AbQLKEpp>; Sun, 10 Dec 2000 23:45:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129737AbQLKEpf>; Sun, 10 Dec 2000 23:45:35 -0500
Received: from smtp01.mrf.mail.rcn.net ([207.172.4.60]:34188 "EHLO
	smtp01.mrf.mail.rcn.net") by vger.kernel.org with ESMTP
	id <S129847AbQLKEp0>; Sun, 10 Dec 2000 23:45:26 -0500
Message-ID: <3A3454BE.352FDB96@haque.net>
Date: Sun, 10 Dec 2000 23:14:54 -0500
From: "Mohammad A. Haque" <mhaque@haque.net>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-test12 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Miles Lane <miles@megapathdsl.net>
CC: Frank Davis <fdavis112@juno.com>, linux-kernel@vger.kernel.org
Subject: Re: INIT_LIST_HEAD marco audit
In-Reply-To: <390158470.976495326591.JavaMail.root@web346-wra.mail.com> <3A3441FC.28A2D2CA@haque.net> <3A344EFA.1CD056C@megapathdsl.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Does this look right to people?

--- linux-2.4.0-test12.old/drivers/pcmcia/tcic.c	Sun Nov 19 21:56:30
2000
+++ linux-2.4.0-test12/drivers/pcmcia/tcic.c	Sun Dec 10 23:00:07 2000
@@ -548,8 +548,9 @@
 	}
 }
 
-static struct tq_struct tcic_task = {
-	routine:	tcic_bh
+DECLARE_TASK_QUEUE(tcic_task);
+struct tq_struct run_tcic_task = {
+	routine:	(void (*)(void *)) tcic_bh
 };
 
 static void tcic_interrupt(int irq, void *dev, struct pt_regs *regs)
--- linux-2.4.0-test12.old/drivers/pcmcia/i82365.c	Sun Nov 19 21:56:30
2000
+++ linux-2.4.0-test12/drivers/pcmcia/i82365.c	Sun Dec 10 23:06:01 2000
@@ -877,8 +877,9 @@
 	}
 }
 
-static struct tq_struct pcic_task = {
-	routine:	pcic_bh
+DECLARE_TASK_QUEUE(pcic_task);
+struct tq_struct run_pcic_task = {
+	routine:	(void (*)(void *)) pcic_bh
 };
 
 static void pcic_interrupt(int irq, void *dev,

Miles Lane wrote:
> Would someone who knows what to do send out a patch for
> these two drivers?
> 
>         drivers/pcmcia/i82365.c
>         drivers/pcmcia/tcic.c

-- 

=====================================================================
Mohammad A. Haque                              http://www.haque.net/ 
                                               mhaque@haque.net

  "Alcohol and calculus don't mix.             Project Lead
   Don't drink and derive." --Unknown          http://wm.themes.org/
                                               batmanppc@themes.org
=====================================================================
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
