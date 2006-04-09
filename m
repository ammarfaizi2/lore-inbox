Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750843AbWDISYn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750843AbWDISYn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Apr 2006 14:24:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750844AbWDISYn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Apr 2006 14:24:43 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:50636 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1750842AbWDISYm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Apr 2006 14:24:42 -0400
Subject: Re: [PATCH 2.6.16] Shared interrupts sometimes lost
From: Lee Revell <rlrevell@joe-job.com>
To: Robert Hancock <hancockr@shaw.ca>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <44394EA6.3000309@shaw.ca>
References: <5Zd5E-3vi-7@gated-at.bofh.it> <5ZoDL-3rE-7@gated-at.bofh.it>
	 <44394EA6.3000309@shaw.ca>
Content-Type: text/plain
Date: Sun, 09 Apr 2006 14:24:36 -0400
Message-Id: <1144607077.22490.204.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-04-09 at 12:12 -0600, Robert Hancock wrote:
> Lee Revell wrote: 
> > Isn't a more typical IRQ handler:
> > 
> > while (events = read_register(INTERRUPTS) != 0) {
> >       ...handle each bit in events and ACK it...
> > }
> 
> That would be less efficient, it would read the register twice or more
> if any events have been set, and reading device registers can be 
> expensive. In the unlikely event the event was set while inside the
> ISR the interrupt should be asserted again so there is no need to do
> this. 

OK.  FWIW I am looking at the emu10k1 driver (though I've seen this in
others).  The OSS driver has this comment:

    /*
     ** NOTE :
     ** We do a 'while loop' here cos on certain machines, with both
     ** playback and recording going on at the same time, IRQs will
     ** stop coming in after a while. Checking IPND indeed shows that
     ** there are interrupts pending but the PIC says no IRQs pending.
     ** I suspect that some boards need edge-triggered IRQs but are not
     ** getting that condition if we don't completely clear the IPND
     ** (make sure no more interrupts are pending).
     ** - Eric
     */

The ALSA driver preserves the while loop but omits the comment :-/

Lee



