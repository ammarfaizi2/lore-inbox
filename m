Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264305AbTLVF0h (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Dec 2003 00:26:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264308AbTLVF0h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Dec 2003 00:26:37 -0500
Received: from fmr05.intel.com ([134.134.136.6]:45460 "EHLO
	hermes.jf.intel.com") by vger.kernel.org with ESMTP id S264305AbTLVF0e convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Dec 2003 00:26:34 -0500
Content-Class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: RE: minor e1000 bug
Date: Sun, 21 Dec 2003 21:26:25 -0800
Message-ID: <C6F5CF431189FA4CBAEC9E7DD5441E0102CBDD71@orsmsx402.jf.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: minor e1000 bug
Thread-Index: AcPG96/Azd/kC1fcSY6Keqn3Tr+uNwBU4WOA
From: "Feldman, Scott" <scott.feldman@intel.com>
To: "Hans-Peter Jansen" <hpj@urpla.net>,
       "Ethan Weinstein" <lists@stinkfoot.org>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 22 Dec 2003 05:26:25.0899 (UTC) FILETIME=[24EB83B0:01C3C84C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I would also be interested in a statement from intel fellows on the 
> reasoning behind this decision, since every user of gkrellm will 
> notice some strange behaviour (value oscillating between 0 and 
> throughput * 2). (Poor man's real time bandwidth management ;-). 
> 
> After being tired of cognitive interpretation of these values, I 
> decided to fix it, which was pretty easy:
> 
> --- linux-2.4.20/drivers/net/e1000/e1000_main.c~    
> 2003-08-03 00:40:21.000000000 +0200
> +++ linux-2.4.20/drivers/net/e1000/e1000_main.c 2003-08-08 
> +++ 13:20:06.000000000 +0200
> @@ -1390,7 +1390,7 @@
>         netif_stop_queue(netdev);
>  
>     /* Reset the timer */
> -   mod_timer(&adapter->watchdog_timer, jiffies + 2 * HZ);
> +   mod_timer(&adapter->watchdog_timer, jiffies + HZ);
>  }

That should be OK if you're not linked at half duplex or using a 82541/7
Ethernet controller.  e1000_smartspeed() and e1000_adaptive_ifs() are
sensitive to the watchdog interval, so we'll need to make sure those are
OK before adjusting the timer from 2 to 1 seconds.  This issue is
tracker here: http://bugme.osdl.org/show_bug.cgi?id=1192.

-scott
