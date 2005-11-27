Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751156AbVK0VRL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751156AbVK0VRL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Nov 2005 16:17:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751152AbVK0VRL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Nov 2005 16:17:11 -0500
Received: from gate.crashing.org ([63.228.1.57]:34198 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1751151AbVK0VRJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Nov 2005 16:17:09 -0500
Subject: Re: What are the general causes of frozen system?
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Larry Finger <Larry.Finger@lwfinger.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <43891D97.4000404@lwfinger.net>
References: <43891D97.4000404@lwfinger.net>
Content-Type: text/plain
Date: Mon, 28 Nov 2005 08:11:51 +1100
Message-Id: <1133125912.7768.120.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-11-26 at 20:44 -0600, Larry Finger wrote:
> I am trying to help the bcm43xx project develop a driver for the 
> Broadcom 43xx wireless chips, using my Linksys WPC54G card. 
> Unfortunately, since the group got far enough to turn on RX DMA, my 
> system has frozen whenever I load the driver. TX DMA was OK. It seems to 
> correlate with the receipt of a beacon from my AP, but that cannot be 
> proven. When the freeze happens, I cannot do anything more and have to 
> power the system off.
> 
> What should I consider as a cause of the freeze? I have reviewed the 
> code and do not find any obvious out-of-bounds memory references. I have 
> tried various 'printk' statements, but none of them in the bottom-half 
> interrupt routine make it to the logs. Are there any tricks that I 
> should try?

spinlock debugging is one... if it's a bad DMA to low memory, you can't
do much. Another common cause is a stale interrupt, is your IRQ handler
called over & over again in a loop ?

The problem is that depending on what you are interrupting, printk may
not work ...

Ben.


