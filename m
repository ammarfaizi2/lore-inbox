Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261411AbTK3WW1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Nov 2003 17:22:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261567AbTK3WW0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Nov 2003 17:22:26 -0500
Received: from pa208.myslowice.sdi.tpnet.pl ([213.76.228.208]:51075 "EHLO
	finwe.eu.org") by vger.kernel.org with ESMTP id S261411AbTK3WWZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Nov 2003 17:22:25 -0500
Date: Sun, 30 Nov 2003 23:22:22 +0100
From: Jacek Kawa <jfk@zeus.polsl.gliwice.pl>
To: Steve Youngs <sryoungs@bigpond.net.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test11 -- Failed to open /dev/ttyS0: No such device
Message-ID: <20031130222222.GA11809@finwe.eu.org>
Mail-Followup-To: Steve Youngs <sryoungs@bigpond.net.au>,
	linux-kernel@vger.kernel.org
References: <20031130071757.GA9835@node1.opengeometry.net> <20031130102351.GB10380@outpost.ds9a.nl> <20031130113656.GA28437@finwe.eu.org> <microsoft-free.87ekvpc0ms.fsf@eicq.dnsalias.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <microsoft-free.87ekvpc0ms.fsf@eicq.dnsalias.org>
Organization: Kreatorzy Kreacji Bialej
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steve Youngs wrote:

>   JK> bert hubert wrote:
>   >>> Does anyone have modem working in 2.6.0-test11?
>   >>> I have external modem connected to /dev/ttyS0 (COM1).  Kernel
>   >>> 2.6.0-test11 give me

>   JK> It reminds me, that I had to add serial to the list of modules
>   JK> loading at start to get back access to /dev/ttyS* 
>   JK> (while upgrading from -test9 to -test10). 

> I _think_ this patch will bring back auto-loading of the serial module
> for you.  Please let me know how it goes. 

Well: patched, installed new serial_core.ko, then depmod -a, and try to
access ttySwhatever.

I don't see any difference... If I understood correctly, it could not load 
my 'fake' serial module anyway (?)

BTW. only changes,I think could affect serial directly and
     made betwen test9 and test10 are:

diff -Nru a/drivers/serial/serial_core.c b/drivers/serial/serial_core.c
--- a/drivers/serial/serial_core.c	Sun Nov 23 17:33:38 2003
+++ b/drivers/serial/serial_core.c	Sun Nov 23 17:33:38 2003
@@ -1707,6 +1707,9 @@
 		strcat(stat_buf, "\n");
 	
 		ret += sprintf(buf + ret, stat_buf);
+	} else {
+		strcat(buf, "\n");
+		ret++;
 	}
 #undef STATBIT
 #undef INFOBIT

diff -Nru a/include/linux/serial.h b/include/linux/serial.h
--- a/include/linux/serial.h	Sun Nov 23 17:33:38 2003
+++ b/include/linux/serial.h	Sun Nov 23 17:33:38 2003
@@ -49,7 +49,6 @@
 	unsigned short	iomem_reg_shift;
 	unsigned int	port_high;
 	unsigned long	iomap_base;	/* cookie passed into ioremap */
-	int	reserved[1];
 };
 
 /*

I could try to narrow it down to some -bk, but it will take time...

PS. I wonder - could it be, that somewhere in the middle of 
    decision process test9 > test10 (as test1something)

bye

-- 
Jacek Kawa  **Oh, Lord, bless this thy hand grenade that with it thou
              mayest blow thy enemies to tiny bits, in thy mercy.**
