Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261945AbTHaJ7T (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Aug 2003 05:59:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262249AbTHaJ7T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Aug 2003 05:59:19 -0400
Received: from smtp1.fre.skanova.net ([195.67.227.94]:36056 "EHLO
	smtp1.fre.skanova.net") by vger.kernel.org with ESMTP
	id S261945AbTHaJ7S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Aug 2003 05:59:18 -0400
Subject: Re: 2.6.0-test4: uhci-hcd.c: "host controller process error", slab
	call trace
From: Fredrik Noring <noring@nocrew.org>
To: Duncan Sands <baldrick@wanadoo.fr>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Alan Stern <stern@rowland.harvard.edu>,
       Johannes Erdfelt <johannes@erdfelt.com>,
       linux-usb-devel@lists.sourceforge.net
In-Reply-To: <200308310136.02093.baldrick@wanadoo.fr>
References: <1062281812.3378.50.camel@h9n1fls20o980.bredband.comhem.se>
	 <200308310136.02093.baldrick@wanadoo.fr>
Content-Type: text/plain; charset=ISO-8859-1
Organization: NoCrew
Message-Id: <1062323761.3036.31.camel@h9n1fls20o980.bredband.comhem.se>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Sun, 31 Aug 2003 11:56:01 +0200
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

sön 2003-08-31 klockan 01.36 skrev Duncan Sands:
> Does the attached patch help?

Yes, I did some quick tests and the "host controller" error appears to
be gone. Thanks! There are a few other problems, probably unrelated to
this patch:

1. Broadcom Bluetooth USB device initialization is unreliable. When it
   fails, the following is logged. Rebooting the system and trying again
   helps.

 /etc/hotplug/usb.agent: Setup bluefw for USB product a5c/2033/a0
 /etc/hotplug/usb.agent: Module setup bluefw for USB product a5c/2033/a0
 bluefw[3079]: Loading firmware to usb device 0a5c:2033
 kernel: usb 1-2: bulk timeout on ep1in
 bluefw[3079]: Intr read #1 failed. Connection timed out (110)
 usbfs: USBDEVFS_BULK failed dev 3 ep 0x81 len 10 ret -110

2. The system sometimes locks up in a complete freeze when an external
   Bluetooth device tries to connect. I'm not sure what happens and the
   only message I've seen is this and it might be unrelated:

 dund[3932]: MSDUN failed. Protocol error(71)

3. The following messages are still logged:

 kernel: l2cap_recv_acldata: Frame is too short (len 1)
 kernel: l2cap_recv_acldata: Unexpected continuation frame (len 124)
 kernel: l2cap_recv_acldata: Unexpected continuation frame (len 102)

	Fredrik


