Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750955AbVKUUGc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750955AbVKUUGc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 15:06:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751045AbVKUUGc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 15:06:32 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:28396 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1750948AbVKUUGb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 15:06:31 -0500
Subject: Re: [BUG] 2.6.15-rc1, soft lockup detected while probing IDE
	devices on AMD7441
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andrew Morton <akpm@osdl.org>
Cc: shurick@sectorb.msk.ru, linux-kernel@vger.kernel.org
In-Reply-To: <20051120172915.31754054.akpm@osdl.org>
References: <20051120204656.GA17242@shurick.s2s.msu.ru>
	 <1132528033.459.12.camel@localhost.localdomain>
	 <20051120172915.31754054.akpm@osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 21 Nov 2005 20:38:44 +0000
Message-Id: <1132605524.11842.38.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2005-11-20 at 17:29 -0800, Andrew Morton wrote:
> Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> > Quite normal. The old IDE probe code takes a long time and it makes the
> > soft lockup code believe a lockup occurred - rememeber its a debugging
> > tool not a 100% reliable detector of failures.
> > 
> 
> We could put a touch_softlockup_watchdog() in there.

Would make sense. Spin up and probe can take over 30 seconds worst case
and is polled in the IDE world. The loop will eventually exit and a true
lockup caused by a stuck IORDY line will hang forever in an inb/outb so
neither softlockup or even nmi lockup would save you.

