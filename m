Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932603AbWEXOEY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932603AbWEXOEY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 May 2006 10:04:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932630AbWEXOEX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 May 2006 10:04:23 -0400
Received: from wmp-pc40.wavecom.fr ([81.80.89.162]:32007 "EHLO
	domino.wavecom.fr") by vger.kernel.org with ESMTP id S932603AbWEXOEX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 May 2006 10:04:23 -0400
In-Reply-To: <1148475334.24623.45.camel@localhost.localdomain>
Subject: Re: Ingo's  realtime_preempt patch causes kernel oops
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Daniel Walker <dwalker@mvista.com>, linux-kernel@vger.kernel.org,
       linux-kernel-owner@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
       Thomas Gleixner <tglx@linutronix.de>
X-Mailer: Lotus Notes Release 6.5.1 January 21, 2004
Message-ID: <OFAE8CA8AC.BA068378-ONC1257178.004C53F7-C1257178.004D4D22@wavecom.fr>
From: Yann.LEPROVOST@wavecom.fr
Date: Wed, 24 May 2006 15:58:18 +0200
X-MIMETrack: Serialize by Router on domino/wavecom(Release 6.5.4|March 27, 2005) at 05/24/2006
 03:58:20 PM
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yeah, I'm using minicom to log in through the serial debug unit, meaning
that there are probably many incoming intterrupts corresponding to input
characters...

Yann



                                                                           
             Steven Rostedt                                                
             <rostedt@goodmis.                                             
             org>                                                       To 
                                       Yann.LEPROVOST@wavecom.fr           
             24/05/2006 14:55                                           cc 
                                       Daniel Walker <dwalker@mvista.com>, 
                                       linux-kernel@vger.kernel.org,       
                                       linux-kernel-owner@vger.kernel.org, 
                                       Ingo Molnar <mingo@elte.hu>, Thomas 
                                       Gleixner <tglx@linutronix.de>       
                                                                   Subject 
                                       Re: Ingo's  realtime_preempt patch  
                                       causes kernel oops                  
                                                                           
                                                                           
                                                                           
                                                                           
                                                                           
                                                                           




On Wed, 2006-05-24 at 10:06 +0200, Yann.LEPROVOST@wavecom.fr wrote:
> The debug serial unit is part of the mainline kernel, this is the common
> link to work with the CSB637 Cogent board.
> I don't know about others AT91RM9200 based board.
>
> AT91RM9200 also have others USART, but there are no available output
> connectors on the CSB637 board.
>

Hi Yann,

OK, do you only get the prints from the serial? If so than that is OK,
but if you also log in through the serial, then that is a problem.  In
other words, do you have something like mgetty running to log in through
the serial?

Looking at the at91_interrupt it can call mutex spin_locks if receiving
data. So this needs care.

Thomas or Ingo,

Maybe the handling of IRQs needs to handle the case that shared irq can
have both a NODELAY and a thread.  The irq descriptor could have a
NODELAY set if any of the actions are NODELAY, but before calling the
interrupt handler (in interrupt context), check if the action is NODELAY
or not, and if not, wake up the thread if not done so already.

thoughts?

-- Steve




