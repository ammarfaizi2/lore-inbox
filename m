Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750816AbWEWQiv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750816AbWEWQiv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 May 2006 12:38:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750863AbWEWQiv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 May 2006 12:38:51 -0400
Received: from gateway-1237.mvista.com ([63.81.120.158]:57930 "EHLO
	gateway-1237.mvista.com") by vger.kernel.org with ESMTP
	id S1750816AbWEWQit (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 May 2006 12:38:49 -0400
Subject: Re: Ingo's  realtime_preempt patch causes kernel oops
From: Daniel Walker <dwalker@mvista.com>
To: Yann.LEPROVOST@wavecom.fr
Cc: sdietrich@mvista.com, Takeharu KATO <takeharu1219@ybb.ne.jp>,
       linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
       Ingo Molnar <mingo@elte.hu>
In-Reply-To: <OF928FB2B7.5CE25C69-ONC1257177.00596B7A-C1257177.005AAA6F@wavecom.fr>
References: <OF928FB2B7.5CE25C69-ONC1257177.00596B7A-C1257177.005AAA6F@wavecom.fr>
Content-Type: text/plain; charset=utf-8
Date: Tue, 23 May 2006 09:38:45 -0700
Message-Id: <1148402326.3535.95.camel@c-67-180-134-207.hsd1.ca.comcast.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-05-23 at 18:24 +0200, Yann.LEPROVOST@wavecom.fr wrote:
> Yeah that's it , I tested with SA_NODELAY and oops disappears, kernel
> doesn't freeze !!
> 
> However, the IRQ 1 line is shared between many peripherals in the
> AT91RM9200...
> IRQ 1 is the system interrupt.
> 
> From AT91RM9200 datasheet :
> 
> "The System Interrupt is the wired-OR of the interrupt signals coming from:
> • the Memory Controller
> • the Debug Unit
> • the System Timer
> • the Real-Time Clock
> • the Power Management Controller"
> 

You might have some more issues , cause if you share an SA_NODELAY
handler every handler on that interrupt line becomes an SA_NODELAY
handler .. So you'll have to go make sure non of those other handlers
lock spinlock_t types ..

Daniel

