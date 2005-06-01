Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261512AbVFAXu7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261512AbVFAXu7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 19:50:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261453AbVFAXsN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 19:48:13 -0400
Received: from ylpvm15-ext.prodigy.net ([207.115.57.46]:38785 "EHLO
	ylpvm15.prodigy.net") by vger.kernel.org with ESMTP id S261499AbVFAXoE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 19:44:04 -0400
X-ORBL: [69.107.40.98]
From: David Brownell <david-b@pacbell.net>
To: Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: External USB2 HDD affects speed hda
Date: Wed, 1 Jun 2005 16:43:41 -0700
User-Agent: KMail/1.7.1
Cc: Pavel Machek <pavel@ucw.cz>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Linux Kernel <linux-kernel@vger.kernel.org>, Mark Lord <lkml@rtr.ca>,
       David Brownell <dbrownell@users.sourceforge.net>
References: <429BA001.2030405@keyaccess.nl> <429E3338.9000401@keyaccess.nl> <429E37BA.7090502@keyaccess.nl>
In-Reply-To: <429E37BA.7090502@keyaccess.nl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506011643.42073.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 01 June 2005 3:33 pm, Rene Herman wrote:
> Rene Herman wrote:
> 
> > David Brownell wrote:
> 
> >> The experiment: verify that only the RUN bit is set on your machine
> >> too. If "Periodic" and/or "Async" bits are set, then the controller
> >> is _supposed_ to be issuing DMA transfers over PCI, so less bandwidth
> >> will be available. Otherwise, not.
> 
> [ snip ]
> 
> > and one after switching on the USB2 HDD, when the hdparm result for hda 
> > has dropped to 42 MB/s:
> > 
> > ===
> > bus pci, device 0000:00:09.2 (driver 10 Dec 2004)
> > EHCI 1.00, hcd state 1
> > structural params 0x00002204
> > capability params 0x00006872
> > status a008 Async Recl FLR
> 
> Only see that "Async" now while rereading. Did you mean that one? If so, 
> I'm right now catting the registers file and that "Async" is toggling on 
> and off continuously. 4 cats in a row:
> 
> status 0008 FLR
> status 8008 Async FLR
> status a008 Async Recl FLR
> status 0008 FLR

Tbat's strange ... shouldn't do that unless someone's issuing
requests to the bus.  Which shouldn't happen if no devices are
hooked up to that bus.  If the "command" register isn't turning
on async requests, that's particularly strange.

- Dave

