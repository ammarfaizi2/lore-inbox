Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272622AbRHaH05>; Fri, 31 Aug 2001 03:26:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272623AbRHaH0r>; Fri, 31 Aug 2001 03:26:47 -0400
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:37108 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id <S272622AbRHaH0k>; Fri, 31 Aug 2001 03:26:40 -0400
Date: Fri, 31 Aug 2001 16:26:50 +0900
Message-ID: <k7zksn9h.wl@nisaaru.open.nm.fujitsu.co.jp>
From: Tachino Nobuhiro <tachino@open.nm.fujitsu.co.jp>
To: Hans-Christian Armingeon <johnny@allesklar.de>
Cc: linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: ieee1394 broken?
In-Reply-To: <01083023214304.00919@gundi>
In-Reply-To: <01083023214304.00919@gundi>
User-Agent: Wanderlust/2.7.2 (Too Funky) EMY/1.13.9 (Art is long, life is short) SLIM/1.14.7 () APEL/10.3 MULE XEmacs/21.1 (patch 14) (Cuyahoga Valley) (i586-kondara-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,

At Thu, 30 Aug 2001 23:21:43 +0200,
Hans-Christian Armingeon wrote:
> 
> Hi,
> my box (via kt133 thunderbird 1g 256mb 2.4.9-ac3) hangs completely up, when I 
> insert ohci1394.
> 
> Any suggestions?

  The same hang up occurred on my box too.  Following patch works for me.


diff -u -r linux.org/drivers/ieee1394/ohci1394.c linux/drivers/ieee1394/ohci1394.c
--- linux.org/drivers/ieee1394/ohci1394.c	Fri Aug 31 15:46:56 2001
+++ linux/drivers/ieee1394/ohci1394.c	Fri Aug 31 15:48:49 2001
@@ -488,6 +488,12 @@
 		mdelay(2);
 	}
 
+	/*
+	 * Delay after setting LPS in order to make sure link/phy
+	 * communication is established
+	 */
+	mdelay(10);   
+
 	/* Set the bus number */
 	reg_write(ohci, OHCI1394_NodeID, 0x0000ffc0);
 
