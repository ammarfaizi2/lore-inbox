Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315178AbSGGKdx>; Sun, 7 Jul 2002 06:33:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315278AbSGGKdw>; Sun, 7 Jul 2002 06:33:52 -0400
Received: from ftp.realnet.co.sz ([196.28.7.3]:6323 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S315178AbSGGKdv>; Sun, 7 Jul 2002 06:33:51 -0400
Date: Sun, 7 Jul 2002 12:54:28 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@linux-box.realnet.co.sz
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Martin Dalecki <dalecki@evision-ventures.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: ide__sti usage
Message-ID: <Pine.LNX.4.44.0207071253190.1441-100000@linux-box.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bart, Martin
	I'm seeing a number of deadlocks, most of them due to ide__sti 
enabling interrupts in a critical section which needs to be protected 
against interrupts too.

Another dangerous scenario is the following, from here the usage of 
ide__sti becomes questionable.

queue_commands() {
	ide__sti();
	start_request();
}
...
start_request() {
	spin_unlock_irq();
	frob_ide();
	spin_lock_irq();
}

and also;

if (ch->unmask)
	ide__sti();	/* local CPU only */

/* service this interrupt, may set handler for next interrupt */
startstop = handler(drive, drive->rq);
spin_lock_irq(ch->lock);

If someone can explain to me what ide__sti really is trying to achieve 
i'd greatly appreciate it.

Regards,
	Zwane Mwaikambo

-- 
function.linuxpower.ca

