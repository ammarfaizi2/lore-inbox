Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266511AbUIWPJN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266511AbUIWPJN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 11:09:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266513AbUIWPIz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 11:08:55 -0400
Received: from lirs02.phys.au.dk ([130.225.28.43]:14565 "EHLO
	lirs02.phys.au.dk") by vger.kernel.org with ESMTP id S266274AbUIWPIu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 11:08:50 -0400
Date: Thu, 23 Sep 2004 17:08:47 +0200 (METDST)
From: Esben Nielsen <simlo@phys.au.dk>
To: linux-net@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: ArcNet and 2.6.8.1
Message-Id: <Pine.OSF.4.05.10409231534150.5114-100000@da410.ifa.au.dk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-DAIMI-Spam-Score: 0 () 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
 I am trying to upgrade my labtop to 2.6.8.1. I have ArcNet COM20020
PCMCIA card. After editing /etc/pcmcia/config to make it know about the
module, it finds the com20020 with no problems but as soon as I try to
start the network device the ifconfig process crashes.

I have looked a bit at the code and compared it to 2.4.20 which I used
before (with my own patches which I have sent here to - among other things
- to make com20020_cs work). 

Somebody (how do I find out whom???)  have made an open function pointer 
instead  of the old open_close function pointer. The generic ArcNet
framework calls this function pointer into the more specialized drivers
when you start your device. But none of the specialized drivers do never
initialize the function pointer! I.e. when you start your arcnet device
you get a call to 0x0!

I fixed it by changing
	lp->hw.open(dev);
to
	if(lp->hw.open) {
		lp->hw.open(dev);
	}


Esben



