Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932643AbWEXHlU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932643AbWEXHlU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 May 2006 03:41:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932645AbWEXHlU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 May 2006 03:41:20 -0400
Received: from www.osadl.org ([213.239.205.134]:38103 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S932643AbWEXHlT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 May 2006 03:41:19 -0400
Subject: Re: Ingo's  realtime_preempt patch causes kernel oops
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Daniel Walker <dwalker@mvista.com>
Cc: Yann.LEPROVOST@wavecom.fr, sdietrich@mvista.com,
       Takeharu KATO <takeharu1219@ybb.ne.jp>, linux-kernel@vger.kernel.org,
       Ingo Molnar <mingo@elte.hu>
In-Reply-To: <1148402326.3535.95.camel@c-67-180-134-207.hsd1.ca.comcast.net>
References: <OF928FB2B7.5CE25C69-ONC1257177.00596B7A-C1257177.005AAA6F@wavecom.fr>
	 <1148402326.3535.95.camel@c-67-180-134-207.hsd1.ca.comcast.net>
Content-Type: text/plain; charset=utf-8
Date: Tue, 23 May 2006 18:44:48 +0200
Message-Id: <1148402688.5239.37.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-05-23 at 09:38 -0700, Daniel Walker wrote:
> On Tue, 2006-05-23 at 18:24 +0200, Yann.LEPROVOST@wavecom.fr wrote:
> > Yeah that's it , I tested with SA_NODELAY and oops disappears, kernel
> > doesn't freeze !!
> > 
> > However, the IRQ 1 line is shared between many peripherals in the
> > AT91RM9200...
> > IRQ 1 is the system interrupt.
> > 
> > From AT91RM9200 datasheet :
> > 
> > "The System Interrupt is the wired-OR of the interrupt signals coming from:
> > • the Memory Controller
> > • the Debug Unit
> > • the System Timer
> > • the Real-Time Clock
> > • the Power Management Controller"
> > 
> 
> You might have some more issues , cause if you share an SA_NODELAY
> handler every handler on that interrupt line becomes an SA_NODELAY
> handler .. So you'll have to go make sure non of those other handlers
> lock spinlock_t types ..

The best solution is probably a demultiplex handler.

	tglx


