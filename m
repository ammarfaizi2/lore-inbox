Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267338AbUJVUHN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267338AbUJVUHN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 16:07:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267370AbUJVUGr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 16:06:47 -0400
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:42148
	"EHLO debian.tglx.de") by vger.kernel.org with ESMTP
	id S267338AbUJVUDT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 16:03:19 -0400
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-rc4-mm1-U9.3
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Mark_H_Johnson@raytheon.com
Cc: Bill Huey <bhuey@lnxw.com>, Adam Heath <doogie@debian.org>,
       "K.R. Foley" <kr@cybsft.com>, LKML <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>, Florian Schmidt <mista.tapas@gmx.net>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Lee Revell <rlrevell@joe-job.com>, Rui Nuno Capela <rncbc@rncbc.org>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
In-Reply-To: <OF86131D2C.7F017684-ON86256F35.006C000C@raytheon.com>
References: <OF86131D2C.7F017684-ON86256F35.006C000C@raytheon.com>
Content-Type: text/plain
Organization: linutronix
Date: Fri, 22 Oct 2004 21:55:15 +0200
Message-Id: <1098474915.3306.18.camel@thomas>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-10-22 at 14:40 -0500, Mark_H_Johnson@raytheon.com wrote:
> >No, the fix was for the missing pci shutdown in tulip.
> I thought the two were related (since I get the failed to shutdown
> message right after that traceback. Perhaps the 8139too needs
> that same shutdown fix.

The shutdown fix is neccecary, but it is not related to the other
problem. The shutdown message will also happen , if you unload the
module manualy. The patch below fixes only the shutdown warning. For the
other one I need more information.

tglx

---

diff -urN --exclude='*~' 2.6.9-mm1-U10/drivers/net/8139too.c
2.6.9-mm1-U10.work/drivers/net/8139too.c
--- 2.6.9-mm1-U10/drivers/net/8139too.c	2004-10-22 19:10:44.000000000
+0200
+++ 2.6.9-mm1-U10.work/drivers/net/8139too.c	2004-10-22
21:52:19.000000000 +0200
@@ -749,7 +749,7 @@
 	pci_release_regions (pdev);
 
 	free_netdev(dev);
-
+	pci_disable_dev (pdev);
 	pci_set_drvdata (pdev, NULL);
 }
 



