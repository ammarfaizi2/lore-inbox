Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315413AbSEUVxW>; Tue, 21 May 2002 17:53:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315447AbSEUVxV>; Tue, 21 May 2002 17:53:21 -0400
Received: from 12-224-36-73.client.attbi.com ([12.224.36.73]:24838 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S315413AbSEUVxT>;
	Tue, 21 May 2002 17:53:19 -0400
Date: Tue, 21 May 2002 14:52:17 -0700
From: Greg KH <greg@kroah.com>
To: mingo@redhat.com, linux-kernel@vger.kernel.org
Subject: [PATCH] 2.5.17 fix for running a SMP kernel on a UP box
Message-ID: <20020521215217.GA3784@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.26i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Tue, 23 Apr 2002 20:47:59 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I can't seem to run a SMP 2.5.17 kernel on a UP machine, it locks up
during the boot process.  In talking to Jack Vogel, he suggested I make
the following patch, which seems to solve the problem for me.  In
looking at the code, I have no idea of why this seems to work, so there
probably is a better fix out there.

Any suggestions?

thanks,

greg k-h



diff -Nru a/arch/i386/kernel/io_apic.c b/arch/i386/kernel/io_apic.c
--- a/arch/i386/kernel/io_apic.c	Tue May 21 14:47:06 2002
+++ b/arch/i386/kernel/io_apic.c	Tue May 21 14:47:06 2002
@@ -205,7 +205,7 @@
 } ____cacheline_aligned irq_balance_t;
 
 static irq_balance_t irq_balance[NR_IRQS] __cacheline_aligned
-			= { [ 0 ... NR_IRQS-1 ] = { 1, 0 } };
+			= { [ 0 ... NR_IRQS-1 ] = { 0, 0 } };
 
 extern unsigned long irq_affinity [NR_IRQS];
 
