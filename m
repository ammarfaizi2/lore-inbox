Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262241AbUKAPga@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262241AbUKAPga (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Nov 2004 10:36:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268126AbUKAPga
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Nov 2004 10:36:30 -0500
Received: from inetc.connecttech.com ([64.7.140.42]:49160 "EHLO
	inetc.connecttech.com") by vger.kernel.org with ESMTP
	id S267423AbUKAPMx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Nov 2004 10:12:53 -0500
From: "Stuart MacDonald" <stuartm@connecttech.com>
To: "'Paul Fulghum'" <paulkf@microgate.com>, <tytso@mit.edu>
Cc: "'Alan Cox'" <alan@lxorguk.ukuu.org.uk>,
       "'Russell King'" <rmk+lkml@arm.linux.org.uk>,
       "'Linux Kernel Mailing List'" <linux-kernel@vger.kernel.org>
Subject: RE: [BUG][2.6.8.1] serial driver hangs SMP kernel, but not the UPkernel
Date: Mon, 1 Nov 2004 10:12:38 -0500
Organization: Connect Tech Inc.
Message-ID: <002a01c4c025$39f22530$294b82ce@stuartm>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.4510
In-Reply-To: <418643E2.9080006@microgate.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paul Fulghum [mailto:paulkf@microgate.com] 
> Stuart MacDonald wrote:
> > I always thought the whole point of low_latency was to make the
> > receive-path very fast, which means specifically allowing the flip
> > routine to run from the ISR. So checking for calling from 
> the ISR and
> > specifically disallowing that is basically negating the 
> entire raison
> > d'etre for low_latency.
> 
> I was thought it was to speed processing if the
> caller was already in process context. Maybe the
> real intentions are lost to history.

Best person to ask may be Ted; he was once the serial maintainer. Ted?

> Moving forward, Alan stated that the flip
> routine should not be called in interrupt context.
> His last post concerning some transient state
> of low_latency has confused me.

I didn't follow that either, but I wasn't reading too closely.

> Currently, with the 8250 driver and N_TTY
> line discipline, calling the flip routine from
> ISR causes an SMP deadlock. There are two paths that
> cause this:
> 1. low_latency is set
> 2. flip buffer becomes full
> 
> So calling the flip routine from the ISR may work
> with some specific drivers, but it would be
> dangerous to assume this works in all cases.

I haven't looked at the 2.6 serial rewrite in depth yet, but the
problem always existed in the 2.4 driver. I got around the problem by
checking for interrupt context and taking the locks or not at a much
earlier stage.

..Stu
www.connecttech.com

