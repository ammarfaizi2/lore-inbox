Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264454AbTLTMqg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Dec 2003 07:46:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264459AbTLTMqg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Dec 2003 07:46:36 -0500
Received: from moutng.kundenserver.de ([212.227.126.189]:5371 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S264454AbTLTMqe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Dec 2003 07:46:34 -0500
From: Hans-Peter Jansen <hpj@urpla.net>
To: Ethan Weinstein <lists@stinkfoot.org>, linux-kernel@vger.kernel.org
Subject: Re: minor e1000 bug
Date: Sat, 20 Dec 2003 13:46:27 +0100
User-Agent: KMail/1.5.4
References: <3FE3623D.9000706@stinkfoot.org>
In-Reply-To: <3FE3623D.9000706@stinkfoot.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200312201346.27044.hpj@urpla.net>
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:18d01dd0a2a377f0376b761557b5e99a
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ethan,

On Friday 19 December 2003 21:40, Ethan Weinstein wrote:
> I've noticed that the e1000 driver does not update the counters in
> /proc/net/dev as quickly as several other drivers I've tried, such
> as e100 (both the Becker driver, and Intel's), sk90lin, and 3c59x.
> These drivers seem to update the counters in a very timely fashion
> while the e1000 driver doesn't seem to update them for several
> seconds.  This is apparent in 2.6.0, and 2.4.xx. Is there an update

Every 2 seconds exactly.

I would also be interested in a statement from intel fellows on the 
reasoning behind this decision, since every user of gkrellm will 
notice some strange behaviour (value oscillating between 0 and 
throughput * 2). (Poor man's real time bandwidth management ;-). 

After being tired of cognitive interpretation of these values, I 
decided to fix it, which was pretty easy:

--- linux-2.4.20/drivers/net/e1000/e1000_main.c~    2003-08-03 00:40:21.000000000 +0200
+++ linux-2.4.20/drivers/net/e1000/e1000_main.c 2003-08-08 13:20:06.000000000 +0200
@@ -1390,7 +1390,7 @@
        netif_stop_queue(netdev);
 
    /* Reset the timer */
-   mod_timer(&adapter->watchdog_timer, jiffies + 2 * HZ);
+   mod_timer(&adapter->watchdog_timer, jiffies + HZ);
 }
 
 #define E1000_TX_FLAGS_CSUM        0x00000001


> interval that might be modified within the driver to fix this?  It
> screws up realtime bandwidth measurements for these cards.
>
>
> -Ethan

Enjoy,
Pete

