Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132746AbRDQQTM>; Tue, 17 Apr 2001 12:19:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132744AbRDQQTD>; Tue, 17 Apr 2001 12:19:03 -0400
Received: from [212.90.202.121] ([212.90.202.121]:54261 "HELO
	toe.terreactive.ch") by vger.kernel.org with SMTP
	id <S132743AbRDQQSx>; Tue, 17 Apr 2001 12:18:53 -0400
Message-ID: <3ADC6C70.1590D9B7@tac.ch>
Date: Tue, 17 Apr 2001 18:16:48 +0200
From: Roberto Nibali <ratz@tac.ch>
Organization: terreActive
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.4-pre1 i686)
X-Accept-Language: en, de-CH, zh-CN
MIME-Version: 1.0
To: Steve Hill <steve@navaho.co.uk>
CC: linux-kernel@vger.kernel.org, becker@scyld.com, maurizio.quadrio@polimi.it,
        harry@navaho.co.uk
Subject: Re: Fix for Donald Becker's DP83815 network driver (v1.07)
In-Reply-To: <Pine.LNX.4.21.0104171653110.4446-200000@sorbus.navaho>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steve Hill wrote:
> 
> The attached patch fixes the following problems with the DP83815 driver
> (natsemi.c):
> 
> 1. When compiled into the kernel, the cards would be registered multiple
> times.

I assume this code fragment fixes this:

+       static int done = 0;

+
+       if (done) return -ENODEV;
        if (pci_drv_register(&natsemi_drv_id, dev) < 0)
                return -ENODEV;
+       done = 1;

My 2 questions are: 
Is this an acceptable fix for Donald? Because if so, I'd like to submit it
for the starfire quardboard driver.

--- starfire.c-old	Tue Apr 17 18:11:07 2001
+++ starfire.c	Tue Apr 17 18:12:37 2001
@@ -378,8 +378,12 @@
 #ifndef MODULE
 int starfire_probe(struct net_device *dev)
 {
+	static int done = 0;
+
+	if (done) return -ENODEV;
 	if (pci_drv_register(&starfire_drv_id, dev) < 0)
 		return -ENODEV;
+	done = 1;
 	printk(KERN_INFO "%s" KERN_INFO "%s", version1, version2);
 	return 0;
 }

Is there no implication with PCI latencies if multiple such cards
are loaded? I'm still having problems initializing more then 4
Quadboards.

Regards,
Roberto Nibali, ratz

-- 
mailto: `echo NrOatSz@tPacA.cMh | sed 's/[NOSPAM]//g'`
