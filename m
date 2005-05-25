Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261186AbVEYVnz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261186AbVEYVnz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 May 2005 17:43:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261230AbVEYVnz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 May 2005 17:43:55 -0400
Received: from lirs02.phys.au.dk ([130.225.28.43]:36489 "EHLO
	lirs02.phys.au.dk") by vger.kernel.org with ESMTP id S261186AbVEYVni
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 May 2005 17:43:38 -0400
Date: Wed, 25 May 2005 23:43:27 +0200 (METDST)
From: Esben Nielsen <simlo@phys.au.dk>
To: Tom Vier <tmv@comcast.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: RT patch acceptance
In-Reply-To: <20050525212538.GC28913@zero>
Message-Id: <Pine.OSF.4.05.10505252331160.23201-100000@da410.phys.au.dk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 May 2005, Tom Vier wrote:

> On Wed, May 25, 2005 at 11:05:05PM +0200, Esben Nielsen wrote:
> > Long interrupt handlers can be interrupt by _tasks_, not only other
> > interrupts! An audio application running in userspace can be scheduled
> > over an ethernet interrupt handler copying data from the
> > controller into RAM (without DMA).
> 
> Doesn't that greatly increase the risk of the hardware overrunning it's
> buffer?

Hopefully you do not have much hardware on your PC you have to service
within very short timeframes without getting into serious trouble - if so
you need a RTOS :-) 
By not servicing you ethernet device you might loose packages - but the IP
protocols are supposed to handle that in the first place so there is no
real problem there. 
The whole point of putting it into threads is that you can decide which is
the most important: Your audio application or your slow ethernet 
device with no DMA. If the driver for the netcard is fast small enough,
run it with higher priority than your RT application, otherwise give it a
lower priority. Then if your RT application takes too much CPU you will
loose packages. You can't get both (without adding more CPUs). 
Without threading the ethernet device and giving it sufficient low
priority, somebody can DOS attack your RT application by spamming the
local network!

Esben

