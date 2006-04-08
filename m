Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965019AbWDHQbk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965019AbWDHQbk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Apr 2006 12:31:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965021AbWDHQbk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Apr 2006 12:31:40 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:38531 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S965019AbWDHQbk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Apr 2006 12:31:40 -0400
Subject: Re: [PATCH 2.6.16] Shared interrupts sometimes lost
From: Lee Revell <rlrevell@joe-job.com>
To: Neil Brown <neilb@suse.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <17463.14285.31029.943738@cse.unsw.edu.au>
References: <17463.14285.31029.943738@cse.unsw.edu.au>
Content-Type: text/plain
Date: Sat, 08 Apr 2006 12:31:36 -0400
Message-Id: <1144513897.22490.154.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-04-08 at 14:10 +1000, Neil Brown wrote:
> 
>  To explain what I think is happening, let me start with a very simple
>  case.  A number of PCI devices (this one included) have a number of
>  events which can trigger an interrupt.  The events which are current
>  are presented as bits in a register, and are ORed together (and
>  possibly masked by another register) to make the IRQ line.
>  When 1's are written to any bits in this register, it acknowledges
>  the event and clears the bit.
>  A typical code fragment is 
>    events = read_register(INTERRUPTS);
>    write_register(INTERRUPTS, events);
>    ... handle each 1 bits in events ....
> 

Isn't a more typical IRQ handler:

while (events = read_register(INTERRUPTS) != 0) {
	...handle each bit in events and ACK it...
}

Lee

