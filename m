Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266028AbUHCMel@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266028AbUHCMel (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Aug 2004 08:34:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265792AbUHCMel
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Aug 2004 08:34:41 -0400
Received: from posti6.jyu.fi ([130.234.4.43]:51133 "EHLO posti6.jyu.fi")
	by vger.kernel.org with ESMTP id S266128AbUHCMdE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Aug 2004 08:33:04 -0400
Date: Tue, 3 Aug 2004 15:32:15 +0300 (EEST)
From: Pasi Sjoholm <ptsjohol@cc.jyu.fi>
X-X-Sender: ptsjohol@silmu.st.jyu.fi
To: Francois Romieu <romieu@fr.zoreil.com>
cc: Robert Olsson <Robert.Olsson@data.slu.se>,
       H?ctor Mart?n <hector@marcansoft.com>,
       Linux-Kernel <linux-kernel@vger.kernel.org>, <akpm@osdl.org>,
       <netdev@oss.sgi.com>, <brad@brad-x.com>, <shemminger@osdl.org>
Subject: Re: ksoftirqd uses 99% CPU triggered by network traffic (maybe
 RLT-8139 related)
In-Reply-To: <20040803003515.A29885@electric-eye.fr.zoreil.com>
Message-ID: <Pine.LNX.4.44.0408031523220.32102-100000@silmu.st.jyu.fi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
X-Spam-Checked: by miltrassassin
	at posti6.jyu.fi; Tue, 03 Aug 2004 15:32:21 +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Aug 2004, Francois Romieu wrote:

> I have made a few changes. Please enable the DEBUG option and set msglvl
> to its maximal value via ethtool. You may test the patches separately if
> you find some time but the log once both r8139-10.patch and r8139-20.patch
> are applied would be enough.

The full logfiles can be downloaded from:

http://www.cc.jyu.fi/~ptsjohol/syslog1.gz 
http://www.cc.jyu.fi/~ptsjohol/syslog2.gz 

The first log file is with both patchs applied and the second one with one 
little change to rx8139_rx() to show if it even goes to through 

"        while (netif_running(dev) && received < budget
               && (RTL_R8 (ChipCmd) & RxBufEmpty) == 0) {"-section.

This was the change which I made.. so you can see in the second log file 
that there won't be any of these messages after the driver has crashed. 

/*              if (netif_msg_rx_status(tp))*/
        printk(KERN_DEBUG "%s:  rtl8139_rx() status %4.4x, size %4.4x,"
        " cur %4.4x.\n", dev->name, rx_status, rx_size, cur_rx);

For the first logfile the exact crash time is "13:02:22" and the for the 
second one it is "14:54:49".

> If the log fills too fast, you may comment out any message which does
> not belong to rtl8139_rx().

I took out those "exiting with interrupt"-messages.

--
Pasi Sjöholm

